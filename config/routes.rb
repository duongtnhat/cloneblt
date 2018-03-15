Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'btl#index'
  get '/:id/:name', to: 'btl#story' , :constraints => { :id => /\d+/ }
  get '/:id/:name', to: 'btl#chapter' , :constraints => { :id => /c\d+/ }
end
