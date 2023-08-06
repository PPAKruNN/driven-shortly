import { Router } from "express";
import { Cadastro } from "../controllers/account.js";
import validateSchema from "../middleware/validateSchema.js";
import cadastroSchema from "../schemas/cadastroSchema.js";

const router = Router();

router.post("/signup", validateSchema(cadastroSchema), Cadastro);

export default router;