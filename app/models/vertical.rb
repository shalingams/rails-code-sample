class Vertical < ApplicationRecord
  has_many :categories
  has_many :courses, through: :categories

  validates :name, presence: true
  validates :name, uniqueness: true
  validate :unique_name_across_models

  private

  def unique_name_across_models
    if Category.exists?(name: name)
      errors.add(:name, "must be unique across Vertical and Category")
    end
  end
end
