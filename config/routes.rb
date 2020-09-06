Rails.application.routes.draw do
  get 'slow_calc', controller: 'application'
  get 'slow_request', controller: 'application'
  get 'noop', controller: 'application'
end
