class CreateMovements < ActiveRecord::Migration[7.1]
  def change
    create_table :movements do |t|
      t.references :item, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      # queste due righe collegano alla tabella boxes, non from_boxes
      t.references :from_box, foreign_key: { to_table: :boxes }
      t.references :to_box, foreign_key: { to_table: :boxes }

      t.string :action
      t.text :notes

      t.timestamps
    end
  end
end
