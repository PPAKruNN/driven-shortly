// {
// 	 "name": "João",
//   "email": "joao@driven.com.br",
//   "password": "driven",
//   "confirmPassword": "driven"
// }
import Joi from "joi";

export default cadastroSchema = Joi.object({
    name: Joi.string().required(),
    email: Joi.string().email().required(),
    password: Joi.string().required(),
    confirmPassword: Joi.string().required()
}).required();