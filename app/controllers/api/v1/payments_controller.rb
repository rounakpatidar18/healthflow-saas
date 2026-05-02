class Api::V1::PaymentsController < ApplicationController
  def create
    result = Payments::ProcessPayment.new(payment_params, request.headers).call

    if result[:success]
      render json: result[:data], status: :ok
    else
      render json: { error: result[:error] }, status: :unprocessable_entity
    end
  end

  private

  def payment_params
    params.permit(:invoice_id)
  end
end
