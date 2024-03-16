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
    nomeEmpresa VARCHAR(50) NOT NULL,
    cepEmpresa CHAR(8) NOT NULL,
    numeroLogradouro VARCHAR (8) NOT NULL,
    nivelAcesso VARCHAR(15), CONSTRAINT chkAcesso CHECK (nivelAcesso IN ('Admin', 'Funcionário'))
);

INSERT INTO usuario VALUES
(DEFAULT, '12345678900', 'Valdemar dos Santos', 'valdemar.dossantos@outlook.com', 'Val@1234Silva', 'Cogu Fazenda', '08050123', '345', 'Admin'),
(DEFAULT, '98765432100', 'Gisele Carvalho', 'gisele.carvalho@gmail.com', 'GC125408@', 'Cogu Fazenda', '08050123', '345', 'Funcionário'),
(DEFAULT, '77700016717', 'Josivaldo da Silva', 'josivaldo.dasilva@outlook.com', 'JdS4763@', 'Fazenda Shiitake Premier', '02420170', '170A', 'Admin');
/* ------------------------------------------------------------------------------------------------------------------------------ */

/* --- Cadastro Dispositivo Arduino --- */
CREATE TABLE dispositivo(
	id INT PRIMARY KEY AUTO_INCREMENT,
    idUsuario CHAR(11) NOT NULL, -- FOREIGN KEY(idUsuario)
    nomeLocalizacao VARCHAR(50)
);

INSERT INTO dispositivo VALUES
(DEFAULT, 1, 'Plantação 1A'),
(DEFAULT, 1, 'Plantação 1B'),
(DEFAULT, 3, 'Plantação Norte');

/* --- Dados de Temperatura e Umidade --- */
CREATE TABLE sensor (
	id INT PRIMARY KEY AUTO_INCREMENT,
    idDispositivo INT NOT NULL, -- FOREIGN KEY(idDispositivo)
    temperatura DOUBLE NOT NULL,
    umidade DOUBLE NOT NULL,
    data_hora DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO sensor VALUES
(DEFAULT, 1, 21.5, 77.3, DEFAULT),
(DEFAULT, 2, 28.5, 70.4, DEFAULT),
(DEFAULT, 3, 23.2, 86.6, DEFAULT);
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

INSERT INTO condicaoIdeal VALUES
(DEFAULT, 1, 20.0, 25.0, 75.0, 95.0);
/* ------------------------------------------------------------------------------------------------------------------------------ */

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

INSERT INTO alerta VALUES
(DEFAULT, 2, 19.9, 25.1, 74.9, 95.1);
/* ------------------------------------------------------------------------------------------------------------------------------ */

/* --- SELECTS --- */

-- SELECT Admin e Funcionário de uma Empresa
SELECT nomeEmpresa AS EMPRESA, 
nome AS USUARIO, 
nivelAcesso AS 'NÍVEL DE ACESSO' 
FROM usuario WHERE nomeEmpresa = 'Cogu Fazenda' ORDER BY nivelAcesso;

-- Dispositivo
SELECT id AS DISPOSITIVO, 
idUsuario AS USUÁRIO, 
nomeLocalizacao AS LOCALIZAÇÂO 
FROM dispositivo WHERE idUsuario = 1; 

-- Sensor
SELECT idDispositivo AS DISPOSITIVO,
temperatura AS TEMPERATURA,
umidade AS UMIDADE,
data_hora AS HORÁRIO
FROM sensor WHERE id = 2;

-- log Condição Ideal
SELECT id AS 'CONDIÇÂO IDEAL',
dispositivo_id AS DISPOSITIVO, 
temperaturaMaxIdeal AS TEMPERATURA, 
umidadeMaxIdeal AS UMIDADE
FROM condicaoIdeal WHERE id = 1;

-- log Condição não ideal - Alerta
SELECT id AS ALERTA,
dispositivo_id AS DISPOSITIVO, 
temperaturaMinAlerta AS TEMPERATURA, 
umidadeMinAlerta AS UMIDADE
FROM alerta WHERE id = 1;