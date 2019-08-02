Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :customers, only: [:index, :create]
  put '/customers/order', to: 'customers#update'
  
  post '/orders', to: 'orders#createOrder'
  
  #Restful syntax 
  get '/orders/:id', to: 'orders#getOrder'
  
  #Query string syntax for email or customerId [array -> possibly many orders] 
  #customer?customerId=  || customer?email= 
  get '/orders', to: 'orders#getData'   #<--Maybe choose better method name?
  

end
