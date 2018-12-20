class UserIssuer < ApplicationRecord
  belongs_to :user
  belongs_to :issuer
end
