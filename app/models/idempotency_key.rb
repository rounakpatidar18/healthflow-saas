class IdempotencyKey < ApplicationRecord
  include TenantScoped

  belongs_to :tenant
  validates :key, presence: true, uniqueness: true
end
