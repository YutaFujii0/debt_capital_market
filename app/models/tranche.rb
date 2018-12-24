class Tranche < ApplicationRecord
  belongs_to :deal
  belongs_to :treasury
  has_many :marketings, dependent: :destroy
  has_many :feedbacks, through: :marketings
  has_many :orders, through: :feedbacks
  has_many :very_important_investors, dependent: :destroy

  INTEREST_TYPE = {
    0 => "変動",
    1 => "固定",
    2 => "当初5年固定、以後変動"
  }

  RESTRICTION = {
    0 => "適格機関投資家限定",
    1 => "特定投資家限定",
    2 => "制約なし",
    3 => "リテール"
  }

  def reckon_coupon
    treasury.cmp_interest + spread * 0.0001
  end
end
