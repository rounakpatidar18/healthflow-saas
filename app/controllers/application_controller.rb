class ApplicationController < ActionController::API
  include SetCurrentTenant
  include AuthorizeRequest
end
