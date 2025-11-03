class Movement < ApplicationRecord
  belongs_to :item
  belongs_to :user
  belongs_to :from_box, class_name: "Box", optional: true
  belongs_to :to_box, class_name: "Box", optional: true

  validates :action, presence: true
end
