import { Router } from "express";
import { Cadastro, Login } from "../controllers/account.js";
import validateSchema from "../middleware/validateSchema.js";
import cadastroSchema from "../schemas/cadastroSchema.js";
import loginSchema from "../schemas/loginSchema.js";

const router = Router();

router.post("/signup", validateSchema(cadastroSchema), Cadastro);
router.post("/signin", validateSchema(loginSchema), Login);

export default router;