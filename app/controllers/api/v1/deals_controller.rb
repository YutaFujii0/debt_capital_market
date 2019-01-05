class Api::V1::DealsController < Api::V1::BaseController
  def index
    @deals = Deal.all
    # @tranches = @deals.first.tranches
    render json: {
      deals: @deals.to_json(
        include: [
          tranches:
            { include: [
              marketings:
                { include: { feedbacks:
                  { include: [
                    :investor,
                    :orders
                  ] }
                }},
              treasury: {}
            ] },
          issuer: { only: :name },
          deal_category: { only: :name }
        ]
      ),
      investors: Investor.all.to_json
    }

  end
end
