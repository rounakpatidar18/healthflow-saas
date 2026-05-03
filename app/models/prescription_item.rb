class PrescriptionItem < ApplicationRecord
  include TenantScoped

  belongs_to :tenant
  belongs_to :prescription
  belongs_to :medicine
end
