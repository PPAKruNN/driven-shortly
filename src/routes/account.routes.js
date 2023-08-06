import { Router } from "express";
import { Cadastro } from "../controllers/account";

const router = Router();

router.post("/signup", Cadastro);

export default router;