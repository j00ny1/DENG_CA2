/* 
Class: 2A/02
Group: 6
SQL Purpose: Create Data warehouse dimension and fact tables
*/

create database SPAIDW2A0206
GO

Use [SPAIDW2A0206]

CREATE TABLE ModelDim (
    ModelKey INT IDENTITY(1, 1) PRIMARY KEY,
    ModelID VARCHAR(10) NOT NULL,
    ModelCode VARCHAR(10) NOT NULL,
    TrainingDate DATE NOT NULL,
    Accuracy DECIMAL(6,2) NOT NULL,
    DatasetID VARCHAR(10)
);

CREATE TABLE ModelTypeDim (
    ModelCode VARCHAR(10) PRIMARY KEY,
    ModelType VARCHAR(50)
);

CREATE TABLE DatasetDim (
    DatasetKey INT IDENTITY(1, 1) PRIMARY KEY,
    DatasetID VARCHAR(10) NOT NULL,
    DatasetName VARCHAR(50) NOT NULL
);

CREATE TABLE TimeDim (
    [TimeKey] INT IDENTITY(1, 1) PRIMARY KEY,
    [Date] DATETIME,
    [DayOfMonth] INT,
    [DayName] VARCHAR(9),
    [DayOfYear] INT,
    [Month] INT,
    [MonthName] VARCHAR(9),
    [Quarter] INT,
    [QuarterName] VARCHAR(9),
    [Year] CHAR(4)
);

CREATE TABLE CustomerDim (
    CustomerKey INT IDENTITY(1, 1) PRIMARY KEY,
    CustomerID VARCHAR(10) NOT NULL,
    FirstName VARCHAR(20) NOT NULL,
    LastName VARCHAR(20) NOT NULL,
    CompanyName VARCHAR(50) NOT NULL,
    Contact VARCHAR(10)
);

CREATE TABLE EmployeeDim (
    EmployeeKey INT IDENTITY(1, 1) PRIMARY KEY,
    EmployeeID VARCHAR(10) NOT NULL,
    FirstName VARCHAR(20) NOT NULL,
    LastName VARCHAR(20) NOT NULL,
    Contact VARCHAR(10),
    Gender CHAR(1) NOT NULL
);

CREATE TABLE OrderDim (
    OrderKey INT IDENTITY(1, 1) PRIMARY KEY,
    OrderID VARCHAR(10) NOT NULL,
    -- OrderDate DATE NOT NULL,
    CompletionDate DATE,
    RequiredAcc DECIMAL(6,2) NOT NULL
);

CREATE TABLE Fact (
    ModelKey INT NOT NULL,
    OrderKey INT NOT NULL,
    CustomerKey INT NOT NULL,
    EmployeeKey INT NOT NULL,
    TimeKey INT NOT NULL,
    DatasetKey INT NOT NULL,
    Price INT NOT NULL,
    FOREIGN KEY (ModelKey) REFERENCES ModelDim(ModelKey),
    FOREIGN KEY (OrderKey) REFERENCES OrderDim(OrderKey),
    FOREIGN KEY (CustomerKey) REFERENCES CustomerDim(CustomerKey),
    FOREIGN KEY (EmployeeKey) REFERENCES EmployeeDim(EmployeeKey),
    FOREIGN KEY (TimeKey) REFERENCES TimeDim(TimeKey),
    FOREIGN KEY (DatasetKey) REFERENCES DatasetDim(DatasetKey),
    CONSTRAINT FactKey PRIMARY KEY (ModelKey, OrderKey, CustomerKey, EmployeeKey, TimeKey, DatasetKey)
);

ALTER TABLE ModelDim
ADD CONSTRAINT FK_ModelCode FOREIGN KEY (ModelCode) REFERENCES ModelTypeDim(ModelCode);