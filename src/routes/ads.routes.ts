import express from "express";

const routes = express();

routes.get("/ads/:id", (request, response) => {
  return response.json([
    { id: 1, name: "Anuncio 1" },
    { id: 2, name: "Anuncio 2" },
  ]);
});

routes.get("/ads/:id/discord", (request, response) => {
  return response.json([
    { id: 1, name: "Anuncio 1" },
    { id: 2, name: "Anuncio 2" },
  ]);
});

routes.post("/ads", (request, response) => {
  return response.status(201).json();
});

routes.delete("/ads", (request, response) => {
  return response.json([]);
});

export default routes;
