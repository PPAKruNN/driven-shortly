import Express from "express"
import { json } from "express"
import cors from "cors";
import accountRouter from "./routes/account.routes.js";
import urlsRouter from "./routes/urls.routes.js";

const app = Express();

app.use(json())
app.use(cors())

app.use(accountRouter);
app.use(urlsRouter);

app.listen(5000);