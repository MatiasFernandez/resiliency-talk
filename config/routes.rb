Rails.application.routes.draw do
  get 'affected', controller: 'application'
  get 'unaffected', controller: 'application'
end
