-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_AdWeekDays" (
    "adId" TEXT NOT NULL,
    "weekDaysId" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,

    PRIMARY KEY ("adId", "weekDaysId"),
    CONSTRAINT "AdWeekDays_adId_fkey" FOREIGN KEY ("adId") REFERENCES "Ads" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "AdWeekDays_weekDaysId_fkey" FOREIGN KEY ("weekDaysId") REFERENCES "WeekDays" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_AdWeekDays" ("adId", "createdAt", "updatedAt", "weekDaysId") SELECT "adId", "createdAt", "updatedAt", "weekDaysId" FROM "AdWeekDays";
DROP TABLE "AdWeekDays";
ALTER TABLE "new_AdWeekDays" RENAME TO "AdWeekDays";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
