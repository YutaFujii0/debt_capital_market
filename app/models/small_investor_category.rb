class SmallInvestorCategory < ApplicationRecord
  belongs_to :large_investor_id
  has_many :investors
  # no need to dependent: :destroy
end
