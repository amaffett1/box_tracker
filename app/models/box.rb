# encoding: utf-8
class Box < ApplicationRecord
  belongs_to :user
  belongs_to :parent, class_name: 'Box', optional: true
  has_many   :children, class_name: 'Box', foreign_key: :parent_id, dependent: :nullify

  has_many :items, dependent: :destroy

  # Più immagini per box
  has_many_attached :images

  validates :name, presence: true
end
