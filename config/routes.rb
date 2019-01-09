Rails.application.routes.draw do
  root 'btl#index'
  get '/:id/:name', to: 'btl#story', constraints: { id: /\d+/ }, as: :story
  get '/:id/:name', to: 'btl#chapter', constraints: { id: /c\d+/ }, as: :chapter
  get '/:page', to: 'btl#index', constraints: { page: /page-\d+/ }, as: :page
  get '/timkiem', to: 'btl#search', as: :search
end
