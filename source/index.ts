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
//caso não venha um cpf como argumento, provavelmente tem um jeito mais elegante de se fazer isso
app.get('/consultas',async (req:Request, res:Response) => {
    res.status(200).json({});    
})

app.get('/consultas/:cpf', async(req: Request, res: Response)=>{
    //consultar o db por consultas do paciente de cpf do request
    const cpf:string = req.params.cpf
    const consultas = await prisma.consulta.findMany({
        where:{
            paciente:{
                is:{
                    dados:{
                        cpf:{
                            equals: cpf
                        },
                    },
                },
            },
            data:{
                gte:new Date(),
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
            paciente:{
                select:{
                    dados:{
                        select:{
                            nome:true
                        }
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