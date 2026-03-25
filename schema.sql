CREATE DATABASE pension_project;
USE pension_project;

-- DROP TABLES (optional reset)
DROP TABLE IF EXISTS Remittances;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Employers;

-- CREATE TABLES
CREATE TABLE Employers (
    ID INT PRIMARY KEY,
    Name VARCHAR(100),
    PenCom_Code VARCHAR(20)
);

CREATE TABLE Employees (
    ID INT PRIMARY KEY,
    Employer_ID INT,
    RSA_PIN VARCHAR(20),
    Monthly_Contribution DECIMAL(10,2),
    FOREIGN KEY (Employer_ID) REFERENCES Employers(ID)
);

CREATE TABLE Remittances (
    ID INT PRIMARY KEY,
    Employer_ID INT,
    Amount_Paid DECIMAL(12,2),
    Payment_Date DATE,
    FOREIGN KEY (Employer_ID) REFERENCES Employers(ID)
);

-- INSERT EMPLOYERS
INSERT INTO Employers VALUES
(1, 'Zenith Bank', 'PC001'),
(2, 'Dangote Group', 'PC002'),
(3, 'MTN Nigeria', 'PC003'),
(4, 'Access Holdings', 'PC004');

-- INSERT EMPLOYEES
INSERT INTO Employees VALUES
(1, 1, 'RSA001', 50000),
(2, 1, 'RSA002', 60000),

(3, 2, 'RSA003', 70000),
(4, 2, 'RSA004', 80000),

(5, 3, 'RSA005', 40000),
(6, 3, 'RSA006', 45000),

(7, 4, 'RSA007', 55000),
(8, 4, 'RSA008', 65000);

-- INSERT REMITTANCES
INSERT INTO Remittances VALUES
(1, 1, 120000, '2026-01-31'),  -- Correct
(2, 2, 100000, '2026-01-31'),  -- Underpaid
(3, 3, 90000,  '2026-01-31'),  -- Correct
(4, 4, 150000, '2026-01-31');  -- Overpaid