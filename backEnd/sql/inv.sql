-- Delete Existing Tables--
	DROP TABLE IF EXISTS Inventory;
	DROP TABLE IF EXISTS WorkOrders;
	DROP TABLE IF EXISTS Quotes;
	DROP TABLE IF EXISTS Employees;
	DROP TABLE IF EXISTS Customers;
    DROP TABLE IF EXISTS class;
	DROP TABLE IF EXISTS invoices;
    DROP TABLE IF EXISTS parts;
    DROP TABLE IF EXISTS Bills;
    DROP TABLE IF EXISTS accountReceivable;

-- Create Tables --   
CREATE TABLE Inventory (
	partID VARCHAR(20) PRIMARY KEY,
	description VARCHAR(100) default 'No description',
	quantity INT,
	price REAL,
    brand VARCHAR(50) default 'Unknown brand',
    cost REAL,
    source VARCHAR(50) default 'Unknown source',
	classNo INT
  );

CREATE TABLE Class (
	classNo INT PRIMARY KEY,
    description VARCHAR(100),
    margin1 REAL,
    margin2 REAL,
    margin3 REAL
);

CREATE TABLE parts(
	ID INT, -- invoice No/ WorkOrder No/ Quote No
	partID VARCHAR(20),
    quantity INT,
    cost REAL
);

CREATE TABLE Invoices (
	invNo INT PRIMARY KEY, -- RANGE: 3000~3999 
	cusNo INT, 
	empNo INT,
    subTotal REAL,
	taxTotal REAL,
    total REAL,
    invDate DATE,
    CONSTRAINT rangeCheck CHECK (invNo >= 3000 AND invNo < 4000)
  );

CREATE TABLE WorkOrders (
	workNo INT PRIMARY KEY, -- RANGE: 2000~2999 
	cusNo INT, 
	empNo INT,
    subTotal REAL,
	taxTotal REAL,
    total REAL,
    date DATE,
    CONSTRAINT rangeCheck CHECK (workNo >= 2000 AND workNo < 3000)
  );

CREATE TABLE Quotes (
	quoteNo INT PRIMARY KEY, -- RANGE: 1000~1999 
	cusNo INT, 
	empNo INT,
    subTotal REAL,
	taxTotal REAL,
    total REAL,
    date DATE,
    CONSTRAINT rangeCheck CHECK (quoteNo >= 1000 AND quoteNo < 2000)
  );
  
CREATE TABLE Employees (
	name VARCHAR(20),
	userName VARCHAR(20) UNIQUE,
	password VARCHAR(20),
	empNo INT PRIMARY KEY,
	address VARCHAR(50),
	phone VARCHAR(16),
	role VARCHAR(20)
  );
  
CREATE TABLE Customers (
	cusNo INT PRIMARY KEY,
	name VARCHAR(50),
	phone VARCHAR(16),
	credit bigint,
	email VARCHAR(100),
	address VARCHAR(50),
    billing VARCHAR(50),
    shipping VARCHAR(50),
    cityTax REAL default 0.05,
    stateTax REAL default 0.1,
    federalTax REAL default 0.025,
    chargeMax float,
    currentCharge float
);

CREATE TABLE AccountReceivable(
	accountNo INT,
    amount float,
    dateDue DATE
);

CREATE TABLE Bills(
	accountNo INT,
    amount float,
    payDate DATE
);

-- Insert Test data into table--
INSERT INTO Employees(name, userName, password, empNo, address, phone, role) VALUES ('John Smith', 'john', '1234', 1000, '1000 Johnson, Jonesboro, AR, 72401', '123-456-7890', 'admin');
INSERT INTO Employees(name, userName, password, empNo, address, phone, role) VALUES ('Cade Powers', 'cade', '1234', 1001, '2134 Red Wold, Jonesboro, AR, 72142', '321-654-0987', 'admin');
INSERT INTO Employees(name, userName, password, empNo, address, phone, role) VALUES ('Patrick Cade', 'patrick', '1234', 1002, '1234 Qwertrt, Jonesboro, AR, 72401', '456-789-7890', 'admin');
INSERT INTO Employees(name, userName, password, empNo, address, phone, role) VALUES ('Fady Farag', 'fady', '1234', 1003, '1345 Johnson, Jonesboro, AR, 72401', '759-186-4451', 'admin');
INSERT INTO Employees(name, userName, password, empNo, address, phone, role) VALUES ('Ryouji Sezai', 'ryouji', '1234', 1004, '2560 E Johnson, Jonesboro, AR, 72401', '758-458-7894', 'admin');
INSERT INTO Employees(name, userName, password, empNo, address, phone, role) VALUES ('Xxx Xxxx', 'xxxx', '1234', 1005, '1000 Johnson, Jonesboro, AR, 72401', '123-456-7890', 'admin');

INSERT INTO Customers (cusNo, name, phone, credit, email, address, billing, shipping, chargeMax, currentCharge) VALUES (001, 'Redstone', '741-852-9306', 5113888844440000, 'redline@gmail.com', '1234 Elvin Lane, Carbot, AR 72023', 'POBox 203 Ruelle, AR, 72451', 'ATTN: Robby 1234 Redstone St. Ruelle, AR, 72451', 2000.00, 1000.00);
INSERT INTO Customers (cusNo, name, phone, credit, email, address, billing, shipping, chargeMax, currentCharge) VALUES (002, 'Rust Bucket', '789-671-0549', 7415845795687135, 'rust@gmail.com', '7896 Carr, Jonesboro, AR 72467', 'POBox 310 Jonesboro, AR, 72451', '7896 Carr, Jonesboro, AR 72467', 3000.00, 500.24);
INSERT INTO Customers (cusNo, name, phone, credit, email, address, billing, shipping, chargeMax, currentCharge) VALUES (003, 'Full of It trucking', '789-671-0549', 7415845795687135, 'full@gmail.com', '9842 Johnson, Jonesboro, AR 72467', 'POBox 203 Little Rock, AR, 72451', '9842 Johnson, Jonesboro, AR 72467', 3000.00, 500.24);
INSERT INTO Customers (cusNo, name, phone, credit, email, address, billing, shipping, chargeMax, currentCharge) VALUES (004, 'Freightliner', '789-671-0549', 7415845795687135, 'freight@gmail.com', '7896 Johnson, University, AR 72467', 'POBox 456 University, AR 72467', '7896 Johnson, University, AR 72467', 3000.00, 500.24);
INSERT INTO Customers (cusNo, name, phone, credit, email, address, billing, shipping, chargeMax, currentCharge) VALUES (005, 'Peterbilt', '789-671-0549', 7415845795687135, 'peter@gmail.com', '1294 Johnson, Jonesboro, AR 72467', 'POBox 278 Jonesboro, AR 72467', '1294 Johnson, Jonesboro, AR 72467', 3000.00, 500.24);

INSERT INTO Inventory (partID, quantity, price, brand, cost, classNo) VALUES ('45125A', 4, 320.00, 'Alpha', 80, 001);
INSERT INTO Inventory (partID, quantity, price, brand, cost, classNo) VALUES ('184125A', 10, 800.00, 'Bravo', 80.00, 001);
INSERT INTO Inventory (partID, quantity, price, brand, cost, classNo) VALUES ('175999B', 2, 80.00, 'Charlie', 40.00, 002);
INSERT INTO Inventory (partID, quantity, price, brand, cost, classNo) VALUES ('789000B', 28, 126, 'Delta', 4.50, 001);
INSERT INTO Inventory (partID, quantity, price, brand, cost, classNo) VALUES ('123456A', 70, 700, 'Echo', 100.00, 001);
INSERT INTO Inventory (partID, quantity, price, brand, cost, classNo) VALUES ('45125C', 5, 2000.00, 'Foxtrot', 400.00, 003);

INSERT INTO Class (classNo, description, margin1, margin2, margin3) VALUES (001, 'Gears', 1.2, 1.6, 2.0);
INSERT INTO Class (classNo, description, margin1, margin2, margin3) VALUES (002, 'Flywheel', 1.4, 1.8, 2.2);
INSERT INTO Class (classNo, description, margin1, margin2, margin3) VALUES (003, 'Tire', 1.1, 1.2, 1.5);

INSERT INTO Invoices (invNo, cusNo, empNo, subTotal, taxTotal, total, invDate) VALUES (3001, 001, 1000, 480.00, 84.00, 564.00, '2020-10-01');
INSERT INTO Invoices (invNo, cusNo, empNo, subTotal, taxTotal, total, invDate) VALUES (3002, 002, 1001, 245, 42.88, 287.88, '2020-10-05');
INSERT INTO Invoices (invNo, cusNo, empNo, subTotal, taxTotal, total, invDate) VALUES (3003, 001, 1003, 400, 70, 470, '2020-10-10');

INSERT INTO Parts (ID, partID, quantity, cost) VALUES (3001, '45125A', 2, 80);
INSERT INTO Parts (ID, partID, quantity, cost) VALUES (3001, '184125A', 3, 80.00);
INSERT INTO Parts (ID, partID, quantity, cost) VALUES (3001, '175999B', 1, 80.00);
INSERT INTO Parts (ID, partID, quantity, cost) VALUES (3002, '789000B', 10, 4.5);
INSERT INTO Parts (ID, partID, quantity, cost) VALUES (3002, '123456A', 2, 100);
INSERT INTO Parts (ID, partID, quantity, cost) VALUES (3003, '45125C', 1, 400);

INSERT INTO WorkOrders (workNo, cusNo, empNo, subTotal, taxTotal, total, date) VALUES (2001, 001, 1000, 160.00, 28.00, 188.00, '2020-10-01');
INSERT INTO WorkOrders (workNo, cusNo, empNo, subTotal, taxTotal, total, date) VALUES (2002, 002, 1001, 245, 42.88, 287.88, '2020-10-05');
INSERT INTO WorkOrders (workNo, cusNo, empNo, subTotal, taxTotal, total, date) VALUES (2003, 003, 1003, 400, 70, 470, '2020-10-10');

INSERT INTO Parts (ID, partID, quantity, cost) VALUES (2001, '45125A', 2, 80);
INSERT INTO Parts (ID, partID, quantity, cost) VALUES (2001, '184125A', 3, 80.00);
INSERT INTO Parts (ID, partID, quantity, cost) VALUES (2001, '175999B', 1, 80.00);
INSERT INTO Parts (ID, partID, quantity, cost) VALUES (2002, '789000B', 10, 4.5);
INSERT INTO Parts (ID, partID, quantity, cost) VALUES (2002, '123456A', 2, 100);
INSERT INTO Parts (ID, partID, quantity, cost) VALUES (2003, '45125C', 1, 400);

INSERT INTO Quotes (quoteNo, cusNo, empNo, subTotal, taxTotal, total, date) VALUES (1001, 001, 1000, 160.00, 28.00, 188.00, '2020-10-01');
INSERT INTO Quotes (quoteNo, cusNo, empNo, subTotal, taxTotal, total, date) VALUES (1002, 002, 1001, 245, 42.88, 287.88, '2020-10-05');
INSERT INTO Quotes (quoteNo, cusNo, empNo, subTotal, taxTotal, total, date) VALUES (1003, 003, 1003, 400, 70, 470, '2020-10-10');

INSERT INTO Parts (ID, partID, quantity, cost) VALUES (1001, '45125A', 2, 80);
INSERT INTO Parts (ID, partID, quantity, cost) VALUES (1001, '184125A', 3, 80.00);
INSERT INTO Parts (ID, partID, quantity, cost) VALUES (1001, '175999B', 1, 80.00);
INSERT INTO Parts (ID, partID, quantity, cost) VALUES (1002, '789000B', 10, 4.5);
INSERT INTO Parts (ID, partID, quantity, cost) VALUES (1002, '123456A', 2, 100);
INSERT INTO Parts (ID, partID, quantity, cost) VALUES (1003, '45125C', 1, 400);

INSERT INTO AccountReceivable (accountNo, amount, dateDue) VALUES (001, 12000.23, '2020-10-05');
INSERT INTO AccountReceivable (accountNo, amount, dateDue) VALUES (002, 10000.00, '2020-10-05');
INSERT INTO AccountReceivable (accountNo, amount, dateDue) VALUES (003, 5000.00, '2020-10-05');

INSERT INTO Bills (accountNo, amount, payDate) VALUES (001, 1200.23, '2020-10-05'); 
INSERT INTO Bills (accountNo, amount, payDate) VALUES (001, 1200.23, '2020-10-05'); 
