class CreateCourses < ActiveRecord::Migration[7.2]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :author
      t.references :category
      t.string :state
      t.timestamps
    end
  end
end
