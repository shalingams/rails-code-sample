class CreateCategories < ActiveRecord::Migration[7.2]
  def change
    create_table :categories do |t|
      t.string :name
      t.references :vertical
      t.string :state

      t.index :name, unique: true

      t.timestamps
    end
  end
end
