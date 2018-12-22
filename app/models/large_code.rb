class LargeCode < ApplicationRecord
  has_many :small_codes, dependent: :destroy

  validates :name, presence: true
end
