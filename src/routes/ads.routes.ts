import { PrismaClient } from "@prisma/client";
import express from "express";
import { convertMinutesToHourString } from "../shared/utils/convert-minutes-to-hours-string.utils";

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

routes.get("/ads", async (request, response) => {
  const ads = await prisma.ads.findMany({
    select: {
      name: true,
      discord: true,
      game: {
        select: {
          title: true,
        },
      },
      useVoiceChannel: true,
      yearPlaying: true,
      hourEnd: true,
      hourStart: true,
      AdWeekDays: {
        select: {
          weekDays: {
            select: {
              day: true,
              dayNumber: true,
            },
          },
        },
      },
    },
  });

  const adsResponse = ads.map((data) => ({
    ...data,
    hourStart: convertMinutesToHourString(data.hourStart),
    hourEnd: convertMinutesToHourString(data.hourEnd),
  }));

  return response.json(adsResponse);
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
