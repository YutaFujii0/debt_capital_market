class Deal < ApplicationRecord
  belongs_to :issuer
  belongs_to :deal_category
  has_many :tranches, dependent: :destroy
end
