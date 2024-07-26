/* 
Class: 2A/02
Group: 6
SQL Purpose: Inserting data from OLTP tables to Data warehouse dimension and fact tables
*/

Use [SPAIDW2A0206]


------------ ModelTypeDim --------------
INSERT INTO SPAIDW2A0206..ModelTypeDim(ModelCode, ModelType)
SELECT 
    ModelCode, 
    ModelType 
FROM 
    SPAI2A0206..ModelType;

------------ ModelDim --------------
INSERT INTO SPAIDW2A0206..ModelDim(ModelID, ModelCode, TrainingDate, Accuracy, DatasetID)
SELECT 
    ModelID, 
    ModelCode, 
    TrainingDate, 
    Accuracy, 
    DatasetID 
FROM SPAI2A0206..Model

------------ DatasetDim --------------
INSERT INTO SPAIDW2A0206..DatasetDim(DatasetID, DatasetName)
SELECT 
    DatasetID, 
    DatasetName 
FROM 
    SPAI2A0206..Dataset;

------------ CustomerDim --------------
INSERT INTO SPAIDW2A0206..CustomerDim(CustomerID, FirstName, LastName, CompanyName, Contact)
SELECT 
    CustomerID, 
    FirstName, 
    LastName, 
    CompanyName, 
    Contact 
FROM 
    SPAI2A0206..Customer;

------------ EmployeeDim --------------
INSERT INTO SPAIDW2A0206..EmployeeDim(EmployeeID, FirstName, LastName, Contact, Gender)
SELECT 
    EmployeeID, 
    FirstName, 
    LastName, 
    Contact, 
    Gender 
FROM 
    SPAI2A0206..Employee;

------------ OrderDim --------------
INSERT INTO SPAIDW2A0206..OrderDim(OrderID, CompletionDate, RequiredAcc)
SELECT 
    OrderID,
    CompletionDate, 
    RequiredAcc 
FROM 
    SPAI2A0206..Orders;

------------ TimeDim --------------
DECLARE @StartDate DATE = '2021-01-01'; -- Starting order date
DECLARE @EndDate DATE = '2023-12-31'; -- Ending order date
DECLARE @curDate DATE = @StartDate;

WHILE @curDate <= @EndDate
BEGIN
    INSERT INTO SPAIDW2A0206..TimeDim ([Date], DayOfMonth, DayName, DayOfYear, Month, MonthName, Quarter, QuarterName, Year)
    SELECT 
        @curDate, 
        DAY(@curDate), 
        DATENAME(WEEKDAY, @curDate), 
        DATEPART(DAYOFYEAR, @curDate), 
        MONTH(@curDate), 
        DATENAME(MONTH, @curDate), 
        DATEPART(QUARTER, @curDate), 
        CASE 
            WHEN DATEPART(QUARTER, @curDate) = 1 THEN 'First'
            WHEN DATEPART(QUARTER, @curDate) = 2 THEN 'Second'
            WHEN DATEPART(QUARTER, @curDate) = 3 THEN 'Third'
            WHEN DATEPART(QUARTER, @curDate) = 4 THEN 'Fourth'
        END, 
        YEAR(@curDate);
    
    SET @curDate = DATEADD(DAY, 1, @curDate);
END;

------------ Fact --------------
INSERT INTO SPAIDW2A0206..Fact (ModelKey, OrderKey, CustomerKey, EmployeeKey, TimeKey, DatasetKey, Price)
SELECT 
    m.ModelKey, 
    o.OrderKey, 
    c.CustomerKey, 
    e.EmployeeKey, 
    t.TimeKey, 
    d.DatasetKey, 
    ord.Price
FROM 
    SPAI2A0206..Orders ord
JOIN SPAIDW2A0206..ModelDim m ON ord.ModelID = m.ModelID
JOIN SPAIDW2A0206..OrderDim o ON ord.OrderID = o.OrderID
JOIN SPAIDW2A0206..CustomerDim c ON ord.CustomerID = c.CustomerID
JOIN SPAIDW2A0206..EmployeeDim e ON ord.EmployeeID = e.EmployeeID
JOIN SPAIDW2A0206..TimeDim t ON ord.OrderDate = t.[Date]
JOIN SPAIDW2A0206..DatasetDim d ON m.DatasetID = d.DatasetID;