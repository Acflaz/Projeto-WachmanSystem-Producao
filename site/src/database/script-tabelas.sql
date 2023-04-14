	-- Arquivo de apoio, caso você queira criar tabelas como as aqui criadas para a API funcionar.
-- Você precisa executar os comandos no banco de dados para criar as tabelas,
-- ter este arquivo aqui não significa que a tabela em seu BD estará como abaixo!

/*
comandos para mysql - banco local - ambiente de desenvolvimento
*/

create database watchmanSystem;
use watchmanSystem;

create table empresa(
idEmpresa int primary key auto_increment,
nomeFantasia varchar(45),
cnpj char(15),
emailResponsavel varchar(35),
telefone varchar(45),
usuario varchar(45),
senha varchar(45)
);

SELECT * FROM empresa;
SELECT * FROM empresa WHERE usuario AND senha;

create table alerta(
idAlerta int primary key auto_increment,
minCpu decimal(10,2),
maxCpu decimal(10,2),
fkEmpresa int,
foreign key (fkEmpresa) references empresa (idEmpresa)
);

create table usuario(
idUsuario int auto_increment,
nome varchar(45),
email varchar(35),
senha varchar(45),
fkEmpresa INT,
FOREIGN KEY (fkEmpresa) references empresa (idEmpresa),
primary key(idUsuario, fkEmpresa)
);
--garante que cada combinação de idUsuario e fkEmpresa seja única e, portanto, só é possível ter uma entrada para cada combinação na tabela usuario. --


SELECT * FROM usuario;

create table notebook(
idNotebook int primary key auto_increment,
marca varchar(45),
modelo varchar(45),
capacidadeRam varchar(45),
tipoDisco varchar(45),
velocidadeCpu varchar(45),
fkUsuario int,
foreign key (fkUsuario) references usuario (idUsuario),
fkEmpresa int,
foreign key (fkEmpresa) references empresa (idEmpresa)
);

create table dadosCapturados(
idDadosCapturados int primary key auto_increment,
qtdUsadaRam varchar(45),
tempoAtvDisco varchar(45),
tempoAtvCpu varchar(45),
utilizacaoCpu varchar(45),
qtdProcessoCpu varchar(45),
qtdThreadsCpu varchar(45),
dataHora datetime,
fkNotebook int,
foreign key (fkNotebook) references notebook (idNotebook),
fkUsuario int,
foreign key (fkUsuario) references usuario (idUsuario),
fkEmpresa int,
foreign key (fkEmpresa) references empresa (idEmpresa)
);

/* esta tabela deve estar de acordo com o que está em INSERT de sua API do arduino - dat-acqu-ino */


/*
comando para sql server - banco remoto - ambiente de produção
*/

CREATE TABLE usuario (
	id INT PRIMARY KEY IDENTITY(1,1),
	nome VARCHAR(50),
	email VARCHAR(50),
	senha VARCHAR(50),
);

CREATE TABLE aviso (
	id INT PRIMARY KEY IDENTITY(1,1),
	titulo VARCHAR(100),
	descricao VARCHAR(150),
	fk_usuario INT FOREIGN KEY REFERENCES usuario(id)
);

create table aquario (
/* em nossa regra de negócio, um aquario tem apenas um sensor */
	id INT PRIMARY KEY IDENTITY(1,1),
	descricao VARCHAR(300)
);

/* esta tabela deve estar de acordo com o que está em INSERT de sua API do arduino - dat-acqu-ino */

CREATE TABLE medida (
	id INT PRIMARY KEY IDENTITY(1,1),
	dht11_umidade DECIMAL,
	dht11_temperatura DECIMAL,
	luminosidade DECIMAL,
	lm35_temperatura DECIMAL,
	chave TINYINT,
	momento DATETIME,
	fk_aquario INT FOREIGN KEY REFERENCES aquario(id)
);

/*
comandos para criar usuário em banco de dados azure, sqlserver,
com permissão de insert + update + delete + select
*/

CREATE USER [usuarioParaAPIWebDataViz_datawriter_datareader]
WITH PASSWORD = '#Gf_senhaParaAPIWebDataViz',
DEFAULT_SCHEMA = dbo;

EXEC sys.sp_addrolemember @rolename = N'db_datawriter',
@membername = N'usuarioParaAPIWebDataViz_datawriter_datareader';

EXEC sys.sp_addrolemember @rolename = N'db_datareader',
@membername = N'usuarioParaAPIWebDataViz_datawriter_datareader';