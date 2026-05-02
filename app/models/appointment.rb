class Appointment < ApplicationRecord
  include TenantScoped

  belongs_to :tenant
  belongs_to :patient
  belongs_to :doctor, class_name: "User"

  enum :status, { scheduled: 0, completed: 1, cancelled: 2 }

  validates :appointment_time, presence: true
  validate :no_double_booking

  private

  def no_double_booking
    return unless appointment_time && doctor_id

    conflict = Appointment.where(doctor_id: doctor_id)
                          .where(appointment_time: appointment_time)
                          .where.not(id: id)
                          .exists?

    if conflict
      errors.add(:appointment_time, "Doctor already has an appointment at this time")
    end
  end
end
