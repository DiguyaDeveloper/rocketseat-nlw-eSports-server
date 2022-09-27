import { PrismaClient } from "@prisma/client";
import express from "express";

const routes = express();

const prisma = new PrismaClient({
  log: ["query"],
});

routes.get("/ads/:id", (request, response) => {
  return response.json([
    { id: 1, name: "Anuncio 1" },
    { id: 2, name: "Anuncio 2" },
  ]);
});

routes.get("/ads/:id/discord", async (request, response) => {
  const adsId = request.params.id;

  const ads = await prisma.ads.findUniqueOrThrow({
    select: {
      discord: true,
    },
    where: {
      id: adsId,
    },
  });
  return response.json({
    discord: ads.discord,
  });
});

routes.post("/ads", (request, response) => {
  return response.status(201).json();
});

routes.delete("/ads", (request, response) => {
  return response.json([]);
});

export default routes;
