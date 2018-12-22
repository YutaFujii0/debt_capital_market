class Investor < ApplicationRecord
  belongs_to :small_investor_category
  has_many :users, through: :user_investors
  has_many :tranches, through: :very_important_investors
  # no need to dependent: :destory
  has_many :very_important_investors, dependent: :destroy
end
