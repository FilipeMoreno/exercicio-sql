create table estado (
	id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    uf VARCHAR(2) NOT NULL,
    nome VARCHAR(50) NOT NULL
);

create table cidade (
	id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
    estado_id INTEGER NOT NULL,
    nome VARCHAR(50) NOT NULL,
    FOREIGN KEY (estado_id) REFERENCES estado(id)
);

create table endereco (
	id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
	cidade_id INTEGER NOT NULL,
    uf VARCHAR(2) NOT NULL,
    logradouro VARCHAR(50) NOT NULL,
    numero VARCHAR(6) DEFAULT 'S/N' NOT NULL,
    complemento VARCHAR(50),
    cep VARCHAR(10) NOT NULL,
    FOREIGN KEY (cidade_id) REFERENCES cidade(id)
);

create table pessoa (
	id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(80) NOT NULL,
    cpf VARCHAR(12) NOT NULL UNIQUE
);

create table pessoa_endereco (
	id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
	pessoa_id INTEGER NOT NULL,
    endereco_id INTEGER NOT NULL,
    FOREIGN KEY (pessoa_id) REFERENCES pessoa(id),
    FOREIGN KEY (endereco_id) REFERENCES endereco(id)
);

create table usuario (
	id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
	pessoa_id INTEGER NOT NULL,
    login VARCHAR(50) NOT NULL,
    senha VARCHAR(50) NOT NULL,
    papel VARCHAR(50) NOT NULL,
    FOREIGN KEY (pessoa_id) REFERENCES pessoa(id)
);

create table recibo (
	id INTEGER NOT NULL PRIMARY KEY AUTO_INCREMENT,
	pessoa_id INTEGER NOT NULL,
    cidade_id INTEGER NOT NULL,
    emissor_id INTEGER NOT NULL,
    descricao VARCHAR(255) NOT NULL,
    data_recibo DATE NOT NULL,
    valor DOUBLE NOT NULL,
    FOREIGN KEY (pessoa_id) REFERENCES pessoa(id),
	FOREIGN KEY (emissor_id) REFERENCES pessoa(id),
	FOREIGN KEY (cidade_id) REFERENCES cidade(id)

);

1 ----------------------------------------------------------

INSERT INTO estado (uf, nome) VALUES ('PR', 'Paraná');
INSERT INTO estado (uf, nome) VALUES ('SP', 'São Paulo');
INSERT INTO estado (uf, nome) VALUES ('SC', 'Santa Catarina');
INSERT INTO estado (uf, nome) VALUES ('AC', 'Acre');
INSERT INTO estado (uf, nome) VALUES ('AL', 'Alagoas');
INSERT INTO estado (uf, nome) VALUES ('AM', 'Amazonas');
INSERT INTO estado (uf, nome) VALUES ('BA', 'Bahia');
INSERT INTO estado (uf, nome) VALUES ('CE', 'Ceará');
INSERT INTO estado (uf, nome) VALUES ('DF', 'Distrito Federal');
INSERT INTO estado (uf, nome) VALUES ('ES', 'Espírito Santo');
INSERT INTO estado (uf, nome) VALUES ('GO', 'Goiás');
INSERT INTO estado (uf, nome) VALUES ('MA', 'Maranhão');
INSERT INTO estado (uf, nome) VALUES ('MT', 'Mato Grosso');
INSERT INTO estado (uf, nome) VALUES ('MS', 'Mato Grosso do Sul');
INSERT INTO estado (uf, nome) VALUES ('PR', 'Paraná');
INSERT INTO estado (uf, nome) VALUES ('MG', 'Minas Gerais');
INSERT INTO estado (uf, nome) VALUES ('PA', 'Pará');
INSERT INTO estado (uf, nome) VALUES ('PB', 'Paraíba');
INSERT INTO estado (uf, nome) VALUES ('PE', 'Pernambuco');
INSERT INTO estado (uf, nome) VALUES ('PI', 'Piauí');
INSERT INTO estado (uf, nome) VALUES ('RJ', 'Rio de Janeiro');
INSERT INTO estado (uf, nome) VALUES ('RN', 'Rio Grande do Norte');
INSERT INTO estado (uf, nome) VALUES ('RS', 'Rio Grande do Sul');
INSERT INTO estado (uf, nome) VALUES ('RO', 'Rondônia');
INSERT INTO estado (uf, nome) VALUES ('RR', 'Roraima');
INSERT INTO estado (uf, nome) VALUES ('SE', 'Sergipe');
INSERT INTO estado (uf, nome) VALUES ('TO', 'Tocantins');

2 ----------------------------------------------------------

INSERT INTO cidade (id, estado_id, nome) VALUES
(1, 1, 'Curitiba'),
(2, 1, 'Maringá'),
(3, 1, 'Lunardeli'),
(4, 1, 'Apucarana'),
(5, 1, 'Santa Fé'),
(6, 1, 'São Miguel do Iguaçu'),
(7, 1, 'Arapongas'),
(8, 1, 'Ponta Grossa'),
(9, 1, 'Jandaia do Sul'),
(10, 2, 'Ribeirão Preto'),
(11, 3, 'Chapecó'),
(12, 3, 'Blumenau'),
(13, 3, 'Joinville');

3 ----------------------------------------------------------

delete 
	from estado 
	where not exists (select * from cidade where cidade.estado_id = estado.id);

4 ----------------------------------------------------------

INSERT INTO cidade (estado_id, nome) VALUES ('2', 'São Paulo');
INSERT INTO cidade (estado_id, nome) VALUES ('2', 'Santos');
INSERT INTO cidade (estado_id, nome) VALUES ('2', 'Osasco');

5 ----------------------------------------------------------

UPDATE cidade SET Nome = 'Cidade Canção' WHERE id = 2;
UPDATE cidade SET Nome = 'Lunardelli' WHERE id = 3;
UPDATE cidade SET Nome = 'Jandaia' WHERE id = 9;

6 ----------------------------------------------------------

select cid.nome, uf.uf 
from cidade cid, estado uf 
where uf.id = cid.estado_id 
order by uf.uf, cid.nome

7 ----------------------------------------------------------

SELECT est.nome AS 'Estado',
	   count(cid.estado_id) AS 'Quantidade de Cidade'
FROM cidade cid, estado est
WHERE cid.estado_id = cid.estado_id
and cid.estado_id = est.id
GROUP BY cid.estado_id

8 ----------------------------------------------------------

ALTER TABLE pessoa_endereco
ADD tipo VARCHAR(30) NOT NULL

9 ----------------------------------------------------------

INSERT INTO pessoa (id, nome, cpf) VALUES
(1, 'Lucas', '0000000001'),
(2, 'Miguel', '0000000002'),
(3, 'Amanda', '0000000003');

INSERT INTO endereco (id, cidade_id, uf, logradouro, numero, complemento, cep) VALUES
(1, 1, 'PR', 'Rua Curitiba', '100', NULL, '00005000'),
(2, 1, 'PR', 'Rua Curitiba', '200', NULL, '00004000'),
(3, 2, 'PR', 'Rua Maringa', '100', NULL, '00003000'),
(4, 2, 'PR', 'Rua Maringa', '200', NULL, '00002000'),
(5, 8, 'PR', 'Rua Ponta Grossa', '100', NULL, '00001000'),
(6, 8, 'PR', 'Rua Ponta Grossa', '200', NULL, '00000900');

INSERT INTO pessoa_endereco (id, pessoa_id, endereco_id, tipo) VALUES
(3, 1, 2, 'RESIDENCIAL'),
(4, 1, 1, 'COMERCIAL'),
(5, 2, 3, 'COMERCIAL'),
(6, 2, 4, 'RESIDENCIAL'),
(7, 3, 5, 'COMERCIAL'),
(8, 3, 6, 'RESIDENCIAL');

10 ----------------------------------------------------------

INSERT INTO pessoa (id, nome, cpf) VALUES
(6, 'Michele', '0000000004'),
(7, 'Bruno', '0000000005');

INSERT INTO endereco (id, cidade_id, uf, logradouro, numero, complemento, cep) VALUES
(11, 14, 'SP', 'Rua Sampa', '100', NULL, '00000800'),
(12, 14, 'SP', 'Rua Sampa', '200', NULL, '00000700'),
(13, 15, 'SP', 'Rua Santos', '100', NULL, '00000600'),
(14, 15, 'SP', 'Rua Santos', '200', NULL, '00000500');

INSERT INTO pessoa_endereco (id, pessoa_id, endereco_id, tipo) VALUES
(13, 6, 11, 'COMERCIAL'),
(14, 6, 12, 'RESIDENCIAL'),
(15, 7, 13, 'COMERCIAL'),
(16, 7, 14, 'RESIDENCIAL');

11 ----------------------------------------------------------

INSERT INTO pessoa (id, nome, cpf) VALUES
(4, 'Taynara', '0000000006'),
(5, 'Filipe', '0000000007');

INSERT INTO endereco (id, cidade_id, uf, logradouro, numero, complemento, cep) VALUES
(7, 11, 'SC', 'Rua Chapecó', '100', NULL, '00000400'),
(8, 11, 'SC', 'Rua Chapecó', '200', NULL, '00000300'),
(9, 13, 'SC', 'Rua Joinville', '100', NULL, '00000200'),
(10, 13, 'SC', 'Rua Joinville', '200', NULL, '00000100');

INSERT INTO pessoa_endereco (id, pessoa_id, endereco_id, tipo) VALUES
(9, 4, 7, 'COMERCIAL'),
(10, 4, 8, 'RESIDENCIAL'),
(11, 5, 9, 'COMERCIAL'),
(12, 5, 10, 'RESIDENCIAL');

12 - Faça um select que retorne o nome das pessoas e seus respectivos endereços (com cidade e estado). Ordene por nome de pessoa, nome do estado e nome da cidade

SELECT p.nome as 'Nome',
	   e.logradouro as 'Endereço',
       cid.nome as 'Cidade',
	   uf.uf as 'Estado'
from pessoa p, estado uf, endereco e, cidade cid, pessoa_endereco pe
WHERE p.id = pe.id
  and pe.id = e.id
  and cid.id = e.cidade_id
  and uf.id = cid.estado_id
 ORDER by uf.uf, p.nome, cid.nome

13 - remova todos as pessoas que tem endereço da cidade de Ribeirão Preto

14 ----------------------------------------------------------

UPDATE endereco SET cep = '00000000'

15 ----------------------------------------------------------

INSERT INTO recibo (id, pessoa_id, cidade_id, emissor_id, descricao, data_recibo, valor) VALUES
(3, 1, 1, 5, 'Recibo #1', '2019-07-01', 50),
(4, 2, 1, 5, 'Recibo #2', '2019-07-06', 20),


16 ----------------------------------------------------------

INSERT INTO recibo (id, pessoa_id, cidade_id, emissor_id, descricao, data_recibo, valor) VALUES
(5, 1, 1, 2, 'Recibo #3', '2019-07-23', 694),
(6, 5, 10, 4, 'Recibo #4', '2019-07-12', 859);

17 ----------------------------------------------------------

select rec.id as Numero,
       rec.data_recibo as Data,
       rec.valor as Valor,
       cli.nome as Nome_Cliente,
       uf_cli.nome as Estado_Cliente,
       emi.nome as Nome_Emissor,
       uf_emi.nome as Estado_Emissor
	from recibo rec, pessoa cli, pessoa_endereco pend_cli, endereco end_cli, cidade cid_cli, estado uf_cli, pessoa emi, pessoa_endereco emi_pend, cidade cid_emi, endereco emi_end, estado uf_emi
	where cli.id = rec.pessoa_id 
		and pend_cli.pessoa_id = cli.id
   		and pend_cli.endereco_id = end_cli.id
    	and cid_cli.id = end_cli.cidade_id 
    	and uf_cli.id = cid_cli.estado_id
   	 	and pend_cli.tipo = 'COMERCIAL'
   	 	and emi.id = rec.emissor_id
    	and emi_pend.pessoa_id = emi.id
    	and emi_pend.endereco_id = emi_end.id
    	and cid_emi.id = emi_end.cidade_id
    	and uf_emi.id = cid_emi.estado_id
    	and emi_pend.tipo = 'COMERCIAL'
    ORDER by rec.data_recibo, cli.nome, emi.nome

18 ----------------------------------------------------------

	SELECT COUNT(DISTINCT rec.id) AS Quantidade_PR,
           sum(rec.valor) AS Soma_Total_PR
	from recibo rec, pessoa emi, pessoa_endereco emi_pend, cidade cid_emi, endereco emi_end, estado uf_emi
	where emi.id = rec.emissor_id
	  	  and emi_pend.pessoa_id = emi.id
	  	  and emi_pend.endereco_id = emi_end.id
	  	  and cid_emi.id = emi_end.cidade_id
	  	  and uf_emi.id = cid_emi.estado_id
	  	  and emi_pend.tipo = 'COMERCIAL'
      	  and uf_emi.id = '1'