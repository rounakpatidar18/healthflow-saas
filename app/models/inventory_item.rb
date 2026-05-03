class InventoryItem < ApplicationRecord
  include TenantScoped

  belongs_to :tenant
  belongs_to :medicine

  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
end
