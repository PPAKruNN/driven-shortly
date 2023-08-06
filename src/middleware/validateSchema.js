import Joi from "joi";

export default function validateSchema(schema) {
   
    return function (req, res, next) {
        const a = Joi.string().validate();
        const res = schema.validate(req.body);
        
        if(res.error) return res.status(422).send(res.error);
        next();
    }
}
