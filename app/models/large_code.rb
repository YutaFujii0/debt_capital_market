class LargeCode < ApplicationRecord
  has_many :small_codes, dependent: :destory
end
