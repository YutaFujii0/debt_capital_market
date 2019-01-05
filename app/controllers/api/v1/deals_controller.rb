class Api::V1::DealsController < Api::V1::BaseController
  def index
    @deals = Deal.all
    # @tranches = @deals.first.tranches
    render json: @deals.to_json(
      include: [
        tranches:
          { include: { marketings:
            { include: { feedbacks:
              { include: :orders }
            }}
          }},
        issuer: { only: :name },
        deal_category: {  }
      ]
    )
  end
end
