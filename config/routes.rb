Rails.application.routes.draw do
  devise_for :users

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      root to: 'deals#index'

      resources :issuers
      resources :investors
      resources :user_issuers, only: [:edit, :update, :destroy]
      resources :user_deals, only: [:edit, :update, :destroy]
      resources :user_investors, only: [:index, :edit, :update, :destroy]
      resources :treasuries

      resources :deals do
        resources :tranches, only: [:index, :create] do
          resources :marketings, only: [:index, :show, :new, :create] do
            resources :feedbacks, only: [:index, :show, :new, :create] do
              resources :orders, only: [:new, :create]
            end
          end
          resources :very_important_investors, only: [:index, :new, :create]
        end
      end

      resource :trahches, only: [:edit, :update, :destroy]
      resource :marketings, only: [:edit, :update, :destroy]
      resource :feedbacks, only: [:edit, :update, :destroy]
      resource :very_important_investors, only: [:destroy]
    end
  end


  # issuers
  # -later, add history method that show all issues of a specific issuer
  # user_issuers
  # - #index: no need. meaningless to show index
  # - #show: no need. meaningless to show
  # - #new/#create: no need. issuer#new includes user_issuer input
  # user_deals
  # - #index: no need. meaningless to show index
  # - #show: no need. meaningless to show
  # - #new/#create: no need. deals#new includes user_deals input
  # very_important_investors
  # - #show: no need. meaningless to show
  # - #edit/#update: no need. to edit means to delete cuz this is a simple joint-table
  # user_investors
  # - #show: no need. meaningless to show
  # - #new/#create: no need. investor#new includes user_investor input

  # deal
  # - #index :landing page
  # tranche
  # - #show: no need. We'll never see specific show page.
  # - #new: no need. deal#new page includes tranche#new
  # marketings
  # - all methods
  # feedbacks
  # - all methods

end
