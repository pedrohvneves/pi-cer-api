import { PrismaClient } from '@prisma/client'
import express, { Express, Request, Response} from 'express';
import cors from 'cors';

//módulos e configurações
const app: Express = express();
app.use(express.json());
app.use(cors());

//db
const prisma = new PrismaClient()


//routes
app.get('/',async (req:Request, res: Response) => {
    res.status(200).send("API conectada!")
})


//procurar consultas de paciente
app.post('/consultas/', async(req: Request, res: Response)=>{
    //consultar o db por consultas do paciente de cpf do request
    const body: any = req.body;
    const consultas = await prisma.consulta.findMany({
        where:{
            paciente:{
                is:{
                    dados:{
                        cpf:{
                            equals: body.cpf
                        },
                    },
                },
            },
        },
        include:{
            medico:{
                select:{
                    cargo:true,
                    funcionario:{
                        select:{
                            dados:{
                                select:{
                                    nome:true,
                                },
                            },
                        },
                    },
                },
            },
        },
    })
    return res.status(200).json(consultas);
})


//iniciar api
app.listen(process.env.PORT, ()=> {
    console.log(`Listening in on port ${process.env.PORT}`)
})