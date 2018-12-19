class Tranche < ApplicationRecord
  belongs_to :deal
  belongs_to :treasury
end
