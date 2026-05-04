class Api::V1::PrescriptionsController < Api::V1::BaseController
  def create
    result = Prescriptions::CreatePrescription.new(prescription_params, Current.user).call

    if result[:success]
      render json: result[:data], status: :created
    else
      render json: { error: result[:error] }, status: :unprocessable_entity
    end
  end

  private

  def prescription_params
    params.require(:prescription).permit(
      :patient_id,
      items: [ :medicine_id, :dosage, :quantity ]
    )
  end
end
