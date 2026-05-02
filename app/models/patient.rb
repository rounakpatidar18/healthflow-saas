class Patient < ApplicationRecord
  include TenantScoped

  has_many :appointments
end
