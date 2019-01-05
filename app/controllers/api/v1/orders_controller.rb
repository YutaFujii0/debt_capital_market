class OrdersController < ApplicationController
  def index
    @deal = Deal.find(param[:deal_id])
    @tranche = Tranche.find(params[:tranche_id])
    @marketing = Marketing.find(params[:marketing_id])
    @feedback = Feedback.find([:feedback_id])
    @orders = @feedback.orders
    render json: @orders
  end
end
