class Deal < ApplicationRecord
  belongs_to :issuer
  belongs_to :deal_category
  has_many :tranches, dependent: :destroy
  has_many :user_deals, dependent: :destroy
  # No need for dependent: :destroy
  has_many :users, through: :user_deals
end
