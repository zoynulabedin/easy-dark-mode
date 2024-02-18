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
    "userId" TEXT
);
INSERT INTO "new_Session" ("accessToken", "expires", "id", "isOnline", "scope", "shop", "state", "userId") SELECT "accessToken", "expires", "id", "isOnline", "scope", "shop", "state", "userId" FROM "Session";
DROP TABLE "Session";
ALTER TABLE "new_Session" RENAME TO "Session";
CREATE TABLE "new_Darkmode" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
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
