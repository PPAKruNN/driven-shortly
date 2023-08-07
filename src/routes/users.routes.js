import { Router } from "express";
import { getProfile, getRanking } from "../controllers/users.js";
import authenticate from "../middleware/authenticate.js";

const router = Router();

router.get("/users/me", authenticate, getProfile)
router.get("/ranking", getRanking)

export default router;
