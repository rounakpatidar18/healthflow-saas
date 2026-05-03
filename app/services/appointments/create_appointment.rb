module Appointments
  class CreateAppointment
    def initialize(params, current_user)
      @params = params
      @current_user = current_user
    end

    def call
      ActiveRecord::Base.transaction do
        appointment = Appointment.new(filtered_params)
        appointment.tenant_id = Current.tenant.id

        if appointment.save
          SendAppointmentReminderJob.set(wait_until: appointment.appointment_time - 1.hour)
                                    .perform_later(appointment.id)

          success(appointment)
        else
          failure(appointment.errors.full_messages)
        end
      end
    rescue => e
      failure([ e.message ])
    end

    private

    def filtered_params
      @params.slice(:patient_id, :doctor_id, :appointment_time, :status)
    end

    def success(data)
      { success: true, data: data }
    end

    def failure(errors)
      { success: false, errors: errors }
    end
  end
end
