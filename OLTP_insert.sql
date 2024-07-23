/* 
Class: 2A/02
Group: 6
SQL Purpose: Create Data warehouse dimension and fact tables
*/

create database SPAI2A0206;

use SPAI2A0206;
go

create table Customer (
CustomerID varchar(10) primary key,
FirstName varchar(20) not null,
LastName varchar(20) not null,
CompanyName varchar(50) not null,
Contact varchar(10)
);

create table Employee (
EmployeeID varchar(10) primary key,
FirstName varchar(20) not null,
LastName varchar(20) not null,
Contact varchar(10),
Gender char(1) not null
);

create table Dataset(
DatasetID varchar(10) primary key,
DatasetName varchar(50) not null
);

create table ModelType(
ModelCode varchar(10) primary key,
ModelType varchar(50) not null
);

create table Model(
ModelID varchar(10) primary key,
ModelCode varchar(10) not null,
TrainingDate date not null,
Accuracy decimal(6,2) not null,
DatasetID varchar(10),
foreign key(ModelCode) references ModelType(ModelCode),
foreign key(DatasetID) references Dataset(DatasetID)
);

create table Orders(
OrderID varchar(10) primary key,
OrderDate Date not null,
CompletionDate Date,
RequiredAcc decimal(6,2) not null,
Price int not null,
ModelCode varchar(10) not null,
CustomerID varchar(10) not null,
EmployeeID varchar(10) not null,
ModelID varchar(10),
foreign key (EmployeeID) references Employee(EmployeeID),
foreign key (CustomerID) references Customer(CustomerID),
foreign key (ModelCode) references ModelType(ModelCode),
foreign key (ModelID) references Model(ModelID)
)

-- Bulk Insert Data from CSV into Employee Table
BULK INSERT employee
FROM 'C:\updated_employee.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',
    TABLOCK
);

-- Bulk Insert Data from CSV into Customer Table
BULK INSERT customer
FROM 'C:\updated_customer.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',
    TABLOCK
);

-- Bulk Insert Data from CSV into orders Table
BULK INSERT orders
FROM 'C:\updated_order.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',
    TABLOCK
);

-- Bulk Insert Data from CSV into Model Table
BULK INSERT model
FROM 'C:\updated_model.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',
    TABLOCK
);

-- Bulk Insert Data from CSV into ModelType Table
BULK INSERT modeltype
FROM 'C:\updated_modelType.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',
    TABLOCK
);

-- Bulk Insert Data from CSV into Dataset Table
BULK INSERT dataset
FROM 'C:\updated_dataset.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0A',
    TABLOCK
);

