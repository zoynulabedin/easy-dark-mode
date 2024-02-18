/*
  Warnings:

  - A unique constraint covering the columns `[userId]` on the table `Darkmode` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX "Darkmode_userId_key" ON "Darkmode"("userId");
