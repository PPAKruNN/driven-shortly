import { v4 } from "uuid";
import { db } from "../database.js";
import bcrypt from "bcrypt";

export async function getProfile(req, res) {

    const { id } = res.locals;

    try {
        const userSearch = await db.query(`
            SELECT users.id, users.name, SUM (visitcount) as "visitCount"
              FROM users
             INNER JOIN shorturls as s
                ON users.id = s.userid
             WHERE users.id = $1
             GROUP BY users.id; 
        `, [ id ])
        
        const shortenedUrls = await db.query(`
        SELECT id, shorturl as "shortUrl", url, visitcount as "visitCount"
          FROM shorturls
         WHERE userid = $1;
        `, [ id ]);

        const responseObject = {...userSearch.rows[0], shortenedUrls: shortenedUrls.rows}

        return res.send(responseObject);
        
    } catch (error) {
        console.log(error);
        res.sendStatus(500);
    }
}

export async function getRanking(req, res) {

    const { id } = res.locals;

    try {
        const rankingSearch = await db.query(`
            SELECT users.id, users.name, SUM (visitcount) as "visitCount", count (userId) as "linksCount"
              FROM users
        INNER JOIN shorturls as s
                ON users.id = s.userid
          GROUP BY users.id
          ORDER BY "visitCount" DESC
             LIMIT 10
        `);

        return res.send(rankingSearch.rows);
        
    } catch (error) {
        console.log(error);
        res.sendStatus(500);
    }
}
