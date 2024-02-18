import { PrismaClient } from "@prisma/client";

const prisma: PrismaClient<never> = new PrismaClient();

export default prisma;
