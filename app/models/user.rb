class User < ApplicationRecord
  has_many :boxes
  has_many :items, through: :boxes
  has_many :movements

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
