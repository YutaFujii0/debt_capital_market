class SmallCode < ApplicationRecord
  belongs_to :large_code
  has_many :issuers
  # no need to dependent: :destroy

  validates :name, presence: true
end
