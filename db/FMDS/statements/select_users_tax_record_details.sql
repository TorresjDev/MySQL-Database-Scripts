-- ===============================
-- * Select Users Tax Record Details
-- ===============================
SELECT
    u.User_ID,
    u.Full_Name,
    CONCAT('****-**-', RIGHT(u.SSN, 4)) AS SSN_Last4,
    u.Email,
    u.Phone_Number,
    tr.Tax_Year,
    tr.Filing_Status,
    IFNULL(
        CONCAT(
            '$',
            FORMAT(tr.Spouse_Income, 2)
        ),
        'N/A'
    ) AS Spouse_Income,
    tr.Num_Dependents,
    tt.Tax_Category,
    CONCAT(
        '$',
        FORMAT(tt.Taxable_Amount, 2)
    ) AS Taxable_Amount,
    DATE_FORMAT(
        tt.Identified_Timestamp,
        '%b %d, %Y @%h:%i%p'
    ) AS Tax_Record_Timestamp,
    LEFT(tt.Notes, 80) AS Notes_Preview,
    (
        SELECT CONCAT(
                '$', FORMAT(SUM(tt2.Taxable_Amount), 2)
            )
        FROM Taxable_Transaction tt2
        WHERE
            tt2.Tax_Report_ID = tr.Tax_Report_ID
    ) AS Total_Taxable_Income
FROM
    User u
    JOIN Tax_Report tr ON u.User_ID = tr.User_ID
    JOIN Taxable_Transaction tt ON tr.Tax_Report_ID = tt.Tax_Report_ID
WHERE
    u.SSN IS NOT NULL
ORDER BY u.Full_Name ASC, tr.Tax_Year DESC, tt.Identified_Timestamp DESC;
-- ===============================