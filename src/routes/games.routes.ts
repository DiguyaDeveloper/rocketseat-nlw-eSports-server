import express from "express";
import { PrismaClient } from "@prisma/client";
import { convertHourStringToMinutes } from "../shared/utils/convert-hours-string-to-minutes.utils";
import { convertMinutesToHourString } from "../shared/utils/convert-minutes-to-hours-string.utils";

const routes = express();
const prisma = new PrismaClient({
  log: ["query"],
});

routes.get("/games", async (request, response) => {
  const games = await prisma.game.findMany({
    include: {
      Ads: {
        select: {
          discord: true,
          _count: {
            select: {
              AdWeekDays: true,
            },
          },
        },
      },
      _count: {
        select: {
          Ads: true,
        },
      },
    },
  });
  return response.status(200).json(games);
});

routes.get("/games/:id/ads", async (request, response) => {
  const gameId: string = request.params.id;

  const ads = await prisma.ads.findMany({
    select: {
      id: true,
      name: true,
      useVoiceChannel: true,
      yearPlaying: true,
      hourStart: true,
      hourEnd: true,
      createdAt: true,
      AdWeekDays: {
        select: {
          weekDays: {
            select: {
              dayNumber: true,
              day: true,
            },
          },
        },
        orderBy: {
          createdAt: "desc",
        },
      },
    },
    where: {
      gameId,
    },
    orderBy: {
      createdAt: "desc",
    },
  });

  const adsResponse = ads.map((ad) => ({
    ...ad,
    hourStart: convertMinutesToHourString(ad.hourStart),
    hourEnd: convertMinutesToHourString(ad.hourEnd),
  }));

  return response.json(adsResponse);
});

routes.post("/games/:id/ads", async (request, response) => {
  const gameId: { id: string } = await prisma.game.findFirstOrThrow({
    select: {
      id: true,
    },
    where: {
      id: request.params.id,
    },
  });

  if (!gameId || !gameId.id) {
    return response
      .status(404)
      .json({ error: `Game not found with id: ${gameId}` });
  }

  const gameAds = request.body;

  const weekDayIds: { id: string }[] = await prisma.weekDays.findMany({
    select: {
      id: true,
    },
    where: {
      dayNumber: { in: gameAds.weekDays },
    },
  });

  if (!weekDayIds || !weekDayIds.length) {
    return response.status(404).json({ error: `WeekDays inputed dont exists` });
  }

  const weekDaysToCreate = weekDayIds.map((value: { id: string }) => ({
    weekDays: {
      connect: {
        id: value.id,
      },
    },
  }));

  const gameAdsCreated = await prisma.ads.create({
    data: {
      gameId: gameId.id,
      name: gameAds.name,
      yearPlaying: gameAds.yearPlaying,
      discord: gameAds.discord,
      AdWeekDays: {
        create: weekDaysToCreate,
      },
      hourStart: convertHourStringToMinutes(gameAds.hourStart),
      hourEnd: convertHourStringToMinutes(gameAds.hourEnd),
      useVoiceChannel: gameAds.useVoiceChannel,
    },
  });

  return response.status(201).json(gameAdsCreated);
});

routes.delete("/games", (request, response) => {
  return response.json([]);
});

export default routes;
