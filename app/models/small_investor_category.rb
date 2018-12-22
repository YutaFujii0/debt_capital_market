class SmallInvestorCategory < ApplicationRecord
  belongs_to :large_investor_category
  has_many :investors
  # no need to dependent: :destroy

  validates :name, presence: true
end
