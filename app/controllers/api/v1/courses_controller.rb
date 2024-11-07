# app/controllers/api/v1/courses_controller.rb
module Api
  module V1
    class CoursesController < ApplicationController
      before_action :set_vertical
      before_action :set_category
      before_action :set_course, only: [:show, :update, :destroy]
      before_action :doorkeeper_authorize!
      
      def index
        @courses = @category.courses
        render json: @courses
      end

      def show
        render json: @course
      end

      def create
        @course = @category.courses.new(course_params)
        if @course.save
          render json: @course, status: :created
        else
          render json: @course.errors, status: :unprocessable_entity
        end
      end

      def update
        if @course.update(course_params)
          render json: @course
        else
          render json: @course.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @course.destroy
        head :no_content
      end

      def search
        if params[:query].present?
          @courses = Course.search(params[:query]).records
          render json: @courses
        else
          render json: { error: "Query parameter is missing" }, status: :bad_request
        end
      end

      private

      def set_vertical
        @vertical = Vertical.find(params[:vertical_id])
      end

      def set_category
        @category = @vertical.categories.find(params[:category_id])
      end

      def set_course
        @course = @category.courses.find(params[:id])
      end

      def course_params
        params.require(:course).permit(:name, :author, :category_id)
      end
    end
  end
end
