-- ===============================
-- * Select Users Credit Scores Summary
-- ===============================
SELECT
   u.User_ID,
   u.Full_Name,
   cr.Credit_Bureau_Name,
   cr.Credit_Score,
   CASE
      WHEN cr.Credit_Score >= 740 THEN 'Excellent'
      WHEN cr.Credit_Score >= 670 THEN 'Good'
      WHEN cr.Credit_Score >= 580 THEN 'Fair'
      ELSE 'Poor'
   END AS Score_Grade,
   cr.Report_Date
FROM
   Credit_Report cr
   JOIN User u ON cr.User_ID = u.User_ID
ORDER BY
   u.Full_Name,
   cr.Credit_Bureau_Name;

-- ===============================