create database SPAIDW2A0206
GO

Use [SPAIDW2A0206]

CREATE TABLE ModelDim (
    ModelKey VARCHAR PRIMARY KEY,
    ModelID VARCHAR,
    ModelCode VARCHAR,
    TrainingDate DATE,
    Accuracy FLOAT,
    DatasetID VARCHAR
);

CREATE TABLE ModelTypeDim (
    ModelCode VARCHAR PRIMARY KEY,
    ModelType VARCHAR
);

CREATE TABLE DatasetDim (
    DatasetKey VARCHAR PRIMARY KEY,
    DatasetID VARCHAR,
    DatasetName VARCHAR
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
    CustomerKey VARCHAR PRIMARY KEY,
    CustomerID VARCHAR,
    FirstName VARCHAR,
    LastName VARCHAR,
    CompanyName VARCHAR,
    Contact VARCHAR
);

CREATE TABLE EmployeeDim (
    EmployeeKey VARCHAR PRIMARY KEY,
    EmployeeID VARCHAR,
    FirstName VARCHAR,
    LastName VARCHAR,
    Contact VARCHAR,
    Gender VARCHAR
);

CREATE TABLE OrderDim (
    OrderKey VARCHAR PRIMARY KEY,
    OrderID VARCHAR,
    OrderDate DATE,
    CompletionDate DATE
);

CREATE TABLE Fact (
    ModelKey VARCHAR,
    OrderKey VARCHAR,
    CustomerKey VARCHAR,
    EmployeeKey VARCHAR,
    TimeKey INT,
    DatasetKey VARCHAR,
    Price FLOAT,
    FOREIGN KEY (ModelKey) REFERENCES ModelDim(ModelKey),
    FOREIGN KEY (OrderKey) REFERENCES OrderDim(OrderKey),
    FOREIGN KEY (CustomerKey) REFERENCES CustomerDim(CustomerKey),
    FOREIGN KEY (EmployeeKey) REFERENCES EmployeeDim(EmployeeKey),
    FOREIGN KEY (TimeKey) REFERENCES TimeDim(TimeKey),
    FOREIGN KEY (DatasetKey) REFERENCES DatasetDim(DatasetKey)
);

ALTER TABLE ModelDim
ADD CONSTRAINT FK_ModelCode FOREIGN KEY (ModelCode) REFERENCES ModelTypeDim(ModelCode);