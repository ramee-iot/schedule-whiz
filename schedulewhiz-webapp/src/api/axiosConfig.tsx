import axios from "axios";

const api = axios.create({
  baseURL: "http://192.168.3.110:8090",
});

export default api;
