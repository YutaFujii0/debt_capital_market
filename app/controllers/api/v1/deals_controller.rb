class Api::V1::DealsController < Api::V1::BaseController
  def index
    @deals = Deal.all
    render json: @deals
  end
end
