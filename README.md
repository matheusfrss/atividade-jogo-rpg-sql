# Atividade — Banco de dados do jogo de RPG online

Este diretório contém a entrega da atividade de Linguagem de Definição de
Dados (DDL), baseada no diagrama fornecido.

## Arquivo da atividade

- `jogo_rpg.sql`: cria o banco `JogoRPG`, as cinco tabelas do modelo, as chaves
  primárias, as chaves estrangeiras e os relacionamentos.

## Estrutura implementada

| Tabela | Função |
| --- | --- |
| `USUARIOS` | Armazena os usuários do jogo. |
| `PERSONAGENS` | Armazena personagens e relaciona cada personagem a um usuário e a uma classe. |
| `CLASSES` | Armazena as classes dos personagens. |
| `HABILIDADES` | Armazena as habilidades disponíveis. |
| `CLASSES_HABILIDADES` | Tabela associativa do relacionamento N:N entre classes e habilidades. |

## Como executar

1. Abra o SQL Server Management Studio (SSMS) ou outro gerenciador compatível
   com Microsoft SQL Server.
2. Conecte-se à instância do SQL Server.
3. Abra o arquivo `jogo_rpg.sql`.
4. Execute o script completo.
5. Atualize a pasta **Databases** e confirme a criação do banco `JogoRPG` e das
   tabelas dentro de `dbo`.

O script pode ser executado novamente sem recriar as tabelas que já existirem.
Ao final, duas consultas de conferência exibem as tabelas e os relacionamentos.

## Relacionamentos do modelo

- `USUARIOS (1) -> PERSONAGENS (N)` por meio de `PERSONAGENS.UsuarioId`.
- `CLASSES (1) -> PERSONAGENS (N)` por meio de `PERSONAGENS.ClasseId`.
- `CLASSES (N) <-> HABILIDADES (N)` por meio de `CLASSES_HABILIDADES`.

> Observação: em um sistema real, o campo `Senha` deve armazenar somente um
> hash seguro da senha, nunca a senha em texto puro.

## Publicação no GitHub

Depois de criar ou selecionar um repositório no GitHub, publique o conteúdo
deste diretório. O link do arquivo `jogo_rpg.sql` pode ser copiado pela opção
**Copy permalink** ou pela URL do arquivo no repositório e enviado no AVA.
