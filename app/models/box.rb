class Box < ApplicationRecord
  belongs_to :user
  has_many :items, dependent: :destroy

  has_one_attached :image

  validates :name, :code, presence: true
end
