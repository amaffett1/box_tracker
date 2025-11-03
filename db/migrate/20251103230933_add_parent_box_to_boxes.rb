class AddParentBoxToBoxes < ActiveRecord::Migration[8.1]
  def change
    add_column :boxes, :parent_box_id, :integer
  end
end
