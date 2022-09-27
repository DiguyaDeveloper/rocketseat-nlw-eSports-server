/*
  Warnings:

  - You are about to drop the column `adId` on the `WeekDays` table. All the data in the column will be lost.
  - Added the required column `day` to the `WeekDays` table without a default value. This is not possible if the table is not empty.
  - Added the required column `dayNumber` to the `WeekDays` table without a default value. This is not possible if the table is not empty.

*/
-- CreateTable
CREATE TABLE "AdWeekDays" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "adId" TEXT NOT NULL,
    "weekDaysId" TEXT NOT NULL,
    CONSTRAINT "AdWeekDays_adId_fkey" FOREIGN KEY ("adId") REFERENCES "Ad" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "AdWeekDays_weekDaysId_fkey" FOREIGN KEY ("weekDaysId") REFERENCES "WeekDays" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_WeekDays" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "dayNumber" INTEGER NOT NULL,
    "day" TEXT NOT NULL
);
INSERT INTO "new_WeekDays" ("id") SELECT "id" FROM "WeekDays";
DROP TABLE "WeekDays";
ALTER TABLE "new_WeekDays" RENAME TO "WeekDays";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
