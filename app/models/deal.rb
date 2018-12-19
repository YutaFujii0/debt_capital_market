class Deal < ApplicationRecord
  belongs_to :issuer
  belongs_to :deal_category
end
