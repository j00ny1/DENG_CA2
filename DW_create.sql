create database SPAIDW2A0206
GO

Use [SPAIDW2A0206]

CREATE TABLE ModelDim (
    ModelKey VARCHAR(10) PRIMARY KEY,
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
    DatasetKey VARCHAR(10) PRIMARY KEY,
    DatasetID VARCHAR(10) NOT NULL,
    DatasetName VARCHAR(50) NOT NULL
);

CREATE TABLE TimeDim (
    [TimeKey] INT PRIMARY KEY,
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
    CustomerKey VARCHAR(10) PRIMARY KEY,
    CustomerID VARCHAR(10) NOT NULL,
    FirstName VARCHAR(20) NOT NULL,
    LastName VARCHAR(20) NOT NULL,
    CompanyName VARCHAR(50) NOT NULL,
    Contact VARCHAR(10)
);

CREATE TABLE EmployeeDim (
    EmployeeKey VARCHAR(10) PRIMARY KEY,
    EmployeeID VARCHAR(10) NOT NULL,
    FirstName VARCHAR(20) NOT NULL,
    LastName VARCHAR(20) NOT NULL,
    Contact VARCHAR(10),
    Gender CHAR(1) NOT NULL
);

CREATE TABLE OrderDim (
    OrderKey VARCHAR(10) PRIMARY KEY,
    OrderID VARCHAR(10) NOT NULL,
    OrderDate DATE NOT NULL,
    CompletionDate DATE,
    RequiredAcc DECIMAL(6,2) NOT NULL
);

CREATE TABLE Fact (
    ModelKey VARCHAR(10) NOT NULL,
    OrderKey VARCHAR(10) NOT NULL,
    CustomerKey VARCHAR(10) NOT NULL,
    EmployeeKey VARCHAR(10) NOT NULL,
    TimeKey INT NOT NULL,
    DatasetKey VARCHAR(10) NOT NULL,
    Price INT NOT NULL,
    FOREIGN KEY (ModelKey) REFERENCES ModelDim(ModelKey),
    FOREIGN KEY (OrderKey) REFERENCES OrderDim(OrderKey),
    FOREIGN KEY (CustomerKey) REFERENCES CustomerDim(CustomerKey),
    FOREIGN KEY (EmployeeKey) REFERENCES EmployeeDim(EmployeeKey),
    FOREIGN KEY (TimeKey) REFERENCES TimeDim(TimeKey),
    FOREIGN KEY (DatasetKey) REFERENCES DatasetDim(DatasetKey)
);

ALTER TABLE ModelDim
ADD CONSTRAINT FK_ModelCode FOREIGN KEY (ModelCode) REFERENCES ModelTypeDim(ModelCode);