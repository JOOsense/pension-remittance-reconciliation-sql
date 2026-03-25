-- 1. VIEW DATA
SELECT * FROM Employers;
SELECT * FROM Employees;
SELECT * FROM Remittances;

-- 2. VALIDATION
SELECT Employer_ID, SUM(Monthly_Contribution)
FROM Employees
GROUP BY Employer_ID;


-- 3. FINAL ANALYSIS
-- Underpaid Employers
SELECT 
    e.Name AS Employer_Name,
    SUM(emp.Monthly_Contribution) AS Expected_Total,
    r.Amount_Paid,
    (SUM(emp.Monthly_Contribution) - r.Amount_Paid) AS Shortfall
FROM Employers e
JOIN Employees emp ON e.ID = emp.Employer_ID
JOIN Remittances r ON e.ID = r.Employer_ID
GROUP BY e.ID, e.Name, r.Amount_Paid
HAVING r.Amount_Paid < SUM(emp.Monthly_Contribution);


-- Fully Paid Employers
SELECT 
    e.Name AS Employer_Name,
    SUM(emp.Monthly_Contribution) AS Expected_Total,
    r.Amount_Paid
FROM Employers e
JOIN Employees emp ON e.ID = emp.Employer_ID
JOIN Remittances r ON e.ID = r.Employer_ID
GROUP BY e.ID, e.Name, r.Amount_Paid
HAVING r.Amount_Paid = SUM(emp.Monthly_Contribution);


-- Overpaid Employers
SELECT 
    e.Name AS Employer_Name,
    SUM(emp.Monthly_Contribution) AS Expected_Total,
    r.Amount_Paid,
    (r.Amount_Paid - SUM(emp.Monthly_Contribution)) AS Excess
FROM Employers e
JOIN Employees emp ON e.ID = emp.Employer_ID
JOIN Remittances r ON e.ID = r.Employer_ID
GROUP BY e.ID, e.Name, r.Amount_Paid
HAVING r.Amount_Paid > SUM(emp.Monthly_Contribution);