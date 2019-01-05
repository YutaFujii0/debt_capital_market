class Api::V1::DealsController < Api::V1::BaseController
  def index
    @deals = Deal.all
    # @tranches = @deals.first.tranches
    render json: {
      deals: @deals.as_json(
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
          issuer: { include: :users },
          deal_category: { only: :name },
          users: { only: [:first_name, :last_name, :tel, :email, :role] }
        ]
      ),
      investors: Investor.all.as_json({ include: :users })
    }

  end
end
