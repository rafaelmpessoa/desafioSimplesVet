CREATE SCHEMA `simplesvet` DEFAULT CHARACTER SET utf8 ;

USE `simplesvet`;

CREATE TABLE `racas` (
  `RAC_CODIGO` int(11) NOT NULL AUTO_INCREMENT,
  `RAC_DESCRICAO` varchar(100) NOT NULL,
  `RAC_ESPECIE` tinyint NOT NULL,
  PRIMARY KEY (`RAC_CODIGO`)
);


CREATE TABLE `animais` (
  `ANI_CODIGO` int(11) NOT NULL AUTO_INCREMENT,
  `ANI_NOME` varchar(100) NOT NULL,
  `ANI_SEXO` varchar(1) NOT NULL,
  `ANI_ESPECIE` varchar(1) NOT NULL,
  `ANI_CHIP` varchar(20) NOT NULL,
  `ANI_DT_NASCIMENTO` date NOT NULL,
  `ANI_DT_UPDATE` datetime NULL,
  `ANI_DT_FALECIMENTO` date NULL,
  `RAC_CODIGO` int not NULL,
  `ANI_IMG` varchar(60) NULL,
  PRIMARY KEY (`ANI_CODIGO`),
  CONSTRAINT `FK_ANIMAL_RACA` FOREIGN KEY (`RAC_CODIGO`) REFERENCES `racas` (`RAC_CODIGO`)
);

COMMIT;

ALTER TABLE `racas`
ADD RAC_SITUACAO varchar(3) NOT NULL DEFAULT 'ATI';

INSERT INTO `racas`(RAC_DESCRICAO,RAC_ESPECIE) VALUES('Retrievers (Labrador)',1);
INSERT INTO `racas`(RAC_DESCRICAO,RAC_ESPECIE) VALUES('German Shepherd Dogs',1);
INSERT INTO `racas`(RAC_DESCRICAO,RAC_ESPECIE) VALUES('Retrievers (Golden)',1);
INSERT INTO `racas`(RAC_DESCRICAO,RAC_ESPECIE) VALUES('French Bulldogs',1);
INSERT INTO `racas`(RAC_DESCRICAO,RAC_ESPECIE) VALUES('Bulldogs',1);
INSERT INTO `racas`(RAC_DESCRICAO,RAC_ESPECIE) VALUES('Beagles',1);
INSERT INTO `racas`(RAC_DESCRICAO,RAC_ESPECIE) VALUES('Poodles',1);
INSERT INTO `racas`(RAC_DESCRICAO,RAC_ESPECIE) VALUES('Rottweilers',1);
INSERT INTO `racas`(RAC_DESCRICAO,RAC_ESPECIE) VALUES('Yorkshire Terriers',1);
INSERT INTO `racas`(RAC_DESCRICAO,RAC_ESPECIE) VALUES('Pointers (German Shorthaired)',1);
INSERT INTO `racas`(RAC_DESCRICAO,RAC_ESPECIE) VALUES('Siamese',2);
INSERT INTO `racas`(RAC_DESCRICAO,RAC_ESPECIE) VALUES('Persian',2);
INSERT INTO `racas`(RAC_DESCRICAO,RAC_ESPECIE) VALUES('Maine Coon',2);
INSERT INTO `racas`(RAC_DESCRICAO,RAC_ESPECIE) VALUES('Ragdoll',2);
INSERT INTO `racas`(RAC_DESCRICAO,RAC_ESPECIE) VALUES('Devon Rex',2);
INSERT INTO `racas`(RAC_DESCRICAO,RAC_ESPECIE) VALUES('Bengal',2);
INSERT INTO `racas`(RAC_DESCRICAO,RAC_ESPECIE) VALUES('Abyssinian',2);
INSERT INTO `racas`(RAC_DESCRICAO,RAC_ESPECIE) VALUES('Birman',2);
INSERT INTO `racas`(RAC_DESCRICAO,RAC_ESPECIE) VALUES('Oriental Shorthair',2);
INSERT INTO `racas`(RAC_DESCRICAO,RAC_ESPECIE) VALUES('Sphynx',2);

DELIMITER $$
CREATE FUNCTION fc_retornaIdade(dtNascimento date)
RETURNS int
DETERMINISTIC
BEGIN 
  DECLARE age int;
  SET age = TIMESTAMPDIFF(YEAR, dtNascimento, now());
  RETURN age;
END$$
DELIMITER ;

CREATE VIEW vw_racas AS
SELECT RAC_CODIGO as id, 
RAC_DESCRICAO as raca,
CASE 
    WHEN RAC_ESPECIE = 1 THEN 'Cachorro'
    WHEN RAC_ESPECIE = 2 THEN 'Gato'
    ELSE 'Espécie não identificada!'
END as especie,
RAC_ESPECIE as kindOfPet,
CASE 
    WHEN RAC_SITUACAO = 'ATI' THEN 'Ativo'
    WHEN RAC_SITUACAO = 'INA' THEN 'Inativo'
    ELSE 'Situação não identificada!'
END as situacao
FROM racas;



CREATE VIEW vw_animais as 
SELECT ANI_CODIGO as id,
ANI_NOME as name,
CASE 
    WHEN ANI_SEXO = 'M' THEN 'Macho'
    WHEN ANI_SEXO = 'F' THEN 'Fêmea'
    ELSE 'Sexo não identificado!'
END as gender,
CASE 
    WHEN ANI_ESPECIE = 1 THEN 'Cachorro'
    WHEN ANI_ESPECIE = 2 THEN 'Gato'
    ELSE 'Espécie não identificada!'
END as especie,
ANI_ESPECIE as kindOfPet,
ANI_CHIP as chip,
DATE_FORMAT(ANI_DT_NASCIMENTO,'%d/%m/%Y') as dtBorn,
DATE_FORMAT(ANI_DT_UPDATE,'%d/%m/%Y') as dtUpdate,
DATE_FORMAT(ANI_DT_FALECIMENTO,'%d/%m/%Y') as dtDeath,
animais.RAC_CODIGO as codRaca,
racas.RAC_DESCRICAO as raca,
fc_retornaIdade(ANI_DT_NASCIMENTO) as age,
CASE
    WHEN ANI_DT_FALECIMENTO <= now() THEN 'true'
    ELSE 'false' END as isAlive,
ANI_IMG as path
FROM animais
inner join racas 
on animais.RAC_CODIGO = racas.RAC_CODIGO



DELIMITER $$
CREATE PROCEDURE sp_animal_insert(
    IN  nome varchar(100),
    IN  sexo varchar(1),
    IN  especie varchar(1),
    IN chip  varchar(20),
    IN dtNascimento date,
    IN dtFalecimento date,
    IN raca_cod int,
    IN img int
)
BEGIN
    INSERT INTO animais(ANI_NOME,ANI_SEXO,ANI_ESPECIE,ANI_CHIP,ANI_DT_NASCIMENTO,ANI_DT_FALECIMENTO,RAC_CODIGO,ANI_IMG)
    VALUES(nome,sexo,especie,chip,dtNascimento,dtFalecimento,raca_cod,img);
END$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_animal_update(
    IN cod int,
    IN  nome varchar(100),
    IN  sexo varchar(1),
    IN  especie varchar(1),
    IN chip  varchar(20),
    IN dtNascimento date,
    IN dtFalecimento date,
    IN raca_cod int
)
BEGIN
    UPDATE animais
        SET ANI_NOME = nome
        ,ANI_SEXO = sexo
        ,ANI_ESPECIE = especie
        ,ANI_CHIP = chip
        ,ANI_DT_NASCIMENTO = dtNascimento
        ,ANI_DT_FALECIMENTO = dtFalecimento
        ,RAC_CODIGO = raca_cod
        ,ANI_DT_UPDATE = now()
        WHERE ANI_CODIGO = cod;
END$$
DELIMITER ;