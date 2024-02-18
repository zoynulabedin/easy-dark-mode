/*
  Warnings:

  - The primary key for the `Darkmode` table will be changed. If it partially fails, the table could be left without primary key constraint.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Darkmode" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "userId" TEXT,
    "enable" BOOLEAN NOT NULL DEFAULT false,
    "bgcolor" TEXT DEFAULT '#1E1E24',
    "textcolor" TEXT DEFAULT '#FFFFFF'
);
INSERT INTO "new_Darkmode" ("bgcolor", "enable", "id", "textcolor", "userId") SELECT "bgcolor", "enable", "id", "textcolor", "userId" FROM "Darkmode";
DROP TABLE "Darkmode";
ALTER TABLE "new_Darkmode" RENAME TO "Darkmode";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
