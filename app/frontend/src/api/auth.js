import API from "./client";

export const login = async (email, password, tenantId) => {
  const response = await API.post("/login", {
    email,
    password,
    tenant_id: tenantId,
  });

  const token = response.data.token;

  localStorage.setItem("token", token);
  localStorage.setItem("tenant_id", tenantId);

  return token;
};