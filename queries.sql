-- ============================================
-- E-COMMERCE — Consultas de Teste
-- ============================================

USE ecommerce;

-- =========================
-- 1. Listar todos os clientes
-- =========================
SELECT idClient, Fname, Lname, CPF, CNPJ, Address, Email
FROM clients;

-- =========================
-- 2. Listar todos os produtos com preço e avaliação
-- =========================
SELECT idProduct, Pname, Category, price, avaliacao, size
FROM product;

-- =========================
-- 3. Listar fornecedores e seus produtos
-- =========================
SELECT s.socialName AS Fornecedor,
       p.Pname AS Produto,
       ps.quantity AS Quantidade
FROM productSupplier ps
JOIN supplier s ON ps.idPSsupplier = s.idSupplier
JOIN product p ON ps.idPSproduct = p.idProduct;

-- =========================
-- 4. Listar vendedores e os produtos que vendem
-- =========================
SELECT se.SocialName AS Vendedor,
       p.Pname AS Produto,
       ps.prodQuantity AS Quantidade
FROM productSeller ps
JOIN seller se ON ps.idPseller = se.idSeller
JOIN product p ON ps.idPproduct = p.idProduct;

-- =========================
-- 5. Listar pedidos com cliente e status
-- =========================
SELECT o.idOrder,
       c.Fname AS Cliente,
       o.orderStatus,
       o.orderDescription,
       o.sendValue,
       o.paymentCash
FROM orders o
JOIN clients c ON o.idOrderClient = c.idClient;

-- =========================
-- 6. Listar entregas com status
-- =========================
SELECT d.idDelivery,
       o.idOrder,
       d.trackingCode,
       d.deliveryStatus
FROM delivery d
JOIN orders o ON d.idOrder = o.idOrder;

-- =========================
-- 7. Produtos em cada pedido
-- =========================
SELECT o.idOrder,
       c.Fname AS Cliente,
       p.Pname AS Produto,
       po.poQuantity AS Quantidade,
       p.price,
       (po.poQuantity * p.price) AS ValorTotalProduto
FROM productOrder po
JOIN orders o ON po.idPOorder = o.idOrder
JOIN clients c ON o.idOrderClient = c.idClient
JOIN product p ON po.idPOproduct = p.idProduct;

-- =========================
-- 8. Valor total de cada pedido
-- =========================
SELECT o.idOrder,
       c.Fname AS Cliente,
       SUM(po.poQuantity * p.price) AS ValorTotalPedido,
       o.sendValue AS Frete,
       SUM(po.poQuantity * p.price) + o.sendValue AS ValorFinal
FROM productOrder po
JOIN orders o ON po.idPOorder = o.idOrder
JOIN clients c ON o.idOrderClient = c.idClient
JOIN product p ON po.idPOproduct = p.idProduct
GROUP BY o.idOrder, c.Fname, o.sendValue;

-- =========================
-- 9. Clientes e seus pagamentos
-- =========================
SELECT c.Fname AS Cliente,
       p.typePayment,
       p.limitAvailable
FROM payments p
JOIN clients c ON p.idClient = c.idClient;

-- =========================
-- 10. Produtos mais caros
-- =========================
SELECT Pname, price
FROM product
ORDER BY price DESC
LIMIT 5;

-- =========================
-- 11. Faturamento total do e-commerce (somente pedidos confirmados)
-- =========================
SELECT SUM(po.poQuantity * pr.price) + SUM(o.sendValue) AS FaturamentoTotal
FROM productOrder po
JOIN orders o ON po.idPOorder = o.idOrder
JOIN product pr ON po.idPOproduct = pr.idProduct
WHERE o.orderStatus = 'Confirmado';
