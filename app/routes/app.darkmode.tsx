import type { ActionFunctionArgs, LoaderFunctionArgs } from "@remix-run/node";
import { json } from "@remix-run/node";
import { Form, useLoaderData } from "@remix-run/react";
import { Button, Card, Layout, Page } from "@shopify/polaris";
import { useState } from "react";
import { authenticate } from "~/shopify.server";
import {
  Createdarkmode,
  Getdarkmode,
  Updatedarkmode,
} from "~/utlis/darkmode.server";

export const loader = async ({ request }: LoaderFunctionArgs) => {
  const { session } = await authenticate.public.appProxy(request);

  if (session) {
    const data = await Getdarkmode();
    return json(data);
  }
};

export const action = async ({ request }: ActionFunctionArgs) => {
  const { session } = await authenticate.admin(request);
  const formData = await request.formData();
  const userid = String(session?.id || "");
  const bgcolor = String(formData.get("bgcolor") || "#000000");
  const textColor = String(formData.get("textcolor") || "#ffffff");
  const enable = Boolean(formData.get("enable") || false);
  if (request.method === "POST") {
    return await Createdarkmode(userid, enable, bgcolor, textColor);
  }
  if (request.method === "PUT") {
    return await Updatedarkmode(userid, enable, bgcolor, textColor);
  }

  return json({
    success: "Hello world test",
  });
};

const Darkmode = () => {
  const allDarkmode = useLoaderData<typeof loader>();

  const [isChecked, setIsChecked] = useState(allDarkmode[1].enable ?? false);

  const toggleCheckbox = () => {
    setIsChecked(!isChecked);
  };
  const [input, setInput] = useState(allDarkmode[1]);

  const handleInputchange = (e: any) => {
    setInput((prevState) => ({
      ...prevState,
      [e.target.name]: e.target.value,
    }));
  };

  return (
    <Page>
      <Layout>
        <Layout.Section variant="oneHalf">
          <Card>
            <Form method={allDarkmode[1].userId ? "put" : "post"}>
              <div className="flex items-center gap-10">
                <label htmlFor="">Enable?</label>

                <input
                  type="checkbox"
                  onChange={toggleCheckbox}
                  className="toggle"
                  name="enable"
                  checked={isChecked}
                />
              </div>

              <>
                <div className="mt-10">
                  <label htmlFor="">Background Color</label>
                  <input
                    type="color"
                    onChange={handleInputchange}
                    value={input.bgcolor ?? ""}
                    name="bgcolor"
                  />
                </div>
                <div className="mt-10">
                  <label htmlFor="">Text Color</label>
                  <input
                    type="color"
                    onChange={handleInputchange}
                    value={input.textcolor ?? ""}
                    name="textcolor"
                  />
                </div>
                <div className="mt-5"></div>
              </>

              <Button submit={true}>Save</Button>
            </Form>
          </Card>
        </Layout.Section>
        <Layout.Section variant="oneHalf">
          <Card>
            <div style={{ backgroundColor: input.bgcolor ?? "" }}>
              <h1
                style={{ color: input.textcolor ?? "" }}
                className=" text-center text-2xl"
              >
                Hello
              </h1>
            </div>
          </Card>
        </Layout.Section>
      </Layout>
    </Page>
  );
};

export default Darkmode;
