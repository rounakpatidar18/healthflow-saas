module Prescriptions
  class CreatePrescription
    def initialize(params, current_user)
      @params = params
      @current_user = current_user
    end

    def call
      ActiveRecord::Base.transaction do
        prescription = Prescription.create!(
          patient_id: @params[:patient_id],
          doctor_id: @current_user.id,
          tenant_id: Current.tenant.id
        )

        items = @params[:items]

        prescription_items = items.map do |item|
          PrescriptionItem.create!(
            prescription: prescription,
            medicine_id: item[:medicine_id],
            dosage: item[:dosage],
            quantity: item[:quantity],
            tenant_id: Current.tenant.id
          )
        end

        inventory_result = Inventory::UpdateInventory.new(items).call

        unless inventory_result[:success]
          raise inventory_result[:error]
        end

        { success: true, data: prescription }
      end
    rescue => e
      { success: false, error: e.message }
    end
  end
end
