class Api::V1::BaseController < ActionController::API
  include SetCurrentTenant
  include AuthorizeRequest
end
