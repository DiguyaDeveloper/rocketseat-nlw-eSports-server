import express from "express";

const routes = express();

routes.post("/games", (request, response) => {
  return response.json([]);
});

routes.get("/games", (request, response) => {
  return response.json([]);
});

routes.get("/games/:id/ads", (request, response) => {
  return response.json([
    { id: 1, name: "Anuncio 1" },
    { id: 2, name: "Anuncio 2" },
  ]);
});

routes.delete("/games", (request, response) => {
  return response.json([]);
});

export default routes;
