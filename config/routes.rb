Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  get 'admin/csv', :to => 'admin#index'
  post 'admin/csv', :to => 'admin#import'
  delete "admin/empty_db", :to => 'admin#empty'
  get 'admin/csv/edit', :to => 'admin#edit_employee'
  get 'employee/', :to => 'employee#index'
  post 'employee/', :to => 'employee#login'
  post 'admin/csv/update', :to => 'admin#update'
  post 'admin/csv/change', :to => 'admin#change'
  get 'employee/match', :to => 'employee#match'
  get 'employee/spinner', :to => 'employee#spinner'
  get 'employee/match/:index_id', :to => 'employee#update'
  get 'employee/paired', :to => 'employee#paired'
  root :to  => "employee#index"

end