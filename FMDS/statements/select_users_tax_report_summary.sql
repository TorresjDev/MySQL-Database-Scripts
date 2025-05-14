-- ===============================
-- ===============================
SELECT
   u.User_ID,
   u.Full_Name,
   u.SSN,
   u.Date_Of_Birth,
   u.State,
   tr.Tax_Year,
   tr.Filing_Status,
   CASE
      WHEN tr.Filing_Status = 'Married Filing Jointly' THEN tr.Spouse_Income
      ELSE 'N/A'
   END AS Spouse_Income,
   tr.Num_Dependents,
   SUM(tt.Taxable_Amount) AS Total_Taxable_Income,
   GROUP_CONCAT (
      DISTINCT tt.Tax_Category
      ORDER BY
         tt.Tax_Category ASC SEPARATOR ', '
   ) AS Tax_Categories
FROM
   Tax_Report tr
   JOIN User u ON tr.User_ID = u.User_ID
   JOIN Taxable_Transaction tt ON tr.Tax_Report_ID = tt.Tax_Report_ID
GROUP BY
   u.User_ID,
   tr.Tax_Year,
   tr.Filing_Status,
   tr.Spouse_Income,
   tr.Num_Dependents
ORDER BY
   u.Full_Name,
   tr.Tax_Year;
-- ===============================