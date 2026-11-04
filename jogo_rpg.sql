SET NOCOUNT ON;
GO

IF DB_ID(N'JogoRPG') IS NULL
BEGIN
    EXEC(N'CREATE DATABASE [JogoRPG];');
END;
GO

USE [JogoRPG];
GO

IF OBJECT_ID(N'dbo.USUARIOS', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.USUARIOS
    (
        UsuarioId INT IDENTITY(1, 1) NOT NULL,
        Email NVARCHAR(255) NOT NULL,
        Senha NVARCHAR(255) NOT NULL,

        CONSTRAINT PK_USUARIOS PRIMARY KEY (UsuarioId),
        CONSTRAINT UQ_USUARIOS_Email UNIQUE (Email)
    );
END;
GO

IF OBJECT_ID(N'dbo.CLASSES', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.CLASSES
    (
        ClasseId INT IDENTITY(1, 1) NOT NULL,
        Nome NVARCHAR(100) NOT NULL,
        Descricao NVARCHAR(500) NULL,

        CONSTRAINT PK_CLASSES PRIMARY KEY (ClasseId)
    );
END;
GO

IF OBJECT_ID(N'dbo.HABILIDADES', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.HABILIDADES
    (
        HabilidadeId INT IDENTITY(1, 1) NOT NULL,
        Nome NVARCHAR(100) NOT NULL,

        CONSTRAINT PK_HABILIDADES PRIMARY KEY (HabilidadeId)
    );
END;
GO

IF OBJECT_ID(N'dbo.PERSONAGENS', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.PERSONAGENS
    (
        PersonagemId INT IDENTITY(1, 1) NOT NULL,
        NomePersonagem NVARCHAR(100) NOT NULL,
        UsuarioId INT NOT NULL,
        ClasseId INT NOT NULL,

        CONSTRAINT PK_PERSONAGENS PRIMARY KEY (PersonagemId),
        CONSTRAINT FK_PERSONAGENS_USUARIOS
            FOREIGN KEY (UsuarioId) REFERENCES dbo.USUARIOS (UsuarioId),
        CONSTRAINT FK_PERSONAGENS_CLASSES
            FOREIGN KEY (ClasseId) REFERENCES dbo.CLASSES (ClasseId)
    );
END;
GO

IF OBJECT_ID(N'dbo.CLASSES_HABILIDADES', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.CLASSES_HABILIDADES
    (
        ClasseId INT NOT NULL,
        HabilidadeId INT NOT NULL,

        CONSTRAINT PK_CLASSES_HABILIDADES
            PRIMARY KEY (ClasseId, HabilidadeId),
        CONSTRAINT FK_CLASSES_HABILIDADES_CLASSES
            FOREIGN KEY (ClasseId) REFERENCES dbo.CLASSES (ClasseId),
        CONSTRAINT FK_CLASSES_HABILIDADES_HABILIDADES
            FOREIGN KEY (HabilidadeId) REFERENCES dbo.HABILIDADES (HabilidadeId)
    );
END;
GO

SELECT
    TABLE_SCHEMA AS Esquema,
    TABLE_NAME AS Tabela
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'
  AND TABLE_NAME IN
      ('USUARIOS', 'PERSONAGENS', 'CLASSES', 'HABILIDADES', 'CLASSES_HABILIDADES')
ORDER BY TABLE_NAME;

SELECT
    fk.name AS Restricao,
    OBJECT_NAME(fk.parent_object_id) AS TabelaOrigem,
    COL_NAME(fkc.parent_object_id, fkc.parent_column_id) AS ColunaOrigem,
    OBJECT_NAME(fk.referenced_object_id) AS TabelaDestino,
    COL_NAME(fkc.referenced_object_id, fkc.referenced_column_id) AS ColunaDestino
FROM sys.foreign_keys AS fk
INNER JOIN sys.foreign_key_columns AS fkc
    ON fkc.constraint_object_id = fk.object_id
WHERE OBJECT_NAME(fk.parent_object_id) IN
      ('PERSONAGENS', 'CLASSES_HABILIDADES')
ORDER BY TabelaOrigem, Restricao;
