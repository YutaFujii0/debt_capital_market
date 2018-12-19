class VeryImportantInvestor < ApplicationRecord
  belongs_to :tranche
  belongs_to :investor
end
