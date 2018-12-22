class Tranche < ApplicationRecord
  belongs_to :deal
  belongs_to :treasury
  has_many :marketings, dependent: :destroy
  has_many :feedbacks, through: :marketings
  has_many :orders, through: :feedbacks
  has_many :very_important_investors, dependent: :destroy
end
