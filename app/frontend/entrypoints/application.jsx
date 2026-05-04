import React from "react";
import { createRoot } from "react-dom/client";

function App() {
  return (
    <div>
      <h1>HealthFlow SaaS</h1>
      <p>Frontend is running 🚀</p>
    </div>
  );
}

const container = document.getElementById("root");
createRoot(container).render(<App />);