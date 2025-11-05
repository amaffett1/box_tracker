class AddParentToBoxes < ActiveRecord::Migration[7.1]
  def change
    add_reference :boxes, :parent, foreign_key: { to_table: :boxes }, null: true
    # add_index :boxes, :parent_id
  end
end
