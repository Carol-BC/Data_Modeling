-- Gerado por Oracle SQL Developer Data Modeler 22.2.0.165.1149
--   em:        2023-03-17 20:00:51 BRT
--   site:      Oracle Database 21c
--   tipo:      Oracle Database 21c



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

--DROP TABLE T_SGV_FUNCIONARIO CASCADE CONSTRAINTS;
--DROP TABLE T_SGV_CHAMADO CASCADE CONSTRAINTS;
--DROP TABLE T_SGV_TELEFONE CASCADE CONSTRAINTS;
--DROP TABLE T_SGV_VIDEO CASCADE CONSTRAINTS;
--DROP TABLE T_SGV_TIPO_TEL CASCADE CONSTRAINTS;
--DROP TABLE T_SGV_CLIENTE_PF CASCADE CONSTRAINTS;
--DROP TABLE T_SGV_CLIENTE_PJ CASCADE CONSTRAINTS;
--DROP TABLE T_SGV_CLIENTE CASCADE CONSTRAINTS;
--DROP TABLE T_SGV_PRODUTO CASCADE CONSTRAINTS;
--DROP TABLE T_SGV_MOTIVO CASCADE CONSTRAINTS;
--DROP TABLE T_SGV_CARGO CASCADE CONSTRAINTS;
--DROP TABLE T_SGV_DEPARTAMENTO CASCADE CONSTRAINTS;
--DROP TABLE T_SGV_TIPO_VIDEO CASCADE CONSTRAINTS;
--DROP TABLE T_SGV_VISUAL_VID CASCADE CONSTRAINTS;
--DROP TABLE T_SGV_CATEGORIA CASCADE CONSTRAINTS;

--DROP SEQUENCE ID_T_SGV_CARGO;
--DROP SEQUENCE ID_T_SGV_MOTIVO;
--DROP SEQUENCE ID_T_SGV_CAT;
--DROP SEQUENCE ID_T_SGV_CMDO;
--DROP SEQUENCE ID_T_SGV_DPTO;
--DROP SEQUENCE ID_T_SGV_CLIENTE;
--DROP SEQUENCE ID_T_SGV_PROD;
--DROP SEQUENCE ID_T_SGV_TEL;
--DROP SEQUENCE ID_T_SGV_TIPOTEL;
--DROP SEQUENCE ID_T_SGV_FUNC;
--DROP SEQUENCE ID_T_SGV_TIPOVID;
--DROP SEQUENCE ID_T_SGV_VIDEO;


CREATE TABLE t_sgv_cargo (
    cd_cargo        INTEGER NOT NULL,
    cd_funcionario  INTEGER NOT NULL,
    nm_cargo        VARCHAR2(30) NOT NULL,
    cd_departamento VARCHAR2(50) NOT NULL
);

COMMENT ON TABLE t_sgv_cargo IS
    'Tabela para cadastro dos cargos.';

COMMENT ON COLUMN t_sgv_cargo.cd_cargo IS
    'Codigo de identificação do cargo. ';

COMMENT ON COLUMN t_sgv_cargo.nm_cargo IS
    'Nomenclatura do cargo, escita em letras maiusculas.';

COMMENT ON COLUMN t_sgv_cargo.cd_departamento IS
    'Código de identificação do departamento. ';

CREATE UNIQUE INDEX t_sgv_cargo_idx ON
    t_sgv_cargo (
        cd_cargo
    ASC );

ALTER TABLE t_sgv_cargo ADD CONSTRAINT pk_t_sgv_cargo PRIMARY KEY ( cd_cargo );

CREATE TABLE t_sgv_categoria (
    cd_categoria           INTEGER NOT NULL,
    ds_descricao_categoria VARCHAR2(100) NOT NULL,
    nm_categoria           VARCHAR2(50) NOT NULL,
    st_status              CHAR(1) NOT NULL,
    dt_data_inicio         DATE NOT NULL,
    dt_data_final          DATE
);

COMMENT ON TABLE t_sgv_categoria IS
    'Tabela para armazenamento das classificação/categoria dos produtos.';

COMMENT ON COLUMN t_sgv_categoria.cd_categoria IS
    'Codigo da categoria dos produtos.';

COMMENT ON COLUMN t_sgv_categoria.ds_descricao_categoria IS
    'Descrição da categoria.';

COMMENT ON COLUMN t_sgv_categoria.nm_categoria IS
    'Nomenclatura da categoria.';

COMMENT ON COLUMN t_sgv_categoria.st_status IS
    'Status da categoria, podendo ser (A) ativa ou (I) inativa.';

COMMENT ON COLUMN t_sgv_categoria.dt_data_inicio IS
    'Data de inicio da categoria, formato DD/MM/AAAA.';

COMMENT ON COLUMN t_sgv_categoria.dt_data_final IS
    'Data final da categoria, formato DD/MM/AAAA.';

CREATE INDEX t_sgv_categoria_idx ON
    t_sgv_categoria (
        cd_categoria
    ASC );

ALTER TABLE t_sgv_categoria
    ADD CONSTRAINT ck_t_sgv_categoria CHECK ( st_status IN ( 'A', 'I' ) );

ALTER TABLE t_sgv_categoria ADD CONSTRAINT ck_t_sgv_dt_abertura_final CHECK ( dt_data_final >= dt_data_inicio );

ALTER TABLE t_sgv_categoria ADD CONSTRAINT pk_t_sgv_categoria PRIMARY KEY ( cd_categoria );

ALTER TABLE t_sgv_categoria ADD CONSTRAINT un_t_sgv_categ_desc UNIQUE ( ds_descricao_categoria );

CREATE TABLE t_sgv_chamado (
    cd_chamado               INTEGER NOT NULL,
    cd_cliente               INTEGER NOT NULL,
    cd_produto               INTEGER NOT NULL,
    cd_funcionario           INTEGER,
    cd_tipo_chamado          CHAR(1) NOT NULL,
    st_status_chamado        CHAR(1) NOT NULL,
    tx_texto_chamado         VARCHAR2(4000) NOT NULL,
    dt_data_hora_abertura    TIMESTAMP NOT NULL,
    dt_data_hora_finalizacao TIMESTAMP,
    tp_tempo_atendimento     TIMESTAMP,
    in_indice_satisfacao     VARCHAR2(2)
);

COMMENT ON TABLE t_sgv_chamado IS
    'Tabela para armazenamento dos dados de chamados. ';

COMMENT ON COLUMN t_sgv_chamado.cd_chamado IS
    'Codigo de identificação do chamado. ';

COMMENT ON COLUMN t_sgv_chamado.cd_tipo_chamado IS
    'Informação de tipo de chamado.';

COMMENT ON COLUMN t_sgv_chamado.st_status_chamado IS
    'Informação do status do chamado.';

COMMENT ON COLUMN t_sgv_chamado.tx_texto_chamado IS
    'Descrição do motivo da abertura do chamado, detalhamento preenchido pelo cliente.';

COMMENT ON COLUMN t_sgv_chamado.dt_data_hora_abertura IS
    'Informação de data e hora da abertura do chamado, formato DD/MM/AAAA 00:00:00.';

COMMENT ON COLUMN t_sgv_chamado.dt_data_hora_finalizacao IS
    'Informação de data e hora da finalização  do chamado, formato DD/MM/AAAA 00:00:00.';

COMMENT ON COLUMN t_sgv_chamado.tp_tempo_atendimento IS
    'Informação do tempo de duração do chamado, calculado desde a abertura até a finalização.';

COMMENT ON COLUMN t_sgv_chamado.in_indice_satisfacao IS
    'Informação de avaliação do indice de satisfação mediante a finalização/conclusão do chamado.';

CREATE INDEX t_sgv_chamado_idx ON
    t_sgv_chamado (
        cd_chamado
    ASC );

ALTER TABLE t_sgv_chamado
    ADD CONSTRAINT ck_t_sgv_tipo_chamado CHECK ( cd_tipo_chamado IN ( '1', '2' ) );

ALTER TABLE t_sgv_chamado
    ADD CONSTRAINT ck_t_sgv_st_status_chamado CHECK ( st_status_chamado IN ( 'A', 'E', 'C', 'F', 'X' ) );

ALTER TABLE t_sgv_chamado ADD CONSTRAINT ck_t_sgv_dt_abertura_cham CHECK ( dt_data_hora_finalizacao >= dt_data_hora_abertura );

ALTER TABLE t_sgv_chamado ADD CONSTRAINT pk_t_sgv_chamado PRIMARY KEY ( cd_chamado );

CREATE TABLE t_sgv_cliente (
    cd_cliente             INTEGER NOT NULL,
    cd_login               VARCHAR2(10) NOT NULL,
    nm_cliente             VARCHAR2(100) NOT NULL,
    st_status_cliente      CHAR(1) NOT NULL,
    cd_senha               VARCHAR2(8) NOT NULL,
    qt_quantidade_estrelas NUMBER(2),
    tp_tipo_cliente        NUMBER NOT NULL
);

COMMENT ON TABLE t_sgv_cliente IS
    'Tabela para armazenamento do cadastro do cliente.';

COMMENT ON COLUMN t_sgv_cliente.cd_login IS
    'Identificação do cliente dentro do site, Formato CF0000.';

COMMENT ON COLUMN t_sgv_cliente.nm_cliente IS
    'Nome completo do cliente, escrita em letras maiusculas.';

COMMENT ON COLUMN t_sgv_cliente.st_status_cliente IS
    'Informação de status do cliente.';

COMMENT ON COLUMN t_sgv_cliente.cd_senha IS
    'Informação de senha do cliente para realizar o login, maximo de 8 digitos.';

COMMENT ON COLUMN t_sgv_cliente.tp_tipo_cliente IS
    'Expecificação do tipo de cliente, podendo ser pessoa fisica ou juridica.';

CREATE INDEX t_sgv_cliente_idx ON
    t_sgv_cliente (
        cd_cliente
    ASC );

ALTER TABLE t_sgv_cliente
    ADD CONSTRAINT ck_t_sgv_cliente CHECK ( st_status_cliente IN ( 'A', 'I' ) );

ALTER TABLE t_sgv_cliente
    ADD CONSTRAINT ck_t_sgv_cliente_pj_pf CHECK ( tp_tipo_cliente IN ( '1', '0' ) );

ALTER TABLE t_sgv_cliente ADD CONSTRAINT pk_t_sgv_cliente PRIMARY KEY ( cd_cliente );

ALTER TABLE t_sgv_cliente ADD CONSTRAINT un_t_sgv_cd_login UNIQUE ( cd_login );

CREATE TABLE t_sgv_cliente_pf (
    cd_cliente         INTEGER NOT NULL,
    nr_cpf             VARCHAR2(11) NOT NULL,
    dt_data_nascimento DATE NOT NULL,
    ds_sexo            CHAR(1) NOT NULL,
    ds_genero          VARCHAR2(10)
);

COMMENT ON TABLE t_sgv_cliente_pf IS
    'Tabela para armazenamento dos dados do cliente Pessoa Fisica.';

COMMENT ON COLUMN t_sgv_cliente_pf.nr_cpf IS
    'Numero de CPF do cliente.';

COMMENT ON COLUMN t_sgv_cliente_pf.dt_data_nascimento IS
    'Data de nascimento do cliente, formato DD/MM/AAAA.';

COMMENT ON COLUMN t_sgv_cliente_pf.ds_sexo IS
    'Informação de sexo do cliente.';

COMMENT ON COLUMN t_sgv_cliente_pf.ds_genero IS
    'Informação de genero do cliente.';

ALTER TABLE t_sgv_cliente_pf
    ADD CONSTRAINT ck_t_sgv_cliente_ds_sexo CHECK ( ds_sexo IN ( 'M', 'F' ) );

ALTER TABLE t_sgv_cliente_pf ADD CONSTRAINT pk_t_sgv_cliente_pf PRIMARY KEY ( cd_cliente );

ALTER TABLE t_sgv_cliente_pf ADD CONSTRAINT un_t_sgv_cliente_cpf UNIQUE ( nr_cpf );

CREATE TABLE t_sgv_cliente_pj (
    cd_cliente            INTEGER NOT NULL,
    nr_cnpj               VARCHAR2(14),
    nr_inscricao_estadual VARCHAR2(9),
    dt_data_fundacao      DATE,
    nm_fantasia           VARCHAR2(100)
);

COMMENT ON TABLE t_sgv_cliente_pj IS
    'Tabela para armazenamento dos dados do cliente Pessoa Juridica.';

COMMENT ON COLUMN t_sgv_cliente_pj.nr_cnpj IS
    'Numero de CNPJ da empresa cliente. ';

COMMENT ON COLUMN t_sgv_cliente_pj.nr_inscricao_estadual IS
    'Numero de inscrição estadual da empresa.';

COMMENT ON COLUMN t_sgv_cliente_pj.dt_data_fundacao IS
    'Data de fundação da empresa, formato DD/MM/AAAA.';

COMMENT ON COLUMN t_sgv_cliente_pj.nm_fantasia IS
    'Nome fantasia da empresa.';

ALTER TABLE t_sgv_cliente_pj ADD CONSTRAINT pk_t_sgv_cliente_pj PRIMARY KEY ( cd_cliente );

ALTER TABLE t_sgv_cliente_pj ADD CONSTRAINT un_t_sgv_pj_cnpj UNIQUE ( nr_cnpj );

ALTER TABLE t_sgv_cliente_pj ADD CONSTRAINT un_t_sgv_pj_ins_estad UNIQUE ( nr_inscricao_estadual );

CREATE TABLE t_sgv_departamento (
    cd_departamento INTEGER NOT NULL,
    nm_departamento VARCHAR2(50)
);

COMMENT ON TABLE t_sgv_departamento IS
    'Tabela para cadastro de departamentos.';

COMMENT ON COLUMN t_sgv_departamento.cd_departamento IS
    'Codigo de identificação do departamento. ';

COMMENT ON COLUMN t_sgv_departamento.nm_departamento IS
    'Nome do departamento, escrito em letras maiusculas. ';

CREATE INDEX t_sgv_departamento_idx ON
    t_sgv_departamento (
        cd_departamento
    ASC );

ALTER TABLE t_sgv_departamento ADD CONSTRAINT pk_t_sgv_departamento PRIMARY KEY ( cd_departamento );

ALTER TABLE t_sgv_departamento ADD CONSTRAINT un_t_sgv_nome_dpto UNIQUE ( nm_departamento );

CREATE TABLE t_sgv_funcionario (
    cd_funcionario  INTEGER NOT NULL,
    cd_cargo        INTEGER NOT NULL,
    cd_departamento INTEGER NOT NULL,
    nr_cpf          VARCHAR2(14) NOT NULL,
    ds_email        VARCHAR2(50) NOT NULL,
    nm_funcionario  VARCHAR2(100) NOT NULL,
    dt_nascimento   DATE NOT NULL,
    cd_telefone     NUMBER NOT NULL
);

COMMENT ON TABLE t_sgv_funcionario IS
    'Tabela para cadastro dos funcionários.';

COMMENT ON COLUMN t_sgv_funcionario.cd_funcionario IS
    'Codigo de identificação do funcionario. ';

COMMENT ON COLUMN t_sgv_funcionario.nr_cpf IS
    'Numero de CPF do colaborador.';

COMMENT ON COLUMN t_sgv_funcionario.ds_email IS
    'Endereço de e-mail corporativo do funcionario.';

COMMENT ON COLUMN t_sgv_funcionario.nm_funcionario IS
    'Nome completo do funcionario.';

COMMENT ON COLUMN t_sgv_funcionario.dt_nascimento IS
    'data de nascimento do funcionario, formato DD/MM/AAAA.';

CREATE UNIQUE INDEX t_sgv_funcionario_idx ON
    t_sgv_funcionario (
        cd_funcionario
    ASC );

ALTER TABLE t_sgv_funcionario ADD CONSTRAINT pk_t_sgv_funcionario PRIMARY KEY ( cd_funcionario );

ALTER TABLE t_sgv_funcionario ADD CONSTRAINT un_t_sgv_func_numero UNIQUE ( nr_cpf );

ALTER TABLE t_sgv_funcionario ADD CONSTRAINT un_t_sgv_func_email UNIQUE ( ds_email );

CREATE TABLE t_sgv_motivo (
    cd_motivo      INTEGER NOT NULL,
    cd_chamado     INTEGER NOT NULL,
    cd_produto     INTEGER NOT NULL,
    cd_funcionario INTEGER NOT NULL,
    nm_nome_motivo VARCHAR2(100) NOT NULL
);

COMMENT ON TABLE t_sgv_motivo IS
    'Tabela para armazenamento do motivos de abertura dos chamados.';

COMMENT ON COLUMN t_sgv_motivo.nm_nome_motivo IS
    'Informação/titulo do motivo de abertura do chamado.';

CREATE UNIQUE INDEX t_sgv_motivo_idx ON
    t_sgv_motivo (
        cd_chamado
    ASC );

ALTER TABLE t_sgv_motivo ADD CONSTRAINT pk_t_sgv_motivo PRIMARY KEY ( cd_motivo );

CREATE TABLE t_sgv_produto (
    cd_produto            INTEGER NOT NULL,
    cd_categoria          INTEGER NOT NULL,
    nm_produto            VARCHAR2(30) NOT NULL,
    ds_descricao_normal   VARCHAR2(100) NOT NULL,
    ds_descricao_completa VARCHAR2(100) NOT NULL,
    vl_valor_unitario     NUMBER(7, 2) NOT NULL,
    st_status_produto     CHAR(1) NOT NULL,
    nr_codigo_ean13       VARCHAR2(48),
    qt_maxima_vendas      INTEGER
);

COMMENT ON COLUMN t_sgv_produto.cd_produto IS
    'Codigo de identificação do produto.';

COMMENT ON COLUMN t_sgv_produto.nm_produto IS
    'Nome do produto.';

COMMENT ON COLUMN t_sgv_produto.ds_descricao_normal IS
    'Descrição simples do produto.';

COMMENT ON COLUMN t_sgv_produto.ds_descricao_completa IS
    'Descrição completa e detalhada do produto.';

COMMENT ON COLUMN t_sgv_produto.vl_valor_unitario IS
    'Valor/custo unitario do produto, formato R$ 0.000,00.';

COMMENT ON COLUMN t_sgv_produto.st_status_produto IS
    'Informação de status do produto, podendo variar entre (A) ativo e (I) inativo.';

COMMENT ON COLUMN t_sgv_produto.qt_maxima_vendas IS
    'Informação da quantidade maxima possivel de vendas, total de produtos disponiveis.';

CREATE INDEX t_sgv_produto_idx ON
    t_sgv_produto (
        cd_produto
    ASC );

ALTER TABLE t_sgv_produto
    ADD CONSTRAINT ck_t_sgv_produto CHECK ( st_status_produto IN ( 'A', 'I' ) );

ALTER TABLE t_sgv_produto ADD CONSTRAINT pk_t_sgv_produto PRIMARY KEY ( cd_produto );

ALTER TABLE t_sgv_produto ADD CONSTRAINT un_t_sgv_pdt_descricao UNIQUE ( ds_descricao_normal );

ALTER TABLE t_sgv_produto ADD CONSTRAINT un_t_sgv_nm_prod UNIQUE ( nm_produto );

CREATE TABLE t_sgv_telefone (
    cd_telefone    INTEGER NOT NULL,
    cd_funcionario INTEGER,
    cd_tipo_fone   INTEGER NOT NULL,
    cd_cliente     INTEGER,
    nr_ddd         CHAR(2) NOT NULL,
    nr_telefone    NUMBER(9) NOT NULL,
    nr_ramal       CHAR(4)
);

COMMENT ON TABLE t_sgv_telefone IS
    'Tabela de armazenamento de dados telefonicos. ';

COMMENT ON COLUMN t_sgv_telefone.nr_ddd IS
    'Numero de DDD, sendo composto por 2 dígitos. ';

COMMENT ON COLUMN t_sgv_telefone.nr_telefone IS
    'Numero do telefone.';

COMMENT ON COLUMN t_sgv_telefone.nr_ramal IS
    'Numero de ramal.';

CREATE UNIQUE INDEX t_sgv_telefone_idx ON
    t_sgv_telefone (
        cd_telefone
    ASC );

ALTER TABLE t_sgv_telefone ADD CONSTRAINT pk_t_sgv_telefone PRIMARY KEY ( cd_telefone );

CREATE TABLE t_sgv_tipo_tel (
    cd_tipo_fone INTEGER NOT NULL,
    ds_tipo_fone VARCHAR2(20) NOT NULL
);

COMMENT ON TABLE t_sgv_tipo_tel IS
    'Tabela para armazenar o tipo telefônico.';

COMMENT ON COLUMN t_sgv_tipo_tel.cd_tipo_fone IS
    'Codigo de identificação do tipo de telefone.';

COMMENT ON COLUMN t_sgv_tipo_tel.ds_tipo_fone IS
    'Identificação do tipo de telefone.';

CREATE INDEX t_sgv_tipo_tel_idx ON
    t_sgv_tipo_tel (
        cd_tipo_fone
    ASC );

ALTER TABLE t_sgv_tipo_tel ADD CONSTRAINT pk_t_sgv_tipo_tel PRIMARY KEY ( cd_tipo_fone );

CREATE TABLE t_sgv_tipo_video (
    cd_tipo_video           INTEGER NOT NULL,
    ds_descricao_tipo_video VARCHAR2(100) NOT NULL
);

COMMENT ON TABLE t_sgv_tipo_video IS
    'Tabela para armazenamento dos tipos de vídeo.';

COMMENT ON COLUMN t_sgv_tipo_video.cd_tipo_video IS
    'Codigo do tipo de video.';

COMMENT ON COLUMN t_sgv_tipo_video.ds_descricao_tipo_video IS
    'Descrição do tipo de video armazenado.';

CREATE INDEX t_sgv_tipo_video_idx ON
    t_sgv_tipo_video (
        cd_tipo_video
    ASC );

ALTER TABLE t_sgv_tipo_video ADD CONSTRAINT pk_t_sgv_tipo_video PRIMARY KEY ( cd_tipo_video );

CREATE TABLE t_sgv_video (
    cd_video        INTEGER NOT NULL,
    cd_produto      INTEGER NOT NULL,
    cd_tipo_video   INTEGER NOT NULL,
    st_status_video CHAR(1) NOT NULL
);

COMMENT ON TABLE t_sgv_video IS
    'Tabela para armazenamento de vídeos.';

COMMENT ON COLUMN t_sgv_video.cd_video IS
    'Codigo ';

COMMENT ON COLUMN t_sgv_video.st_status_video IS
    'Informação de status do video, podendo variar entre (A) ativo e (I) inativo.';

CREATE INDEX t_sgv_video_idx ON
    t_sgv_video (
        cd_video
    ASC );

ALTER TABLE t_sgv_video
    ADD CONSTRAINT ck_t_sgv_video CHECK ( st_status_video IN ( 'A', 'I', 'P' ) );

ALTER TABLE t_sgv_video ADD CONSTRAINT pk_t_sgv_video PRIMARY KEY ( cd_video );

CREATE TABLE t_sgv_visual_vid (
    cd_video                  INTEGER NOT NULL,
    dt_data_hora_visualizacao TIMESTAMP WITH LOCAL TIME ZONE NOT NULL,
    cd_cliente                INTEGER
);

COMMENT ON TABLE t_sgv_visual_vid IS
    'Tabela para armazenamento das informações de visualização dos vídeos.';

COMMENT ON COLUMN t_sgv_visual_vid.dt_data_hora_visualizacao IS
    'Informação de data e hora de visualização dos videos, formato DD/MM/AAAA 00:00:00.';

CREATE INDEX t_sgv_visual_vid_idx ON
    t_sgv_visual_vid (
        dt_data_hora_visualizacao
    ASC,
        cd_video
    ASC );

ALTER TABLE t_sgv_visual_vid ADD CONSTRAINT pk_t_sgv_visual_vid PRIMARY KEY ( cd_video,
                                                                              dt_data_hora_visualizacao );

ALTER TABLE t_sgv_cargo
    ADD CONSTRAINT fk_t_sgv_cargo_funcionario FOREIGN KEY ( cd_funcionario )
        REFERENCES t_sgv_funcionario ( cd_funcionario );

ALTER TABLE t_sgv_chamado
    ADD CONSTRAINT fk_t_sgv_chamado_cliente FOREIGN KEY ( cd_cliente )
        REFERENCES t_sgv_cliente ( cd_cliente );

ALTER TABLE t_sgv_chamado
    ADD CONSTRAINT fk_t_sgv_chamado_func FOREIGN KEY ( cd_funcionario )
        REFERENCES t_sgv_funcionario ( cd_funcionario );

ALTER TABLE t_sgv_chamado
    ADD CONSTRAINT fk_t_sgv_chamado_prod FOREIGN KEY ( cd_produto )
        REFERENCES t_sgv_produto ( cd_produto );

ALTER TABLE t_sgv_cliente_pf
    ADD CONSTRAINT fk_t_sgv_cliente_pf FOREIGN KEY ( cd_cliente )
        REFERENCES t_sgv_cliente ( cd_cliente );

ALTER TABLE t_sgv_cliente_pj
    ADD CONSTRAINT fk_t_sgv_cliente_pj FOREIGN KEY ( cd_cliente )
        REFERENCES t_sgv_cliente ( cd_cliente );

ALTER TABLE t_sgv_funcionario
    ADD CONSTRAINT fk_t_sgv_func_dpto FOREIGN KEY ( cd_departamento )
        REFERENCES t_sgv_departamento ( cd_departamento );

ALTER TABLE t_sgv_funcionario
    ADD CONSTRAINT fk_t_sgv_funcionario_cargo FOREIGN KEY ( cd_cargo )
        REFERENCES t_sgv_cargo ( cd_cargo );

ALTER TABLE t_sgv_motivo
    ADD CONSTRAINT fk_t_sgv_motivo_chamado FOREIGN KEY ( cd_chamado )
        REFERENCES t_sgv_chamado ( cd_chamado );

ALTER TABLE t_sgv_motivo
    ADD CONSTRAINT fk_t_sgv_motivo_func FOREIGN KEY ( cd_funcionario )
        REFERENCES t_sgv_funcionario ( cd_funcionario );

ALTER TABLE t_sgv_motivo
    ADD CONSTRAINT fk_t_sgv_motivo_prod FOREIGN KEY ( cd_produto )
        REFERENCES t_sgv_produto ( cd_produto );

ALTER TABLE t_sgv_produto
    ADD CONSTRAINT fk_t_sgv_prod_categ FOREIGN KEY ( cd_categoria )
        REFERENCES t_sgv_categoria ( cd_categoria );

ALTER TABLE t_sgv_telefone
    ADD CONSTRAINT fk_t_sgv_tel_cliente FOREIGN KEY ( cd_cliente )
        REFERENCES t_sgv_cliente ( cd_cliente );

ALTER TABLE t_sgv_telefone
    ADD CONSTRAINT fk_t_sgv_tel_func FOREIGN KEY ( cd_funcionario )
        REFERENCES t_sgv_funcionario ( cd_funcionario );

ALTER TABLE t_sgv_telefone
    ADD CONSTRAINT fk_t_sgv_tel_tipo_tel FOREIGN KEY ( cd_tipo_fone )
        REFERENCES t_sgv_tipo_tel ( cd_tipo_fone );

ALTER TABLE t_sgv_video
    ADD CONSTRAINT fk_t_sgv_video_produto FOREIGN KEY ( cd_produto )
        REFERENCES t_sgv_produto ( cd_produto );

ALTER TABLE t_sgv_video
    ADD CONSTRAINT fk_t_sgv_video_tipo FOREIGN KEY ( cd_tipo_video )
        REFERENCES t_sgv_tipo_video ( cd_tipo_video );

ALTER TABLE t_sgv_visual_vid
    ADD CONSTRAINT fk_t_sgv_visual_cliente FOREIGN KEY ( cd_cliente )
        REFERENCES t_sgv_cliente ( cd_cliente );

ALTER TABLE t_sgv_visual_vid
    ADD CONSTRAINT fk_t_sgv_visual_video FOREIGN KEY ( cd_video )
        REFERENCES t_sgv_video ( cd_video );

CREATE OR REPLACE TRIGGER arc_fkarc_4_t_sgv_cliente_pf BEFORE
    INSERT OR UPDATE OF cd_cliente ON t_sgv_cliente_pf
    FOR EACH ROW
DECLARE
    d NUMBER;
BEGIN
    SELECT
        a.tp_tipo_cliente
    INTO d
    FROM
        t_sgv_cliente a
    WHERE
        a.cd_cliente = :new.cd_cliente;

    IF ( d IS NULL OR d <> 0 ) THEN
        raise_application_error(-20223, 'FK FK_T_SGV_CLIENTE_PF in Table T_SGV_CLIENTE_PF violates Arc constraint on Table T_SGV_CLIENTE - discriminator column tp_tipo_cliente doesn''t have value 0'
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE OR REPLACE TRIGGER arc_fkarc_4_t_sgv_cliente_pj BEFORE
    INSERT OR UPDATE OF cd_cliente ON t_sgv_cliente_pj
    FOR EACH ROW
DECLARE
    d NUMBER;
BEGIN
    SELECT
        a.tp_tipo_cliente
    INTO d
    FROM
        t_sgv_cliente a
    WHERE
        a.cd_cliente = :new.cd_cliente;

    IF ( d IS NULL OR d <> 1 ) THEN
        raise_application_error(-20223, 'FK FK_T_SGV_CLIENTE_PJ in Table T_SGV_CLIENTE_PJ violates Arc constraint on Table T_SGV_CLIENTE - discriminator column tp_tipo_cliente doesn''t have value 1'
        );
    END IF;

EXCEPTION
    WHEN no_data_found THEN
        NULL;
    WHEN OTHERS THEN
        RAISE;
END;
/

CREATE SEQUENCE id_t_sgv_cargo START WITH 1 MINVALUE 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER t_sgv_cargo_cd_cargo_trg BEFORE
    INSERT ON t_sgv_cargo
    FOR EACH ROW
BEGIN
    :new.cd_cargo := id_t_sgv_cargo.nextval;
END;
/

CREATE SEQUENCE id_t_sgv_cat START WITH 1 MINVALUE 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER t_sgv_categoria_cd_categoria BEFORE
    INSERT ON t_sgv_categoria
    FOR EACH ROW
BEGIN
    :new.cd_categoria := id_t_sgv_cat.nextval;
END;
/

CREATE SEQUENCE id_t_sgv_cmdo START WITH 1 MINVALUE 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER t_sgv_chamado_cd_chamado_trg BEFORE
    INSERT ON t_sgv_chamado
    FOR EACH ROW
BEGIN
    :new.cd_chamado := id_t_sgv_cmdo.nextval;
END;
/

CREATE SEQUENCE id_t_sgv_cliente START WITH 1 MINVALUE 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER t_sgv_cliente_cd_cliente_trg BEFORE
    INSERT ON t_sgv_cliente
    FOR EACH ROW
BEGIN
    :new.cd_cliente := id_t_sgv_cliente.nextval;
END;
/

CREATE SEQUENCE id_t_sgv_dpto START WITH 1 MINVALUE 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER t_sgv_departamento_cd_departam BEFORE
    INSERT ON t_sgv_departamento
    FOR EACH ROW
BEGIN
    :new.cd_departamento := id_t_sgv_dpto.nextval;
END;
/

CREATE SEQUENCE id_t_sgv_func START WITH 1 MINVALUE 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER t_sgv_funcionario_cd_funcionar BEFORE
    INSERT ON t_sgv_funcionario
    FOR EACH ROW
BEGIN
    :new.cd_funcionario := id_t_sgv_func.nextval;
END;
/

CREATE SEQUENCE id_t_sgv_motivo START WITH 1 MINVALUE 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER t_sgv_motivo_cd_motivo_trg BEFORE
    INSERT ON t_sgv_motivo
    FOR EACH ROW
BEGIN
    :new.cd_motivo := id_t_sgv_motivo.nextval;
END;
/

CREATE SEQUENCE id_t_sgv_prod START WITH 1 MINVALUE 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER t_sgv_produto_cd_produto_trg BEFORE
    INSERT ON t_sgv_produto
    FOR EACH ROW
BEGIN
    :new.cd_produto := id_t_sgv_prod.nextval;
END;
/

CREATE SEQUENCE id_t_sgv_tel START WITH 1 MINVALUE 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER t_sgv_telefone_cd_telefone_trg BEFORE
    INSERT ON t_sgv_telefone
    FOR EACH ROW
BEGIN
    :new.cd_telefone := id_t_sgv_tel.nextval;
END;
/

CREATE SEQUENCE id_t_sgv_tipotel START WITH 1 MINVALUE 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER t_sgv_tipo_tel_cd_tipo_fone BEFORE
    INSERT ON t_sgv_tipo_tel
    FOR EACH ROW
    WHEN ( new.cd_tipo_fone IS NULL )
BEGIN
    :new.cd_tipo_fone := id_t_sgv_tipotel.nextval;
END;
/

CREATE SEQUENCE id_t_sgv_tipovid START WITH 1 MINVALUE 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER t_sgv_tipo_video_cd_tipo_video BEFORE
    INSERT ON t_sgv_tipo_video
    FOR EACH ROW
BEGIN
    :new.cd_tipo_video := id_t_sgv_tipovid.nextval;
END;
/

CREATE SEQUENCE id_t_sgv_video START WITH 1 MINVALUE 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER t_sgv_video_cd_video_trg BEFORE
    INSERT ON t_sgv_video
    FOR EACH ROW
BEGIN
    :new.cd_video := id_t_sgv_video.nextval;
END;
/

CREATE OR REPLACE TRIGGER t_sgv_visual_vid_cd_video_trg BEFORE
    INSERT ON t_sgv_visual_vid
    FOR EACH ROW
BEGIN
    :new.cd_video := id_t_sgv_video.nextval;
END;
/



-- Relatório do Resumo do Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            15
-- CREATE INDEX                            13
-- ALTER TABLE                             54
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                          15
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                         12
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
