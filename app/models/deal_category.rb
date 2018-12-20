class DealCategory < ApplicationRecord
  has_many :deals
  # no need to dependent: :destroy.
end
