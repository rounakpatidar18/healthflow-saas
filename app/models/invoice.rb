class Invoice < ApplicationRecord
  include TenantScoped

  enum :status, { pending: 0, paid: 1, failed: 2 }

  belongs_to :patient
  has_many :payments

  validates :amount, presence: true
end
