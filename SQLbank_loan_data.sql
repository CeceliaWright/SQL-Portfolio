/*
Bank Loan Data Exploration 
Skills used: Aggregate Functions, Date Functions, Sorting
*/

--------------------------------------------------------------------------------------------------------------------------
/*DASHBOARD 1: SUMMARY*/
--------------------------------------------------------------------------------------------------------------------------

USE[Bank Loan DB] 
/*Looking at Total Loan Applications*/
SELECT * FROM bank_loan_data

SELECT COUNT(id) AS Total_Loan_Applications FROM bank_loan_data

--------------------------------------------------------------------------------------------------------------------------


/*Looking at MTD Loan Applications*/

SELECT COUNT(id) AS MTD_Total_Loan_Applications FROM bank_loan_data
	WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

--------------------------------------------------------------------------------------------------------------------------


/*Looking at PMTD Loan Applications*/

SELECT COUNT(id) AS PMTD_Total_Loan_Applications FROM bank_loan_data
	WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

--------------------------------------------------------------------------------------------------------------------------


/*Looking at Total Funded Amount*/

SELECT SUM(loan_amount) AS Total_Funded_Amount FROM bank_loan_data

--------------------------------------------------------------------------------------------------------------------------


/*Looking at MTD Total Funded Amount*/
SELECT SUM(loan_amount) AS MTD_Total_Funded_Amount FROM bank_loan_data
	WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) =2021

--------------------------------------------------------------------------------------------------------------------------


/*Looking at PMTD Total Funded Amount*/

SELECT SUM(loan_amount) AS MTD_Total_Funded_Amount FROM bank_loan_data
	WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) =2021

--------------------------------------------------------------------------------------------------------------------------


/*Looking at Total Amount Recieved*/

SELECT SUM(total_payment) AS Total_Amount_Recieved FROM bank_loan_data

--------------------------------------------------------------------------------------------------------------------------


/*Looking at MTD Total Amount Recieved*/


SELECT SUM(total_payment) AS Total_Amount_recieved FROM bank_loan_data
	WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021

--------------------------------------------------------------------------------------------------------------------------


/*Looking at PMTD Total Amount Recieved*/


SELECT SUM(total_payment) AS Total_Amount_recieved FROM bank_loan_data
	WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

--------------------------------------------------------------------------------------------------------------------------


/*Looking at Average Interest Rate*/

SELECT AVG(int_rate)*100 AS Avg_Int_Rate FROM bank_loan_data

--------------------------------------------------------------------------------------------------------------------------


/*Looking at MTD Average Interest Rate*/

SELECT AVG(int_rate)*100 AS MTD_Avg_Int_Rate FROM bank_loan_data
WHERE MONTH(issue_date) = 12

--------------------------------------------------------------------------------------------------------------------------


/*Looking at PMTD Average Interest Rate*/

SELECT ROUND(AVG(int_rate), 4) * 100 AS PMTD_Avg_Interest_rate FROM bank_loan_data
	WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

--------------------------------------------------------------------------------------------------------------------------


/*Looking at Average Debt to Income Ratio*/

SELECT AVG(dti)*100 AS Avg_DTI FROM bank_loan_data

--------------------------------------------------------------------------------------------------------------------------


/*Looking at MTD Average Debt to Income Ratio*/

SELECT AVG(dti)*100 AS MTD_Avg_DTI FROM bank_loan_data
WHERE MONTH(issue_date) = 12

--------------------------------------------------------------------------------------------------------------------------


/*Looking at PMTD Average Debt to Income Ratio*/

SELECT ROUND(AVG(dti), 4) * 100 AS Avg_DTI FROM bank_loan_data
	WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021

--------------------------------------------------------------------------------------------------------------------------


/*Looking at Good Loan Percentage*/

SELECT
    (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100.0) 
	/ 
	COUNT(id) AS Good_Loan_Percentage
FROM bank_loan_data

--------------------------------------------------------------------------------------------------------------------------


/*Looking at Total Good Loan Applications*/

SELECT COUNT(id)AS Good_Loan_Applications FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

--------------------------------------------------------------------------------------------------------------------------


/*Looking at Good Loan Funded Amount*/

SELECT SUM(loan_amount)AS Good_Loan_Funded_Amount FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

--------------------------------------------------------------------------------------------------------------------------


/*Looking at Good Loan Amount Recieved*/

SELECT SUM(total_payment)AS Good_Loan_Recieved_Amount FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current'

--------------------------------------------------------------------------------------------------------------------------


/*Looking at Bad Loan Percentage*/

SELECT
    CAST(ROUND((COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) / 
	COUNT(id), 4) AS DECIMAL(18,4)) ASBad_Loan_Percentage
FROM bank_loan_data

--------------------------------------------------------------------------------------------------------------------------


/*Looking at Total Bad Loan Applications*/
SELECT COUNT(id) AS Bad_Loan_Applications FROM bank_loan_data
WHERE loan_status = 'Charged Off'

--------------------------------------------------------------------------------------------------------------------------


/*Looking at Bad Loan Funded Amount*/

SELECT SUM(loan_amount) AS Bad_Loan_Funded_Amount FROM bank_loan_data
WHERE loan_status = 'Charged Off'

--------------------------------------------------------------------------------------------------------------------------


/*Looking at Bad Loan Amount Recieved*/

SELECT SUM(total_payment) AS Bad_Loan_Amount_Recieved FROM bank_loan_data
WHERE loan_status = 'Charged Off'

--------------------------------------------------------------------------------------------------------------------------


/*Loan Status Table*/

SELECT
        loan_status,
        COUNT(id) AS Total_Loan_Applications,
        SUM(total_payment) AS Total_Amount_Received,
        SUM(loan_amount) AS Total_Funded_Amount,
        AVG(int_rate * 100) AS Interest_Rate,
        AVG(dti * 100) AS DTI
    FROM
        bank_loan_data
    GROUP BY
        loan_status

--------------------------------------------------------------------------------------------------------------------------


/* MTD Loan Status Table*/
SELECT 
	loan_status, 
	SUM(total_payment) AS MTD_Total_Amount_Received, 
	SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM bank_loan_data
WHERE MONTH(issue_date) = 12 
GROUP BY loan_status

--------------------------------------------------------------------------------------------------------------------------
/* DASHBOARD 2: OVERVIEW */
--------------------------------------------------------------------------------------------------------------------------


/* Overview Table by Month*/
SELECT 
	MONTH(issue_date) AS Month_Number,
	DATENAME(MONTH, issue_date) AS Month_Name,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Recieved_Amount
FROM bank_loan_data
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date)

--------------------------------------------------------------------------------------------------------------------------


/* Overview Table by State*/

SELECT 
	address_state,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Recieved_Amount
FROM bank_loan_data
GROUP BY address_state
ORDER BY COUNT(id)DESC

--------------------------------------------------------------------------------------------------------------------------


/* Overview Table by Term Length*/

SELECT 
	term,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Recieved_Amount
FROM bank_loan_data
GROUP BY term
ORDER BY term

--------------------------------------------------------------------------------------------------------------------------


/* Overview Table by Employee Length*/

SELECT 
	emp_length,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Recieved_Amount
FROM bank_loan_data
GROUP BY emp_length
ORDER BY COUNT(id) DESC

--------------------------------------------------------------------------------------------------------------------------


/* Overview Table by Loan Purpose*/

SELECT 
	purpose,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Recieved_Amount
FROM bank_loan_data
GROUP BY purpose
ORDER BY COUNT(id) DESC
--------------------------------------------------------------------------------------------------------------------------


/* Overview Table by Home Ownership*/

USE[Bank Loan DB] 
SELECT 
	home_ownership,
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Recieved_Amount
FROM bank_loan_data
WHERE grade = 'A' AND address_state = 'CA'
GROUP BY home_ownership
ORDER BY COUNT(id) DESC