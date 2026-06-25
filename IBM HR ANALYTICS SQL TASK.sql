USE [HR Analytics project];
go
--1. COMPUTE ATTRITION RATE DEPARTMENT AND JOBROLE USING GROUP BY + CONDITIONAL COUNT
Select Department, 
JobRole,
COUNT (*) as TotalEmployees,
sum(Case when Attrition = 'Yes' then 1 else 0 end) as EmployeesWhoLeft,
CAST(sum(Case when Attrition = 'Yes' then 1 else 0 end) * 100.0 / count (*) AS decimal(10,2)) as AttritionRate
FROM HR_employee_attrition
Group by Department, JobRole
order by Department, JobRole;

---2. COMPARE AVERAGE MONTHY INCOME OF EMPLOYEES WHO LEFT VS THOSE WHO STAYED USING SUBQUERIES
SELECT
CAST(( SELECT AVG(MonthlyIncome) From HR_employee_attrition where Attrition = 'Yes') as decimal(10,2)) AS AvgIncomeLeft,
CAST(( SELECT AVG(MonthlyIncome) From HR_employee_attrition where Attrition = 'No') as decimal(10,2)) AS AvgIncomeStayed;

--3. RANK JOB ROLES BY AVG YEARSATCOMPANY TO UNDERSTAND TENURE PATTERNS PER ROLE
SELECT 
JobRole,
CAST(AVG(YearsAtCompany) as decimal(10,2)) as AvgYearsAtCompany
FROM HR_employee_attrition
GROUP BY JobRole
ORDER BY AvgYearsAtCompany DESC;
