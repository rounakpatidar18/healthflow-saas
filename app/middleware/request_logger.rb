class RequestLogger
  def initialize(app)
    @app = app
  end

  def call(env)
    request = ActionDispatch::Request.new(env)

    Rails.logger.info({
      path: request.path,
      method: request.request_method,
      tenant_id: Current.tenant&.id
    })

    @app.call(env)
  end
end
