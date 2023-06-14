import { PrismaClient } from '@prisma/client'
import express, {Request, Response} from 'express';
import cors from 'cors';

//módulos e configurações
const app = require('express');
const porta = process.env.PORT;
app.use(express.json());
app.use(cors());

//db
const prisma = new PrismaClient()


//routes

//procurar consultas de paciente
app.post('/consultas/',(req: Request, res: Response)=>{
    //consultar o db por consultas do paciente de cpf do request
    const body: any = req.body;
    const consultas = prisma.consulta.findMany({
        where:{
            paciente:{
                is:{
                    dados:{
                        cpf:{
                            equals: body.cpf
                        }
                    }
                }
            }
        }
    })
    return res.status(200).json(consultas);
})


//iniciar api
app.listen(8000)