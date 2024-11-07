require 'elasticsearch/model'

class Course < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :category

  validates :name, presence: true
  validates :author, presence: true

  # Define the fields to be indexed in Elasticsearch
  settings do
    mappings dynamic: false do
      indexes :name, type: :text
      indexes :author, type: :text
      indexes :state, type: :keyword
    end
  end

  # Custom search method to query by name or author
  def self.search(query)
    self.__elasticsearch__.search(
      {
        query: {
          multi_match: {
            query: query,
            fields: ['name^2', 'author']
          }
        }
      }
    )
  end
end
