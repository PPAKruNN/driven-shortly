import { v4 } from "uuid";
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

export async function Login(req,res) {

    try {
        const { email, password } = req.body;
        
        const userSearch = await db.query(`SELECT id, passwordhash FROM users WHERE email = $1 `, [email]);
        if(userSearch.rowCount === 0 ) return res.sendStatus(401);
        if(!bcrypt.compareSync(password, userSearch.rows[0].passwordhash)) return res.sendStatus(401);

        const token = v4();

        await db.query(`
        UPDATE sessions
        SET token = $1
        WHERE userid = $2
        `, [token, userSearch.rows[0].id ]);

        return res.status(200).send(token);
    } catch (error) {
        console.log(error);
        res.sendStatus(500);
    }

}