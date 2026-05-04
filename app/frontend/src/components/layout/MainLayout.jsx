import React from "react";
import { useNavigate } from "react-router-dom";

export default function MainLayout({ children }) {
  const navigate = useNavigate();

  const handleLogout = () => {
    localStorage.removeItem("token");
    localStorage.removeItem("tenant_id");
    navigate("/");
  };

  return (
    <div style={{ display: "flex", height: "100vh" }}>
      {/* Sidebar */}
      <div style={{ width: "200px", background: "#1e293b", color: "white", padding: "20px" }}>
        <h2>HealthFlow</h2>
        <button onClick={() => navigate("/dashboard")}>Dashboard</button>
        <button onClick={() => navigate("/appointments")}>Appointments</button>
        <button onClick={() => navigate("/patients")}>Patients</button>
        <button onClick={() => navigate("/billing")}>Billing</button>
      </div>

      {/* Main Content */}
      <div style={{ flex: 1 }}>
        {/* Header */}
        <div style={{ background: "#f1f5f9", padding: "10px", display: "flex", justifyContent: "flex-end" }}>
          <button onClick={handleLogout}>Logout</button>
        </div>

        {/* Content */}
        <div style={{ padding: "20px" }}>
          {children}
        </div>
      </div>
    </div>
  );
}