import API from "./client";

export const fetchRevenue = async () => {
  const res = await API.get("/reports/revenue");
  return res.data.revenue;
};

export const fetchVisits = async () => {
  const res = await API.get("/reports/patient_visits");
  return res.data.visits;
};