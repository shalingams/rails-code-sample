# app/controllers/api/v1/categories_controller.rb
module Api
  module V1
    class CategoriesController < ApplicationController
      before_action :set_vertical
      before_action :set_category, only: [:show, :update, :destroy]
      before_action :doorkeeper_authorize!

      def index
        @categories = @vertical.categories
        render json: @categories
      end

      def show
        render json: @category
      end

      def create
        @category = @vertical.categories.new(category_params)
        puts "===#{@category}"
        if @category.save
          render json: @category, status: :created
        else
          render json: @category.errors, status: :unprocessable_entity
        end
      end

      def update
        if @category.update(category_params)
          render json: @category
        else
          render json: @category.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @category.destroy
        head :no_content
      end

      private

      def set_vertical
        @vertical = Vertical.find(params[:vertical_id])
      end

      def set_category
        @category = @vertical.categories.find(params[:id])
      end

      def category_params
        params.require(:category).permit(:name, :vertical_id, :state)
      end
    end
  end
end
