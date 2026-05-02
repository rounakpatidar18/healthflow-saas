class User < ApplicationRecord
  has_secure_password

  include TenantScoped
  belongs_to :tenant
  enum :role, { admin: 0, doctor: 1, staff: 2 }

  validates :email, presence: true, uniqueness: true
  validate :tenant_must_match_current

  private

  def tenant_must_match_current
    return unless Current.tenant

    if tenant_id != Current.tenant.id
      errors.add(:tenant_id, "does not match current tenant")
    end
  end
end
