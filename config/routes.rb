EsiVcu::Application.routes.draw do
  resource :testing_pdf
  resources :medicaid_fpl_based_income_limits

  resources :chart_results

  resources :charts

  get "activations/create"

  get "confirm/show"
  
  match '/cases/open/:id', :to => 'cases#open', :as => 'open_case'
  match '/cases/:case_id/situations/:id/accept', :to=> 'situations#accept', :as=>'accept_question', :via=> [:post, :put]
  match '/cases/:case_id/situations/:id/continue', :to=> 'situations#continue', :as=>'continue_situation', :via=> [:post, :put]
  match '/cases/:case_id/numeric_results', :to=> 'situations#numeric_results', :as=>'numeric_results', :via=>:get
  match '/cases/:case_id/text_results', :to=> 'situations#text_results', :as=>'text_results', :via=>:get
  match '/cases/:case_id/situations/:id/delete', :to=> 'situations#delete', :as=>"delete_situation", :via=>:get
  match '/cases/:case_id/graphic_results', :to=>'situations#graphic_results', :as=>'graphic_results', :via=>:get
  match '/cases/:id/save_as', :to => 'cases#save_as', :as => 'case_saveas', :via=>:get
  match '/cases/:id/copy_to', :to=> 'cases#copy_to', :as=>'case_copyto', :via=>[:post,:put]
  match '/cases/share', :to=>'cases#share', :as=>'cases_share', :via=>:get
  match '/cases/commit_share', :to=>'cases#commit_share', :as=>'cases_commit_share', :via=>[:post,:put]
  match '/cases/all/:id', :to=>'cases#all', :as=>'cases_all_inputs', :via=>:get
  match '/cases/:id/notes', :to=>'cases#notes', :as=>'case_notes', :via=>:get
  match '/cases/:case_id/situations/:id/accept_all', :to=>'situations#accept_all', :as=>'accept_all', :via=>[:post, :put]
  match '/cases/:case_id/situations/:id/questions/:question_name', :to=>'situations#edit_one', :as=>'situations_edit_one', :via=>:get
  match '/cases/:id/delete', :to=>'cases#delete', :as=>'delete_case', :via=>:get
  match '/cases/:id/print', :to=> 'cases#print', :as=> 'cases_print', :via=>:get
  
  resources :cases do
    resources :situations
  end
  
  resources :va_medicaid_rates
  resources :va_max_auxiliary_grant_facility_rates
  resources :medicaid_annual_blind_thresholds
  resources :medicaid_annual_thresholds
  resources :federal_poverty_levels
  resources :federal_rates
  resources :va_medically_needy_monthly_income_limits
  resources :text_result_inserts
  
  resources :web_numerical_results
  resources :web_numerical_results_groups
  resources :web_text_results
  resources :web_text_results_groups
  
  resources :web_calcs
  resources :web_tips
  resources :web_tip_inserts
  resources :question_groups
  resources :questions
  resources :question_inserts
  resources :question_validation_inserts
  resources :county_or_cities

  match '/login', :to => 'user_sessions#new', :as => 'login'
  match '/logout', :to => 'user_sessions#destroy', :as => 'logout'
  match '/register', :to => 'users#new'
  match '/activate/:token', :to=> 'activations#create', :as=> 'activation'
  match '/registration_confirmation', :to=> 'users#registration_confirmation', :as=> 'registration_confirmation'
  resources :users
  match 'user/confirm/:id', :to => 'users#confirm', :as => 'user_confirm'
  match 'user/:id/activate', :to=>'users#activate', :as=>'activate_user', :via=>:post

  get 'help/topic/:topic', :to=> 'helps#show', :as=> 'topic_help', :constraints=>{:topic=>/[a-zA-Z0-9_\-+\s]+/}
  resources :helps

  resources :user_sessions
  resources :account, :controller => 'users'
  
  resources :pages, :controller => 'pages'
  

 # match '/situations/answers/:group_id', :to => 'situations#answers'
 # match '/situations/questions/:situation_id', :to => 'situations#questions'
 # match '/situations', :to => 'situations#index'
 # match '/situations/:action', :to => 'situations'

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # root :to => "welcome"
  root :to => 'application#home_check'

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  match '/:controller(/:action(:/id))'
end
