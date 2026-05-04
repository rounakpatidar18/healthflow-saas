import React, { useEffect, useState } from "react";
import { fetchRevenue, fetchVisits } from "../api/reports";
import {
  LineChart,
  Line,
  XAxis,
  YAxis,
  Tooltip,
  CartesianGrid,
  BarChart,
  Bar,
} from "recharts";

export default function Dashboard() {
  const [revenueData, setRevenueData] = useState([]);
  const [visitData, setVisitData] = useState([]);

  useEffect(() => {
    loadData();
  }, []);

  const loadData = async () => {
    try {
      const revenue = await fetchRevenue();
      const visits = await fetchVisits();

      setRevenueData(formatData(revenue));
      setVisitData(formatData(visits));
    } catch (err) {
      console.error("Failed to load dashboard data");
    }
  };

  const formatData = (data) => {
    return Object.keys(data).map((key) => ({
      date: key,
      value: data[key],
    }));
  };

  return (
    <div style={{ padding: "20px" }}>
      <h1>Dashboard</h1>

      <h2>Revenue</h2>
      <LineChart width={600} height={300} data={revenueData}>
        <CartesianGrid strokeDasharray="3 3" />
        <XAxis dataKey="date" />
        <YAxis />
        <Tooltip />
        <Line type="monotone" dataKey="value" />
      </LineChart>

      <h2>Patient Visits</h2>
      <BarChart width={600} height={300} data={visitData}>
        <CartesianGrid strokeDasharray="3 3" />
        <XAxis dataKey="date" />
        <YAxis />
        <Tooltip />
        <Bar dataKey="value" />
      </BarChart>
    </div>
  );
}