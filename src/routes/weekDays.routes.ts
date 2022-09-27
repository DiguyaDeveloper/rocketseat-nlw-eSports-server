import { PrismaClient } from "@prisma/client";
import express from "express";

const routes = express();

const prisma = new PrismaClient({
  log: ["query"],
});

routes.get("/weekDays/:id", async (request, response) => {
  const weekDays = await prisma.weekDays.findUniqueOrThrow({
    select: {},
    where: {
      id: request.params.id,
    },
  });
  return response.json(weekDays);
});

routes.post("/weekDays", async (request, response) => {
  const weekDays = request.body;

  const weekDaysCreated = await prisma.weekDays.create({
    data: {
      day: weekDays.day,
      dayNumber: Number(weekDays.dayNumber),
    },
  });

  return response.status(201).json(weekDaysCreated);
});

export default routes;
