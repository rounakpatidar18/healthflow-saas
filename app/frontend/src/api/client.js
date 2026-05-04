import axios from "axios";

const API = axios.create({
  baseURL: import.meta.env.VITE_API_BASE_URL,
});

API.interceptors.request.use((config) => {
  config.headers = config.headers || {};

  const token = localStorage.getItem("token");
  const tenantId = localStorage.getItem("tenant_id");

  if (token) {
    config.headers.Authorization = `Bearer ${token}`;
  }

  if (!config.headers["X-Tenant-ID"] && tenantId) {
    config.headers["X-Tenant-ID"] = tenantId;
  }

  return config;
});

export default API;
