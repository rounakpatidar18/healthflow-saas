class Prescription < ApplicationRecord
  include TenantScoped

  belongs_to :patient
  belongs_to :tenant
  belongs_to :doctor, class_name: "User"

  has_many :prescription_items, dependent: :destroy
end
