create  database fungitech;

use fungitech;
/*----------------------------------------------------------------------------------------------------------------------*/
/*--------------- INTEGRANTES ---------------
GRUPO 3
Ana Beatriz Ribeiro Moraes		RA 04241040
Gisele Rezende Carvalho 		RA 04241052
João Victor Barretta da Silva	RA 04241020
Kaíque dos Reis Leroy			RA 04241036
Kamilly Rebeca Pogi Silva		RA 04241028
Murillo Moreira de Mello		RA 04241024
Murilo Cardoso Martinez			RA 04241037
Sarah Leal de Oliveira			RA 04241031
*/
/*----------------------------------------------------------------------------------------------------------------------*/

create table leituras(
	idLeitura int primary key auto_increment,
    dispositivo_id int not null,
    temperatura int,
    umidade int,
    data_hora datetime
);

create table usuario(
	idUsuario int auto_increment primary key,
    cpfUsuario char(11) unique not null,
    nomeUsuario varchar(50) not null,
    emailUsuario varchar(60) unique not null,
    senhaUsuario varchar(25) not null,
    cepUsuario char(8) not null,
    numeroLogradouro int not null
);

create table dispositivo(
	idDispositivo int auto_increment primary key,
    usuarioCpf char(11) not null,
    localizacaoDispositvo varchar(50)
);

create table funcUsuario(
	idFuncUsuario int auto_increment primary key,
    nomeFuncUsuario varchar(50) not null,
    emailFuncUsuario varchar(60) unique not null,
    senhaFuncUsuario varchar(25) not null,
    cpfFuncUsuario char(11) unique not null,
    responsavel varchar(60) not null
);