export async function Createdarkmode(
  userId: string,
  enable: boolean,
  bgcolor: string,
  textcolor: string,
) {
  return prisma.darkmode.create({
    data: {
      userId: userId,
      enable: enable,
      bgcolor: bgcolor,
      textcolor: textcolor,
    },
  });
}
export async function Getdarkmode() {
  return prisma.darkmode.findMany();
}

export async function GetdarkmodeById(userId: string) {
  console.log("======hit get function for userid =========");
  return prisma.darkmode.findUnique({
    where: {
      userId: userId,
    },
  });
}

// update darkmode
export async function Updatedarkmode(
  userId: string,
  enable: boolean,
  bgcolor: string,
  textcolor: string,
) {
  return prisma.darkmode.update({
    where: {
      userId: userId,
    },
    data: {
      enable: enable,
      bgcolor: bgcolor,
      textcolor: textcolor,
    },
  });
}
