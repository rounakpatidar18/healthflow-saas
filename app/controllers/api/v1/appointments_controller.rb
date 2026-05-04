class Api::V1::AppointmentsController < Api::V1::BaseController
  def index
    render json: Appointment.all
  end

  def create
    result = Appointments::CreateAppointment.new(appointment_params, Current.user).call

    if result[:success]
      render json: result[:data], status: :created
    else
      render json: { errors: result[:errors] }, status: :unprocessable_entity
    end
  end

  private

  def appointment_params
    params.require(:appointment).permit(
      :patient_id,
      :doctor_id,
      :appointment_time,
      :status
    )
  end
end
