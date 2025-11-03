json.extract! item, :id, :box_id, :name, :category, :quantity, :position, :notes, :created_at, :updated_at
json.url item_url(item, format: :json)
