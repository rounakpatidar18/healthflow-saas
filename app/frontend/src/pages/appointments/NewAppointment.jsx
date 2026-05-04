import React, { useState } from "react";
import API from "../../api/client";
import { useNavigate } from "react-router-dom";

export default function NewAppointment() {
  const [form, setForm] = useState({
    patient_id: "",
    doctor_id: "",
    appointment_time: "",
  });

  const navigate = useNavigate();

  const handleSubmit = async (e) => {
    e.preventDefault();

    await API.post("/appointments", {
      appointment: form,
    });

    navigate("/appointments");
  };

  return (
    <div>
      <h2>Create Appointment</h2>

      <form onSubmit={handleSubmit}>
        <input
          placeholder="Patient ID"
          onChange={(e) => setForm({ ...form, patient_id: e.target.value })}
        />

        <input
          placeholder="Doctor ID"
          onChange={(e) => setForm({ ...form, doctor_id: e.target.value })}
        />

        <input
          type="datetime-local"
          onChange={(e) =>
            setForm({ ...form, appointment_time: e.target.value })
          }
        />

        <button type="submit">Create</button>
      </form>
    </div>
  );
}