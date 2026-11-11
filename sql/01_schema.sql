-- ============================================================
-- RestMan - Script tao CSDL (18 bang)
-- Chay: mysql -u root -p < sql/01_schema.sql
-- ============================================================

DROP DATABASE IF EXISTS restman;
CREATE DATABASE restman CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE restman;

CREATE TABLE tblMember (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(255) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,            -- SHA-256 hex (64 ký tự)
  fullName VARCHAR(255) NOT NULL,
  dateOfBirth DATE NULL,
  address VARCHAR(255) NULL,
  phoneNumber VARCHAR(255) NULL,
  email VARCHAR(255) NULL,
  role VARCHAR(50) NOT NULL                  -- CUSTOMER | MANAGER | SALES | WAREHOUSE
);

CREATE TABLE tblMembershipCard (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  cardID VARCHAR(255) NOT NULL UNIQUE,
  tier VARCHAR(255) NULL,
  points INT NULL
);

CREATE TABLE tblCustomer (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  tblMemberid INT NOT NULL UNIQUE,
  tblMembershipCardid INT NULL UNIQUE,
  FOREIGN KEY (tblMemberid) REFERENCES tblMember(id),
  FOREIGN KEY (tblMembershipCardid) REFERENCES tblMembershipCard(id)
);

CREATE TABLE tblManager (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  employeeID VARCHAR(255) NOT NULL UNIQUE,
  position VARCHAR(255) NOT NULL,
  tblMemberid INT NOT NULL UNIQUE,
  FOREIGN KEY (tblMemberid) REFERENCES tblMember(id)
);

CREATE TABLE tblSalesEmployee (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  employeeID VARCHAR(255) NOT NULL UNIQUE,
  position VARCHAR(255) NOT NULL,
  tblMemberid INT NOT NULL UNIQUE,
  FOREIGN KEY (tblMemberid) REFERENCES tblMember(id)
);

CREATE TABLE tblWarehouseEmployee (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  employeeID VARCHAR(255) NOT NULL UNIQUE,
  position VARCHAR(255) NOT NULL,
  tblMemberid INT NOT NULL UNIQUE,
  FOREIGN KEY (tblMemberid) REFERENCES tblMember(id)
);

CREATE TABLE tblTable (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  tableID VARCHAR(255) NOT NULL UNIQUE,
  seatCount INT NOT NULL,
  status VARCHAR(255) NOT NULL
);

CREATE TABLE tblTableReservation (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  reservationDate DATETIME NULL,
  status VARCHAR(255) NOT NULL,
  tblCustomerid INT NOT NULL,
  tblTableid INT NOT NULL,
  tblSalesEmployeeid INT NULL,
  FOREIGN KEY (tblCustomerid) REFERENCES tblCustomer(id),
  FOREIGN KEY (tblTableid) REFERENCES tblTable(id),
  FOREIGN KEY (tblSalesEmployeeid) REFERENCES tblSalesEmployee(id)
);

CREATE TABLE tblOnlineOrder (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  orderDate DATETIME NULL,
  status VARCHAR(255) NOT NULL,
  tblCustomerid INT NOT NULL,
  tblSalesEmployeeid INT NULL,
  FOREIGN KEY (tblCustomerid) REFERENCES tblCustomer(id),
  FOREIGN KEY (tblSalesEmployeeid) REFERENCES tblSalesEmployee(id)
);

CREATE TABLE tblDish (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  dishID VARCHAR(255) NOT NULL UNIQUE,
  dishName VARCHAR(255) NOT NULL,
  category VARCHAR(255) NOT NULL,
  price FLOAT NULL,
  image VARCHAR(255) NULL,
  description VARCHAR(255) NULL,
  tblManagerid INT NULL,
  FOREIGN KEY (tblManagerid) REFERENCES tblManager(id)
);

CREATE TABLE tblOnlineOrderDetail (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  quantity INT NULL,
  tblOnlineOrderid INT NOT NULL,
  tblDishid INT NOT NULL,
  FOREIGN KEY (tblOnlineOrderid) REFERENCES tblOnlineOrder(id),
  FOREIGN KEY (tblDishid) REFERENCES tblDish(id)
);

CREATE TABLE tblCombo (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  comboID VARCHAR(255) NOT NULL UNIQUE,
  comboName VARCHAR(255) NOT NULL,
  price FLOAT NULL,
  description VARCHAR(255) NULL,
  tblManagerid INT NULL,
  FOREIGN KEY (tblManagerid) REFERENCES tblManager(id)
);

CREATE TABLE tblComboDetail (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  quantity INT NULL,
  tblComboid INT NOT NULL,
  tblDishid INT NOT NULL,
  FOREIGN KEY (tblComboid) REFERENCES tblCombo(id),
  FOREIGN KEY (tblDishid) REFERENCES tblDish(id)
);

CREATE TABLE tblIngredient (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  ingredientID VARCHAR(255) NOT NULL UNIQUE,
  ingredientName VARCHAR(255) NOT NULL,
  stockQuantity FLOAT NULL,
  unit VARCHAR(255) NULL,
  expiryDate DATE NULL
);

CREATE TABLE tblSupplier (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  supplierID VARCHAR(255) NOT NULL UNIQUE,
  supplierName VARCHAR(255) NOT NULL,
  address VARCHAR(255) NULL,
  phoneNumber VARCHAR(255) NULL,
  note VARCHAR(255) NULL
);

CREATE TABLE tblSupplierIngredient (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  tblSupplierid INT NOT NULL,
  tblIngredientid INT NOT NULL,
  FOREIGN KEY (tblSupplierid) REFERENCES tblSupplier(id),
  FOREIGN KEY (tblIngredientid) REFERENCES tblIngredient(id)
);

CREATE TABLE tblImportInvoice (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  invoiceID VARCHAR(255) NOT NULL UNIQUE,
  createdDate DATE NOT NULL,
  tblSupplierid INT NOT NULL,
  tblWarehouseEmployeeid INT NOT NULL,
  FOREIGN KEY (tblSupplierid) REFERENCES tblSupplier(id),
  FOREIGN KEY (tblWarehouseEmployeeid) REFERENCES tblWarehouseEmployee(id),
  INDEX idx_invoice_supplier_date (tblSupplierid, createdDate)
);

CREATE TABLE tblImportDetail (
  id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
  quantity FLOAT NOT NULL,
  unitPrice FLOAT NOT NULL,
  tblImportInvoiceid INT NOT NULL,
  tblIngredientid INT NOT NULL,
  FOREIGN KEY (tblImportInvoiceid) REFERENCES tblImportInvoice(id),
  FOREIGN KEY (tblIngredientid) REFERENCES tblIngredient(id)
);
