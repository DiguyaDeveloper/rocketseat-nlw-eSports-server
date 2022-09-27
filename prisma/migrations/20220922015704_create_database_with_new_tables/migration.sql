/*
  Warnings:

  - The primary key for the `AdWeekDays` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `AdWeekDays` table. All the data in the column will be lost.
  - Added the required column `updatedAt` to the `Ad` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `WeekDays` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `Game` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `AdWeekDays` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Ad" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "gameId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "yearPlaying" INTEGER NOT NULL,
    "discord" TEXT NOT NULL,
    "hourStart" INTEGER NOT NULL,
    "hourEnd" INTEGER NOT NULL,
    "useVoiceChannel" BOOLEAN NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "Ad_gameId_fkey" FOREIGN KEY ("gameId") REFERENCES "Game" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Ad" ("createdAt", "discord", "gameId", "hourEnd", "hourStart", "id", "name", "useVoiceChannel", "yearPlaying") SELECT "createdAt", "discord", "gameId", "hourEnd", "hourStart", "id", "name", "useVoiceChannel", "yearPlaying" FROM "Ad";
DROP TABLE "Ad";
ALTER TABLE "new_Ad" RENAME TO "Ad";
CREATE TABLE "new_WeekDays" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "dayNumber" INTEGER NOT NULL,
    "day" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL
);
INSERT INTO "new_WeekDays" ("day", "dayNumber", "id") SELECT "day", "dayNumber", "id" FROM "WeekDays";
DROP TABLE "WeekDays";
ALTER TABLE "new_WeekDays" RENAME TO "WeekDays";
CREATE TABLE "new_Game" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "title" TEXT NOT NULL,
    "bannerUrl" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL
);
INSERT INTO "new_Game" ("bannerUrl", "id", "title") SELECT "bannerUrl", "id", "title" FROM "Game";
DROP TABLE "Game";
ALTER TABLE "new_Game" RENAME TO "Game";
CREATE TABLE "new_AdWeekDays" (
    "adId" TEXT NOT NULL,
    "weekDaysId" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "AdWeekDays_adId_fkey" FOREIGN KEY ("adId") REFERENCES "Ad" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "AdWeekDays_weekDaysId_fkey" FOREIGN KEY ("weekDaysId") REFERENCES "WeekDays" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_AdWeekDays" ("adId", "weekDaysId") SELECT "adId", "weekDaysId" FROM "AdWeekDays";
DROP TABLE "AdWeekDays";
ALTER TABLE "new_AdWeekDays" RENAME TO "AdWeekDays";
CREATE UNIQUE INDEX "AdWeekDays_adId_key" ON "AdWeekDays"("adId");
CREATE UNIQUE INDEX "AdWeekDays_weekDaysId_key" ON "AdWeekDays"("weekDaysId");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
