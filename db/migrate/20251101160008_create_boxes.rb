class CreateBoxes < ActiveRecord::Migration[8.1]
  def change
    create_table :boxes do |t|
      t.string :code
      t.string :name
      t.string :location
      t.text :description

      t.timestamps
    end
  end
end
