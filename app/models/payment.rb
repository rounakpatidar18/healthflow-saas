class Payment < ApplicationRecord
  include TenantScoped

  enum :status, { initiated: 0, success: 1, failed: 2 }

  belongs_to :invoice
  belongs_to :tenant

  validates :idempotency_key, presence: true, uniqueness: true
end
