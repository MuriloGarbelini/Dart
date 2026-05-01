# Atividade Flutter - Gestão de Pet Shop

Projeto criado do zero para a atividade.

## Funcionalidades
- Login com validação simples (`admin` / `1234`).
- Menu principal com navegação para produtos.
- Cadastro de produto com formulário (nome, descrição, preço, categoria).
- Integração com MockAPI para:
  - `GET` (listar produtos)
  - `POST` (criar produto)

## Estrutura
- `lib/main.dart`: app e rotas
- `lib/screens`: telas
- `lib/models`: modelo de produto
- `lib/services`: integração REST

## Como rodar
1. Instale Flutter SDK.
2. Entre na pasta do projeto:
   ```bash
   cd atividade_petshop_flutter
   ```
3. Instale dependências:
   ```bash
   flutter pub get
   ```
4. Execute:
   ```bash
   flutter run
   ```
