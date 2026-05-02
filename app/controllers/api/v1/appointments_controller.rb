class Api::V1::AppointmentsController < ApplicationController
  def create
    result = Appointments::CreateAppointment.new(params, Current.user).call

    if result[:success]
      render json: result[:data], status: :created
    else
      render json: { errors: result[:errors] }, status: :unprocessable_entity
    end
  end
end
