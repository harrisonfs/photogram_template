Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root :to => "entries#index"
  # Routes for the Entry resource:

  # CREATE
  get("/entries/new", { :controller => "entries", :action => "new_form" })
  post("/create_entry", { :controller => "entries", :action => "create_row" })

  # READ
  get("/entries", { :controller => "entries", :action => "index" })
  get("/entries/:id_to_display", { :controller => "entries", :action => "show" })

  # UPDATE
  get("/entries/:prefill_with_id/edit", { :controller => "entries", :action => "edit_form" })
  post("/update_entry/:id_to_modify", { :controller => "entries", :action => "update_row" })

  # DELETE
  get("/delete_entry/:id_to_remove", { :controller => "entries", :action => "destroy_row" })
  get("/delete_entry_from_owner/:id_to_remove", { :controller => "entries", :action => "destroy_row_from_owner" })

  #------------------------------

  devise_for :users
  # Routes for the User resource:

  # READ
  get("/users", { :controller => "users", :action => "index" })
  get("/users/:id_to_display", { :controller => "users", :action => "show" })

  #------------------------------

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
