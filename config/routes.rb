Rails.application.routes.draw do

  post '/prices', to: 'prices#create', as: 'prices_create', defaults: { format: 'json' }

end
