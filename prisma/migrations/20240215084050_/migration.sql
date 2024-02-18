/*
  Warnings:

  - You are about to alter the column `userId` on the `Session` table. The data in that column could be lost. The data in that column will be cast from `String` to `BigInt`.
  - The primary key for the `Darkmode` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to alter the column `id` on the `Darkmode` table. The data in that column could be lost. The data in that column will be cast from `String` to `Int`.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Session" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "shop" TEXT NOT NULL,
    "state" TEXT NOT NULL,
    "isOnline" BOOLEAN NOT NULL DEFAULT false,
    "scope" TEXT,
    "expires" DATETIME,
    "accessToken" TEXT NOT NULL,
    "userId" BIGINT
);
INSERT INTO "new_Session" ("accessToken", "expires", "id", "isOnline", "scope", "shop", "state", "userId") SELECT "accessToken", "expires", "id", "isOnline", "scope", "shop", "state", "userId" FROM "Session";
DROP TABLE "Session";
ALTER TABLE "new_Session" RENAME TO "Session";
CREATE TABLE "new_Darkmode" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "userId" BIGINT,
    "enable" BOOLEAN NOT NULL DEFAULT false,
    "bgcolor" TEXT DEFAULT '#1E1E24',
    "textcolor" TEXT DEFAULT '#FFFFFF'
);
INSERT INTO "new_Darkmode" ("bgcolor", "enable", "id", "textcolor") SELECT "bgcolor", "enable", "id", "textcolor" FROM "Darkmode";
DROP TABLE "Darkmode";
ALTER TABLE "new_Darkmode" RENAME TO "Darkmode";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
