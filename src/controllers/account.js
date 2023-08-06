import { db } from "../database.js";
import bcrypt from "bcrypt";

export async function Cadastro(req, res) {

    const { name, email, password, confirmPassword } = req.body;

    try {
        if(password !== confirmPassword) return res.status(422).send("Passwords does not match!");

        const emailSearch = await db.query("SELECT * FROM users WHERE email = $1", [email]);
        if(emailSearch.rowCount !== 0) return res.sendStatus(409);

        const hash = bcrypt.hashSync(password, 10);

        // Create user and session row.
        const insertUser = await db.query(`
        INSERT INTO users(name, email, passwordhash) 
        VALUES ($1, $2, $3)
        RETURNING id;
        `, [name, email, hash])

        await db.query(`
        INSERT INTO sessions(userId, token) 
        VALUES ($1, $2);
        `, [insertUser.rows[0].id, null])
        
        return res.send(201);
        
    } catch (error) {
        console.log(error);
        res.sendStatus(500);
    }
}