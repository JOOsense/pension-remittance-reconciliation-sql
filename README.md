# Pension Remittance Reconciliation System (SQL Project)

## 📌 Project Overview

This project simulates a pension remittance reconciliation system used in financial and pension administration platforms.

It focuses on validating whether employers remit the correct total pension contributions based on their employees' monthly obligations.

---

## Objective

To identify discrepancies between:

* Expected pension contributions (from employees)
* Actual payments made by employers

---

## Database Structure

### Employers

| Column      | Description                  |
| ----------- | ---------------------------- |
| ID          | Unique employer identifier   |
| Name        | Employer name                |
| PenCom_Code | Regulatory registration code |

### Employees

| Column               | Description                       |
| -------------------- | --------------------------------- |
| ID                   | Unique employee identifier        |
| Employer_ID          | Links employee to employer        |
| RSA_PIN              | Retirement Savings Account number |
| Monthly_Contribution | Monthly pension contribution      |

### Remittances

| Column       | Description             |
| ------------ | ----------------------- |
| ID           | Payment record ID       |
| Employer_ID  | Employer making payment |
| Amount_Paid  | Total amount remitted   |
| Payment_Date | Date of payment         |

---

## Key SQL Queries

### 1. 🔴 Underpaid Employers

Identifies employers who remitted less than the expected total contributions.

```sql id="k2m91x"
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
```

---

### 2. 🟢 Fully Paid Employers

Identifies employers who remitted the exact expected amount.

```sql id="h7s4qp"
SELECT 
    e.Name AS Employer_Name,
    SUM(emp.Monthly_Contribution) AS Expected_Total,
    r.Amount_Paid
FROM Employers e
JOIN Employees emp ON e.ID = emp.Employer_ID
JOIN Remittances r ON e.ID = r.Employer_ID
GROUP BY e.ID, e.Name, r.Amount_Paid
HAVING r.Amount_Paid = SUM(emp.Monthly_Contribution);
```

---

### 3. 🔵 Overpaid Employers

Identifies employers who remitted more than required.

```sql id="p4x8zn"
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
```

---

## 📊 Key Insights

* Detects underpayment and overpayment scenarios
* Highlights compliance gaps in pension remittance
* Demonstrates reconciliation logic used in financial systems

---

## 🛠 Tools & Technologies

* SQL (MySQL / PostgreSQL / SQLite)

---

## 🚀 How to Run This Project

1. Clone the repository
2. Run the `schema.sql` file to create tables and insert data
3. Run the queries in `queries.sql`
4. Review results in your SQL environment

---

## 📁 Project Structure

* `schema.sql` → Table creation and sample data
* `queries.sql` → Analytical queries
* `README.md` → Project documentation

---

## 💼 Business Relevance

This project reflects real-world data validation processes used in:

* Pension fund administration
* Financial reconciliation systems
* Payroll compliance monitoring

---
