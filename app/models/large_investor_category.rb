class LargeInvestorCategory < ApplicationRecord
  has_many :small_investor_categories, dependent: :destroy
end
