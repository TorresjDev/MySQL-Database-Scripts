-- ===============================
-- * Select Tax Reports with Taxable Transaction Details
-- ===============================
SELECT
    u.Full_Name,
    u.Email,
    u.Phone_Number,
    t.Tax_Year,
    t.Filing_Status,
    IFNULL(
        CONCAT(
            '$',
            FORMAT(t.Spouse_Income, 2)
        ),
        'N/A'
    ) AS Spouse_Income,
    t.Num_Dependents,
    tt.Tax_Category,
    CONCAT(
        '$',
        FORMAT(tt.Taxable_Amount, 2)
    ) AS Taxable_Amount,
    DATE_FORMAT(
        tt.Identified_Timestamp,
        '%b %d, %Y @%h:%i %p'
    ) AS Tax_Identified_On,
    LEFT(tt.Notes, 100) AS Notes_Preview
FROM
    User u
    JOIN Tax_Report t ON u.User_ID = t.User_ID
    JOIN Taxable_Transaction tt ON t.Tax_Report_ID = tt.Tax_Report_ID
ORDER BY u.Full_Name ASC, t.Tax_Year DESC, tt.Identified_Timestamp DESC;
-- ===============================