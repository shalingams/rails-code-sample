class Category < ApplicationRecord
  belongs_to :vertical
  has_many :courses

  validates :name, presence: true
  validates :name, uniqueness: true
  validate :unique_name_across_models

  private

  def unique_name_across_models
    if Vertical.exists?(name: name)
      errors.add(:name, "must be unique across Category and Vertical")
    end
  end
end
