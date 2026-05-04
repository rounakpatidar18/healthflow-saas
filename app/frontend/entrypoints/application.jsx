import React from "react";
import { createRoot } from "react-dom/client";
import "bootstrap/dist/css/bootstrap.min.css";
import { BrowserRouter, Routes, Route } from "react-router-dom";

import Login from "../src/pages/Login";
import Dashboard from "../src/pages/Dashboard";
import Appointments from "../src/pages/appointments/Appointments";
import NewAppointment from "../src/pages/appointments/NewAppointment";
import ProtectedRoute from "../src/components/ProtectedRoute";

function App() {
  return (
    <BrowserRouter>
      <Routes>
        {/* Public route */}
        <Route path="/" element={<Login />} />

        {/* Protected route */}
        <Route
          path="/dashboard"
          element={
            <ProtectedRoute>
              <Dashboard />
            </ProtectedRoute>
          }
        />
        <Route path="/appointments" element={<Appointments />} />
        <Route path="/appointments/new" element={<NewAppointment />} />
      </Routes>
    </BrowserRouter>
  );
}

createRoot(document.getElementById("root")).render(<App />);
