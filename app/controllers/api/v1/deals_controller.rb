class DealsController < ApplicationController
  def index
    @deals = Deal.all
    render json: @deals
  end
end
