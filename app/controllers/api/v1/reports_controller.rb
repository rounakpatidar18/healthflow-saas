class Api::V1::ReportsController < ApplicationController
  def revenue
    data = Rails.cache.fetch("revenue_report_#{Current.tenant.id}", expires_in: 10.minutes) do
      Invoice.paid.group("DATE(created_at)").sum(:amount)
    end

    render json: { revenue: data }
  end

  def patient_visits
    data = Appointment.group("DATE(appointment_time)").count

    render json: { visits: data }
  end

  def medicine_usage
    data = PrescriptionItem
            .joins(:medicine)
            .group("medicines.name")
            .sum(:quantity)

    render json: { usage: data }
  end
end
