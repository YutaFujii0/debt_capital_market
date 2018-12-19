class UserInvestor < ApplicationRecord
  belongs_to :user
  belongs_to :investor
end
