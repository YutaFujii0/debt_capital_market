class Marketing < ApplicationRecord
  belongs_to :tranche
  has_many :feedbacks, dependent: :destroy
  has_many :orders, through: :feedbacks, dependent: :destroy
end
