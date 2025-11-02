class CreateItems < ActiveRecord::Migration[8.1]
  def change
    create_table :items do |t|
      t.references :box, null: false, foreign_key: true
      t.string :name
      t.string :category
      t.integer :quantity
      t.string :position
      t.text :notes

      t.timestamps
    end
  end
end
