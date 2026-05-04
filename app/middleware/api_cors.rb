class ApiCors
  ALLOWED_METHODS = "GET, POST, PUT, PATCH, DELETE, OPTIONS, HEAD"
  ALLOWED_HEADERS = "Origin, Content-Type, Accept, Authorization, X-Tenant-ID, Idempotency-Key, X-Requested-With"
  EXPOSED_HEADERS = "Authorization"

  def initialize(app)
    @app = app
  end

  def call(env)
    request = ActionDispatch::Request.new(env)
    return @app.call(env) unless request.path.start_with?("/api/")

    origin = request.headers["Origin"]
    cors_headers = build_cors_headers(origin)

    if request.request_method == "OPTIONS"
      [ 204, cors_headers, [] ]
    else
      status, headers, body = @app.call(env)
      [ status, headers.merge(cors_headers), body ]
    end
  end

  private

  def build_cors_headers(origin)
    return {} if origin.blank?

    {
      "Access-Control-Allow-Origin" => origin,
      "Access-Control-Allow-Methods" => ALLOWED_METHODS,
      "Access-Control-Allow-Headers" => ALLOWED_HEADERS,
      "Access-Control-Expose-Headers" => EXPOSED_HEADERS,
      "Access-Control-Max-Age" => "86400",
      "Vary" => "Origin"
    }
  end
end
