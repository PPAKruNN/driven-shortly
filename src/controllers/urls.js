import { v4 } from "uuid";
import { db } from "../database.js";
import bcrypt from "bcrypt";
import { nanoid } from "nanoid";

export async function shortenUrl(req, res ) {
    
    try {
        const { url } = req.body;
        const userId = res.locals.id;
        const shortenUrl = nanoid();

        const insertShortenUrl = await db.query(`
        INSERT INTO shortUrls(userid, shorturl, url) 
        VALUES ($1, $2, $3)
        RETURNING id; 
        `, [userId, shortenUrl, url]);

        const responseObject = {
            "id": insertShortenUrl.rows[0].id,
            "shortUrl": shortenUrl
        }

        res.status(201).send(responseObject);

    } catch (error) {
        return res.sendStatus(500);
    }
}

export async function getUrlById(req, res ) {
    try {
        const { id } = req.params;

        const urlSearch = await db.query(`
        SELECT id, shorturl as "shortUrl", url
        FROM shortUrls
        WHERE id = $1; 
        `, [ id ])
        
        
        if(urlSearch.rowCount === 0) return res.sendStatus(404);

        res.status(200).send(urlSearch.rows[0]);

    } catch (error) {
        return res.sendStatus(500);
    }
}


export async function openUrl(req, res ) {
    try {
        const { shortUrl } = req.params;

        const urlInsert = await db.query(`
            UPDATE shorturls
            SET visitcount = visitcount + 1
            WHERE shorturl = $1
            RETURNING url;
        `, [shortUrl])
        
        if(urlInsert.rowCount === 0) return res.sendStatus(404);

        res.redirect(urlInsert.rows[0].url);

    } catch (error) {
        return res.sendStatus(500);
    }
}



export async function deleteUrl(req, res ) {
    try {
        const { id } = req.params;

        const urlSearch = await db.query(`
            SELECT userid
            FROM shorturls
            WHERE id = $1
        `, [id]);

        if(urlSearch.rowCount === 0) return res.sendStatus(404);
        if(urlSearch.rows[0].userid !== res.locals.id) return res.sendStatus(401);

        await db.query(`
            DELETE FROM shorturls WHERE id = $1;
        `, [ id ])
        
        res.sendStatus(204);

    } catch (error) {
        return res.sendStatus(500);
    }
}
