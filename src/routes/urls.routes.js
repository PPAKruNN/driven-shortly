import { Router } from "express";
import validateSchema from "../middleware/validateSchema.js";
import authenticate from "../middleware/authenticate.js";
import urlShortenSchema from "../schemas/urlShortenSchema.js";
import { getUrlById, openUrl, shortenUrl } from "../controllers/urls.js";

const router = Router();

router.post("/urls/shorten", validateSchema(urlShortenSchema), authenticate, shortenUrl )
router.get("/urls/:id", getUrlById)
router.get("/urls/open/:shortUrl", openUrl)


export default router;
