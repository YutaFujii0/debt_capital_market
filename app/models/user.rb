class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ROLE = {
    "Origination": 0,
    "Syndication": 1,
    "Sales": 2
  }

  validates :role, inclusion: {in: ROLE.values}
end
