-- ============================================
-- E-COMMERCE — Estrutura do Banco de Dados
-- ============================================

DROP DATABASE IF EXISTS ecommerce;
CREATE DATABASE ecommerce;
USE ecommerce;

-- =========================
-- CLIENTS (PF ou PJ)
-- =========================
CREATE TABLE clients (
  idClient INT AUTO_INCREMENT PRIMARY KEY,
  Fname VARCHAR(30),
  Minit CHAR(3),
  Lname VARCHAR(50),
  CPF CHAR(11),
  CNPJ CHAR(14),
  Address VARCHAR(100),
  Email VARCHAR(150),

  CONSTRAINT unique_cpf_client UNIQUE (CPF),
  CONSTRAINT unique_cnpj_client UNIQUE (CNPJ),
  CONSTRAINT unique_email_client UNIQUE (Email)
);

-- =========================
-- PRODUCT
-- =========================
CREATE TABLE product (
  idProduct INT AUTO_INCREMENT PRIMARY KEY,
  Pname VARCHAR(100) NOT NULL,
  Classification_kids BOOL DEFAULT FALSE,
  Category ENUM('Eletrônico','Vestuário','Brinquedos','Alimentos','Móveis','Em processamento')
           DEFAULT 'Em processamento',
  avaliacao FLOAT DEFAULT 0,   -- nota de 0 a 5
  price FLOAT DEFAULT 0,       -- valor monetário
  size VARCHAR(10),

  CONSTRAINT ck_product_avaliacao CHECK (avaliacao BETWEEN 0 AND 5),
  CONSTRAINT ck_product_size CHECK (size IN ('P','M','G','GG') OR size IS NULL)
);

-- =========================
-- PAYMENTS
-- =========================
CREATE TABLE payments (
  idPayment INT AUTO_INCREMENT PRIMARY KEY,
  idClient INT NOT NULL,
  typePayment ENUM('Boleto','Cartão','Dois cartões') NOT NULL,
  limitAvailable FLOAT DEFAULT 0,

  CONSTRAINT ck_payments_limit_nonneg CHECK (limitAvailable >= 0),
  CONSTRAINT fk_payments_client FOREIGN KEY (idClient)
    REFERENCES clients(idClient)
);

-- =========================
-- ORDERS
-- =========================
CREATE TABLE orders (
  idOrder INT AUTO_INCREMENT PRIMARY KEY,
  idOrderClient INT NOT NULL,
  orderStatus ENUM('Cancelado','Confirmado','Em processamento') NOT NULL,
  orderDescription VARCHAR(255),
  sendValue FLOAT DEFAULT 10,
  paymentCash BOOL DEFAULT FALSE,

  CONSTRAINT ck_orders_sendvalue_nonneg CHECK (sendValue >= 0),
  CONSTRAINT fk_orders_client FOREIGN KEY (idOrderClient)
    REFERENCES clients(idClient) 
    ON UPDATE CASCADE
);

-- =========================
-- DELIVERY
-- =========================
CREATE TABLE delivery (
  idDelivery INT AUTO_INCREMENT PRIMARY KEY,
  idOrder INT NOT NULL,
  trackingCode VARCHAR(50) NOT NULL,
  deliveryStatus ENUM('Em transporte','Entregue','Cancelado') DEFAULT 'Em transporte',

  CONSTRAINT fk_delivery_order FOREIGN KEY (idOrder)
    REFERENCES orders(idOrder)
    ON DELETE CASCADE
);

-- =========================
-- PRODUCT STORAGE
-- =========================
CREATE TABLE productStorage (
  idProdStorage INT AUTO_INCREMENT PRIMARY KEY,
  storageLocation VARCHAR(255) NOT NULL,
  quantity INT DEFAULT 0,

  CONSTRAINT ck_productStorage_qty_nonneg CHECK (quantity >= 0)
);

-- =========================
-- SUPPLIER
-- =========================
CREATE TABLE supplier (
  idSupplier INT AUTO_INCREMENT PRIMARY KEY,
  socialName VARCHAR(255) NOT NULL,
  CNPJ CHAR(14) NOT NULL,
  contact VARCHAR(20) NOT NULL,
  Email VARCHAR(150),

  CONSTRAINT unique_supplier_cnpj UNIQUE (CNPJ),
  CONSTRAINT unique_supplier_email UNIQUE (Email)
);

-- =========================
-- PRODUCT x SUPPLIER
-- =========================
CREATE TABLE productSupplier (
  idPSproduct INT,
  idPSsupplier INT,
  quantity INT NOT NULL,

  PRIMARY KEY (idPSproduct, idPSsupplier),
  CONSTRAINT fk_productSupplier_product FOREIGN KEY (idPSproduct)
    REFERENCES product(idProduct),
  CONSTRAINT fk_productSupplier_supplier FOREIGN KEY (idPSsupplier)
    REFERENCES supplier(idSupplier)
    ON DELETE CASCADE
);

-- =========================
-- SELLER
-- =========================
CREATE TABLE seller (
  idSeller INT AUTO_INCREMENT PRIMARY KEY,
  SocialName VARCHAR(255) NOT NULL,
  AbstName VARCHAR(255),
  CNPJ CHAR(14),
  CPF CHAR(11),
  location VARCHAR(255),
  contact VARCHAR(20) NOT NULL,
  Email VARCHAR(150),

  CONSTRAINT unique_cnpj_seller UNIQUE (CNPJ),
  CONSTRAINT unique_cpf_seller UNIQUE (CPF),
  CONSTRAINT unique_email_seller UNIQUE (Email)
);

-- =========================
-- PRODUCT x SELLER
-- =========================
CREATE TABLE productSeller (
  idPseller INT,
  idPproduct INT,
  prodQuantity INT DEFAULT 1,

  PRIMARY KEY (idPseller, idPproduct),
  CONSTRAINT ck_productSeller_qty_nonneg CHECK (prodQuantity >= 0),
  CONSTRAINT fk_productSeller_seller FOREIGN KEY (idPseller)
    REFERENCES seller(idSeller),
  CONSTRAINT fk_productSeller_product FOREIGN KEY (idPproduct)
    REFERENCES product(idProduct)
);

-- =========================
-- PRODUCT x ORDER
-- =========================
CREATE TABLE productOrder (
  idPOproduct INT,
  idPOorder INT,
  poQuantity INT DEFAULT 1,
  poStatus ENUM('Disponivel','Sem estoque') DEFAULT 'Disponivel',

  PRIMARY KEY (idPOproduct, idPOorder),
  CONSTRAINT ck_productOrder_qty_nonneg CHECK (poQuantity >= 0),
  CONSTRAINT fk_productOrder_product FOREIGN KEY (idPOproduct)
    REFERENCES product(idProduct),
  CONSTRAINT fk_productOrder_orders FOREIGN KEY (idPOorder)
    REFERENCES orders(idOrder)
);

-- =========================
-- STORAGE LOCATION
-- =========================
CREATE TABLE storageLocation (
  idLproduct INT,
  idLstorage INT,
  location VARCHAR(255) NOT NULL,

  PRIMARY KEY (idLproduct, idLstorage),
  CONSTRAINT fk_storageLocation_product FOREIGN KEY (idLproduct)
    REFERENCES product(idProduct),
  CONSTRAINT fk_storageLocation_storage FOREIGN KEY (idLstorage)
    REFERENCES productStorage(idProdStorage)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
