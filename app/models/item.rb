# encoding: utf-8

class Item < ApplicationRecord
  belongs_to :box
  has_many :movements, dependent: :destroy

  has_one_attached :image

  validates :name, :code, presence: true
end
