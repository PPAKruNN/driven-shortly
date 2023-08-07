import Joi from "joi";
import { db } from "../database.js";

export default async function authenticate(req, res, next) {
    
    const { authorization } = req.headers;
    const token = authorization.replace("Bearer", "").trim();

    const sessionSearch = await db.query(`SELECT userid FROM sessions WHERE token = $1`, [token]);
    if(sessionSearch.rowCount === 0) return res.sendStatus(401);
    
    res.locals.id = sessionSearch.rows[0].userid;

    next();
}
