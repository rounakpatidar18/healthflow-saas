class SendAppointmentReminderJob < ApplicationJob
  queue_as :default

  def perform(appointment_id)
    appointment = Appointment.find_by(id: appointment_id)
    return unless appointment

    # For now → simulate notification
    Rails.logger.info "Reminder: Appointment ##{appointment.id} for patient #{appointment.patient_id}"

    # Later:
    # SMS / Email integration
  end
end
