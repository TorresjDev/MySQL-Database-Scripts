-- ===============================
-- * Select Users Digital Asset Holdings Summary
-- ===============================
SELECT
    u.User_ID,
    u.Full_Name,
    dah.Digital_Asset_Type,
    dah.Digital_Asset_Symbol,
    COUNT(dah.Holding_ID) AS Total_Holdings,
    ROUND(SUM(dah.Total_Quantity), 0) AS Total_Shares_Held,
    SUM(dah.Holdings_Value) AS Total_Holdings_Value,
    SUM(dah.Realized_Gain_Or_Loss) AS Realized_Gains,
    SUM(dah.Unrealized_Gain_Or_Loss) AS Unrealized_Gains
FROM
    Digital_Asset_Holding dah
    JOIN Digital_Asset_Account daa ON dah.Account_ID = daa.Account_ID
    JOIN Financial_Account fa ON daa.Account_ID = fa.Account_ID
    JOIN User u ON fa.User_ID = u.User_ID
GROUP BY
    u.User_ID,
    dah.Digital_Asset_Type,
    dah.Digital_Asset_Symbol
ORDER BY u.Full_Name, dah.Digital_Asset_Type;
-- ===============================