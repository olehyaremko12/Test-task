# frozen_string_literal: true

root to: 'message#new'
post '/message', to: 'message#create'
get '/message/:safelink', to: 'message#show'
delete '/message/:safelink', to: 'message#destroy', as: :destroy_message
