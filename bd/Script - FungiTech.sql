CREATE DATABASE fungitech;

USE fungitech;
/* ------------------------------------------------------------------------------------------------------------------------------ */

/* --- Cadastro Cliente --- */
CREATE TABLE usuario (
	id INT PRIMARY KEY AUTO_INCREMENT,
    cpf CHAR(11) UNIQUE NOT NULL,
    nome VARCHAR(50) NOT NULL,
    email VARCHAR(60) UNIQUE NOT NULL,
    senha VARCHAR(25) NOT NULL,
    cep CHAR(8) NOT NULL,
    numeroLogradouro VARCHAR (8) NOT NULL,
    nivelAcesso VARCHAR(15), CONSTRAINT chkAcesso CHECK (nivelAcesso IN ('Admin', 'Funcionário')),
	contratacao VARCHAR(20), CONSTRAINT chkContratacao CHECK (contratacao IN ('Contratado', 'Não Contratado'))
);
/* ------------------------------------------------------------------------------------------------------------------------------ */

/* --- Cadastro Dispositivo Arduino --- */
CREATE TABLE dispositivo(
	id INT PRIMARY KEY AUTO_INCREMENT,
    idUsuario CHAR(11) NOT NULL, -- FOREIGN KEY(idUsuario)
    localizacao VARCHAR(50)
);

/* --- Dados de Temperatura e Umidade --- */
CREATE TABLE sensor (
	id INT PRIMARY KEY AUTO_INCREMENT,
    idDispositivo INT NOT NULL,
    temperatura DOUBLE NOT NULL,
    umidade DOUBLE NOT NULL,
    data_hora DATETIME NOT NULL
);
/* ------------------------------------------------------------------------------------------------------------------------------ */

/* --- Cadastro de Funcionários do Cliente, com permissões restritas ---
CREATE TABLE funcUsuario(
	idFuncUsuario INT PRIMARY KEY AUTO_INCREMENT,
    nomeFuncUsuario VARCHAR(50) NOT NULL,
    emailFuncUsuario VARCHAR(60) UNIQUE NOT NULL,
    senhaFuncUsuario VARCHAR(25) NOT NULL,
    cpfFuncUsuario CHAR(11) UNIQUE NOT NULL,
    responsavel VARCHAR(60) NOT NULL
);
*/
/* ------------------------------------------------------------------------------------------------------------------------------ */

/* --- Condições Ideais de Temperatura e Umidade --- */
CREATE TABLE condicaoIdeal
(
id INT AUTO_INCREMENT PRIMARY KEY,
dispositivo_id INT, -- FOREIGN KEY(idDispositivo) -- Dispositivo com condições ideais para o cultivo.
temperaturaMinIdeal DOUBLE, -- >= 20°C
temperaturaMaxIdeal DOUBLE, -- <= 25°C
umidadeMinIdeal DOUBLE, -- >= 75%
umidadeMaxIdeal DOUBLE -- <= 95%
);



/* --- Emissão de Alerta para Condições não Ideais --- */
CREATE TABLE alerta
(
id INT AUTO_INCREMENT PRIMARY KEY,
dispositivo_id INT, -- FOREIGN KEY(idDispositivo) -- Dispositivo que emitirá o alerta.
temperaturaMinAlerta DOUBLE, -- < 20°C
temperaturaMaxAlerta DOUBLE, -- > 25°C 
umidadeMinAlerta DOUBLE, -- < 75%
umidadeMaxAlerta DOUBLE  -- > 95%
);
