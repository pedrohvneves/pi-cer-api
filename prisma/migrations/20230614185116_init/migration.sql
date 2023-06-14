/*
  Warnings:

  - You are about to drop the column `carga_horaria` on the `funcionario` table. All the data in the column will be lost.
  - Added the required column `endereco` to the `Dados` table without a default value. This is not possible if the table is not empty.
  - Added the required column `cargaHoraria` to the `Funcionario` table without a default value. This is not possible if the table is not empty.
  - Added the required column `dadosId` to the `Funcionario` table without a default value. This is not possible if the table is not empty.
  - Added the required column `dadosId` to the `Paciente` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `dados` ADD COLUMN `endereco` VARCHAR(191) NOT NULL;

-- AlterTable
ALTER TABLE `funcionario` DROP COLUMN `carga_horaria`,
    ADD COLUMN `cargaHoraria` VARCHAR(191) NOT NULL,
    ADD COLUMN `dadosId` INTEGER NOT NULL;

-- AlterTable
ALTER TABLE `paciente` ADD COLUMN `dadosId` INTEGER NOT NULL;

-- CreateTable
CREATE TABLE `Endereco` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `cep` INTEGER NOT NULL,
    `cidade` VARCHAR(191) NOT NULL,
    `bairro` VARCHAR(191) NOT NULL,
    `uf` VARCHAR(191) NOT NULL,
    `numero` VARCHAR(191) NOT NULL,
    `rua` VARCHAR(191) NOT NULL,
    `lugradouro` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `EnderecoPessoas` (
    `pessoaId` INTEGER NOT NULL,
    `enderecoId` INTEGER NOT NULL,

    PRIMARY KEY (`pessoaId`, `enderecoId`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `AtendenteGeral` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `cargo` VARCHAR(191) NOT NULL,
    `funcionarioId` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `AtendenteClinico` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `cargo` VARCHAR(191) NOT NULL,
    `registro` VARCHAR(191) NOT NULL,
    `Conselho` VARCHAR(191) NULL,
    `funcionarioId` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Consulta` (
    `descricao` VARCHAR(191) NOT NULL,
    `data` DATETIME(3) NOT NULL,
    `pacienteId` INTEGER NOT NULL,
    `medicoId` INTEGER NOT NULL,

    PRIMARY KEY (`pacienteId`, `medicoId`, `data`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `EnderecoPessoas` ADD CONSTRAINT `EnderecoPessoas_pessoaId_fkey` FOREIGN KEY (`pessoaId`) REFERENCES `Dados`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `EnderecoPessoas` ADD CONSTRAINT `EnderecoPessoas_enderecoId_fkey` FOREIGN KEY (`enderecoId`) REFERENCES `Endereco`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Paciente` ADD CONSTRAINT `Paciente_dadosId_fkey` FOREIGN KEY (`dadosId`) REFERENCES `Dados`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Funcionario` ADD CONSTRAINT `Funcionario_dadosId_fkey` FOREIGN KEY (`dadosId`) REFERENCES `Dados`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `AtendenteGeral` ADD CONSTRAINT `AtendenteGeral_funcionarioId_fkey` FOREIGN KEY (`funcionarioId`) REFERENCES `Funcionario`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `AtendenteClinico` ADD CONSTRAINT `AtendenteClinico_funcionarioId_fkey` FOREIGN KEY (`funcionarioId`) REFERENCES `Funcionario`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Consulta` ADD CONSTRAINT `Consulta_pacienteId_fkey` FOREIGN KEY (`pacienteId`) REFERENCES `Paciente`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Consulta` ADD CONSTRAINT `Consulta_medicoId_fkey` FOREIGN KEY (`medicoId`) REFERENCES `AtendenteClinico`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
