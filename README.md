# 🛒 Projeto SQL - Banco de Dados E-commerce

## 📌 Descrição
Este projeto replica a modelagem lógica de um banco de dados para um cenário de **e-commerce**, aplicando conceitos de modelagem conceitual e refinamentos propostos.  
O objetivo é criar o esquema lógico em SQL, popular com dados de teste e realizar consultas complexas para validar o funcionamento.

---

## 🗂 Estrutura do Banco
O banco de dados `ecommerce` contém as seguintes tabelas principais:

- **clients** → Cadastro de clientes PF e PJ (uma conta pode ser PF ou PJ, mas não ambos).
- **product** → Produtos com avaliação (0–5) e preço monetário.
- **supplier** → Fornecedores com CNPJ e contato.
- **seller** → Vendedores com CNPJ/CPF e contato.
- **orders** → Pedidos com status e descrição.
- **payments** → Formas de pagamento (um cliente pode ter várias).
- **delivery** → Entregas com status e código de rastreio.
- **productSupplier** → Relação produto ↔ fornecedor.
- **productSeller** → Relação produto ↔ vendedor.
- **productOrder** → Relação produto ↔ pedido.
- **productStorage / storageLocation** → Controle de estoque e localização.

---

## 📂 Scripts
- `estrutura.sql` → Criação do esquema lógico do banco.  
- `insercoes.sql` → Inserção de dados de teste.  
- `queries.sql` → Consultas SQL para validação e relatórios.  

---

## 🔎 Consultas Implementadas
As queries incluem:
- Recuperações simples com `SELECT`.
- Filtros com `WHERE`.
- Atributos derivados (ex.: cálculo de valor total de pedidos).
- Ordenações com `ORDER BY`.
- Condições de grupo com `HAVING`.
- Junções entre tabelas (`JOIN`).

### Exemplos de perguntas respondidas:
- Quantos pedidos foram feitos por cada cliente?  
- Relação de produtos e fornecedores.  
- Relação de vendedores e produtos.  
- Valor total de cada pedido (incluindo frete).  
- Faturamento total do e-commerce (somente pedidos confirmados).  
- Top 5 produtos mais caros.  

---

## ▶️ Como Executar
1. Clone este repositório:
   ```bash
   git clone https://github.com/seuusuario/ecommerce-sql.git
