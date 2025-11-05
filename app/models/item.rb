# encoding: utf-8
class Item < ApplicationRecord
  belongs_to :box
  has_many :movements, dependent: :destroy

  # DA: has_one_attached :image
  # A:  più immagini per item
  has_many_attached :images

  validates :name, :code, presence: true
end
