Rails.application.routes.draw do

  mount ActionCable.server => '/cable'
  
	devise_for :users, controllers: {registrations: "users/registrations",passwords: "users/passwords",sessions: "users/sessions"}
  # You can have the root of your site routed with "root"
  root to: 'dashboards#index'

  get "dashboards/index"

  resources :walk_ins do
    member do
      post :change_status
      post :mark_checkin
      post :send_message
      post :stop_sequence
    end
  end

  resources :subscriptions do
    collection do
      post :create_customer
    end
  end

  resources :settings do
    collection do
      get :profile
      post :update_profile
    end
  end

  resources :reservations do
    member do
      post :change_status
    end

    collection do
      # removed import feature for now
      # get :import
      post :upload
    end
  end

  resources :reports do
    collection do
      get :customer_csv
    end
  end

  resources :messages do
    collection do
      post :send_in_bulk
    end
  end

  resources :message_templates do
    collection do
      post :update_order
    end
  end

  get "pricing" => "pages#pricing"

  # All theme routes
  get "dashboards/dashboard_1"
  get "dashboards/dashboard_2"
  get "dashboards/dashboard_3"
  get "dashboards/dashboard_4"
  get "dashboards/dashboard_4_1"

  get "layoutsoptions/index"

  get "graphs/flot"
  get "graphs/morris"
  get "graphs/rickshaw"
  get "graphs/chartjs"
  get "graphs/peity"
  get "graphs/sparkline"

  get "mailbox/inbox"
  get "mailbox/email_view"
  get "mailbox/compose_email"
  get "mailbox/email_templates"
  get "mailbox/basic_action_email"
  get "mailbox/alert_email"
  get "mailbox/billing_email"

  get "widgets/index"

  get "forms/basic_forms"
  get "forms/advanced"
  get "forms/wizard"
  get "forms/file_upload"
  get "forms/text_editor"

  get "appviews/contacts"
  get "appviews/profile"
  get "appviews/projects"
  get "appviews/project_detail"
  get "appviews/file_menager"
  get "appviews/calendar"
  get "appviews/faq"
  get "appviews/timeline"
  get "appviews/pin_board"

  get "pages/search_results"
  get "pages/lockscreen"
  get "pages/invoice"
  get "pages/invoice_print"
  get "pages/login"
  get "pages/login_2"
  get "pages/register"
  get "pages/not_found_error"
  get "pages/internal_server_error"
  get "pages/empty_page"

  get "miscellaneous/notification"
  get "miscellaneous/nestablelist"
  get "miscellaneous/timeline_second_version"
  get "miscellaneous/forum_view"
  get "miscellaneous/forum_post_view"
  get "miscellaneous/google_maps"
  get "miscellaneous/code_editor"
  get "miscellaneous/modal_window"
  get "miscellaneous/validation"
  get "miscellaneous/tree_view"
  get "miscellaneous/chat_view"

  get "uielements/typography"
  get "uielements/icons"
  get "uielements/draggable_panels"
  get "uielements/buttons"
  get "uielements/video"
  get "uielements/tables_panels"
  get "uielements/notifications_tooltips"
  get "uielements/badges_labels_progress"

  get "gridoptions/index"

  get "tables/static_tables"
  get "tables/data_tables"
  get "tables/jqgrid"

  get "gallery/basic_gallery"
  get "gallery/bootstrap_carusela"

  get "cssanimations/index"
end
