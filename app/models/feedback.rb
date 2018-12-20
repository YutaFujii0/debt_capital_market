class Feedback < ApplicationRecord
  belongs_to :investor
  belongs_to :marketing
  has_many :orders, dependent: :destroy
end
