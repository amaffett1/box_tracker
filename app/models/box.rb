class Box < ApplicationRecord
  belongs_to :user
  belongs_to :parent_box, class_name: "Box", optional: true

  has_many :sub_boxes, class_name: "Box", foreign_key: "parent_box_id", dependent: :destroy
  has_many :items, dependent: :destroy
  has_many_attached :images

  validates :name, :code, presence: true
end
