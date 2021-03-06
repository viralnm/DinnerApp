RailsAdmin.config do |config|

  ### Popular gems integration

  # config.site_title = "My Default Site Title"

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :admin
  end
  config.current_user_method(&:current_admin)

  ## == Cancan ==
  # config.authorize_with :cancan

  config.included_models = [ User, Admin, Restaurant,RestaurantPhoto, StaticPage, Food, FoodReview]
  ## == Pundit ==
  # config.authorize_with :pundit
  config.default_items_per_page = 10
  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new do
      except ['Admin','User','RestaurantReview', 'StaticPage', 'FoodReview']
    end
    export
    bulk_delete
    show
    edit do
      except ['User','RestaurantReview','FoodReview']
      end
    delete do
      except ['StaticPage']
    end
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
