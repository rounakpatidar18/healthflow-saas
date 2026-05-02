module SetCurrentTenant
  extend ActiveSupport::Concern

  included do
    before_action :set_tenant
  end

  private

  def set_tenant
    tenant_id = request.headers["X-Tenant-ID"]

    tenant = Tenant.find_by(id: tenant_id)

    if tenant.nil?
      render json: { error: "Tenant not found" }, status: :unprocessable_entity
      return
    end

    Current.tenant = tenant
  end
end
