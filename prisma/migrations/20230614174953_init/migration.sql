-- CreateTable
CREATE TABLE `Dados` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `cpf` INTEGER NOT NULL,
    `dataNasc` DATETIME(3) NOT NULL,
    `genero` VARCHAR(191) NOT NULL,
    `nome` VARCHAR(191) NOT NULL,
    `rg` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `telefone` VARCHAR(191) NOT NULL,
    `telefoneAlt` VARCHAR(191) NULL,

    UNIQUE INDEX `Dados_cpf_key`(`cpf`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Paciente` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `sus` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `Paciente_sus_key`(`sus`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Funcionario` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `matricula` INTEGER NOT NULL,
    `salario` VARCHAR(191) NOT NULL,
    `carga_horaria` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `Funcionario_matricula_key`(`matricula`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
