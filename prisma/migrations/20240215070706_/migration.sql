/*
  Warnings:

  - You are about to drop the column `userId` on the `Darkmode` table. All the data in the column will be lost.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Darkmode" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "enable" BOOLEAN NOT NULL DEFAULT false,
    "bgcolor" TEXT DEFAULT '#1E1E24',
    "textcolor" TEXT DEFAULT '#FFFFFF'
);
INSERT INTO "new_Darkmode" ("bgcolor", "enable", "id", "textcolor") SELECT "bgcolor", "enable", "id", "textcolor" FROM "Darkmode";
DROP TABLE "Darkmode";
ALTER TABLE "new_Darkmode" RENAME TO "Darkmode";
CREATE TABLE "new_Session" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "shop" TEXT NOT NULL,
    "state" TEXT NOT NULL,
    "isOnline" BOOLEAN NOT NULL DEFAULT false,
    "scope" TEXT,
    "expires" DATETIME,
    "accessToken" TEXT NOT NULL,
    "userId" TEXT,
    CONSTRAINT "Session_userId_fkey" FOREIGN KEY ("userId") REFERENCES "Darkmode" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_Session" ("accessToken", "expires", "id", "isOnline", "scope", "shop", "state", "userId") SELECT "accessToken", "expires", "id", "isOnline", "scope", "shop", "state", "userId" FROM "Session";
DROP TABLE "Session";
ALTER TABLE "new_Session" RENAME TO "Session";
CREATE UNIQUE INDEX "Session_userId_key" ON "Session"("userId");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
