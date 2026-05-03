class Medicine < ApplicationRecord
  include TenantScoped

  belongs_to :tenant

  has_many :inventory_items
  has_many :prescription_items
end
