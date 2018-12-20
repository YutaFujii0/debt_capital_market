class Issuer < ApplicationRecord
  belongs_to :small_code
  has_many :users, through: :user_issuers
  # no need to dependent: :destroy
  has_many :deals, dependent: :destroy
end
