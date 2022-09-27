/*
  Warnings:

  - You are about to drop the `Ad` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "Ad";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "Ads" (
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
    CONSTRAINT "Ads_gameId_fkey" FOREIGN KEY ("gameId") REFERENCES "Game" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_AdWeekDays" (
    "adId" TEXT NOT NULL,
    "weekDaysId" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "AdWeekDays_adId_fkey" FOREIGN KEY ("adId") REFERENCES "Ads" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "AdWeekDays_weekDaysId_fkey" FOREIGN KEY ("weekDaysId") REFERENCES "WeekDays" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_AdWeekDays" ("adId", "createdAt", "updatedAt", "weekDaysId") SELECT "adId", "createdAt", "updatedAt", "weekDaysId" FROM "AdWeekDays";
DROP TABLE "AdWeekDays";
ALTER TABLE "new_AdWeekDays" RENAME TO "AdWeekDays";
CREATE UNIQUE INDEX "AdWeekDays_adId_key" ON "AdWeekDays"("adId");
CREATE UNIQUE INDEX "AdWeekDays_weekDaysId_key" ON "AdWeekDays"("weekDaysId");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
