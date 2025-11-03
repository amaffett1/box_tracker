class User < ApplicationRecord
  # Associations
  has_many :boxes, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Imposta un ruolo di default per ogni nuovo utente
  after_initialize :set_default_role, if: :new_record?

def set_default_role
  self.role ||= "viewer"
end
  has_many :movements, dependent: :nullify
end
