import React, { useEffect, useState } from "react";
import API from "../../api/client";

export default function Appointments() {
  const [appointments, setAppointments] = useState([]);

  useEffect(() => {
    loadAppointments();
  }, []);

  const loadAppointments = async () => {
    const res = await API.get("/appointments");
    setAppointments(res.data);
  };

  return (
    <div>
      <h2>Appointments</h2>
      <button onClick={() => window.location.href = "/appointments/new"}>
        + New Appointment
      </button>

      <table>
        <thead>
          <tr>
            <th>Patient</th>
            <th>Doctor</th>
            <th>Time</th>
          </tr>
        </thead>
        <tbody>
          {appointments.map((a) => (
            <tr key={a.id}>
              <td>{a.patient_id}</td>
              <td>{a.doctor_id}</td>
              <td>{a.appointment_time}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}