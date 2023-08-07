import { Router } from "express";
import validateSchema from "../middleware/validateSchema.js";
import authenticate from "../middleware/authenticate.js";

const router = Router();

router.post("/urls/shorten", authenticate )


export default router;
