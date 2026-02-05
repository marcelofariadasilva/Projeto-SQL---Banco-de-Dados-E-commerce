-- ============================================
-- E-COMMERCE — Inserções de Dados de Teste
-- ============================================

USE ecommerce;

-- =========================
-- CLIENTES (PF e PJ)
-- =========================
INSERT INTO clients (Fname, Minit, Lname, CPF, Address, Email)
VALUES 
('João','A','Silva','12345678901','Rua A, 100','joao@email.com'),
('Maria','B','Oliveira','98765432100','Rua B, 200','maria@email.com'),
('Carlos','C','Souza','45678912399','Rua C, 300','carlos@email.com');

INSERT INTO clients (Fname, Minit, Lname, CNPJ, Address, Email)
VALUES 
('Empresa','X','Comércio','12345678000199','Av. Central, 200','empresa@email.com'),
('Distribuidora','Y','Alimentos','98765432000188','Av. Norte, 500','distribuidora@email.com');

-- =========================
-- PRODUTOS
-- =========================
-- avaliacao = nota (0–5), price = valor monetário
INSERT INTO product (Pname, Classification_kids, Category, avaliacao, price, size)
VALUES 
('Notebook', FALSE, 'Eletrônico', 4.5, 4500, NULL),
('Camiseta', FALSE, 'Vestuário', 3.8, 80, 'M'),
('Boneca', TRUE, 'Brinquedos', 4.2, 120, NULL),
('Mesa de Jantar', FALSE, 'Móveis', 4.0, 1500, NULL),
('Chocolate', FALSE, 'Alimentos', 4.7, 10, NULL);

-- =========================
-- FORNECEDORES
-- =========================
INSERT INTO supplier (socialName, CNPJ, contact, Email)
VALUES 
('Fornecedor Tech','11111111000111','21999999999','tech@email.com'),
('Fornecedor Moda','22222222000122','21988888888','moda@email.com'),
('Fornecedor Brinquedos','33333333000133','21977777777','brinq@email.com');

-- =========================
-- VENDEDORES
-- =========================
INSERT INTO seller (SocialName, AbstName, CNPJ, location, contact, Email)
VALUES 
('Loja Online','Loja','44444444000144','Rio de Janeiro','21966666666','loja@email.com'),
('Mega Store','Mega','55555555000155','São Paulo','11955555555','megastore@email.com');

-- =========================
-- PAGAMENTOS
-- =========================
INSERT INTO payments (idClient, typePayment, limitAvailable)
VALUES 
(1,'Cartão',2000),
(2,'Cartão',1500),
(3,'Boleto',500),
(4,'Dois cartões',10000),
(5,'Cartão',8000);

-- =========================
-- PEDIDOS
-- =========================
INSERT INTO orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash)
VALUES 
(1,'Confirmado','Compra de Notebook',20,FALSE),
(2,'Em processamento','Compra de Boneca',15,TRUE),
(3,'Cancelado','Compra de Camiseta',10,FALSE),
(4,'Confirmado','Compra de Mesa de Jantar',50,FALSE),
(5,'Confirmado','Compra de Chocolate',5,TRUE);

-- =========================
-- ENTREGAS
-- =========================
INSERT INTO delivery (idOrder, trackingCode, deliveryStatus)
VALUES 
(1,'BR123456789','Em transporte'),
(2,'BR987654321','Em transporte'),
(4,'BR555555555','Entregue'),
(5,'BR666666666','Entregue');

-- =========================
-- PRODUTO x FORNECEDOR
-- =========================
INSERT INTO productSupplier (idPSproduct, idPSsupplier, quantity)
VALUES 
(1,1,50),
(2,2,100),
(3,3,200),
(4,1,30),
(5,2,500);

-- =========================
-- PRODUTO x VENDEDOR
-- =========================
INSERT INTO productSeller (idPseller, idPproduct, prodQuantity)
VALUES 
(1,1,10),
(1,2,20),
(2,3,15),
(2,4,5),
(2,5,100),
(1,3,8),   -- par único extra
(1,4,12);  -- par único extra

-- =========================
-- PRODUTO x PEDIDO
-- =========================
INSERT INTO productOrder (idPOproduct, idPOorder, poQuantity, poStatus)
VALUES 
(1,1,1,'Disponivel'),
(3,2,2,'Disponivel'),
(2,3,1,'Disponivel'),
(4,4,1,'Disponivel'),
(5,5,10,'Disponivel'),
(1,2,1,'Disponivel'),  -- par único extra
(2,4,2,'Disponivel');  -- par único extra
