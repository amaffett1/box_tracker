class AddCodeToItems < ActiveRecord::Migration[8.1]
  def change
    add_column :items, :code, :string
  end
end
