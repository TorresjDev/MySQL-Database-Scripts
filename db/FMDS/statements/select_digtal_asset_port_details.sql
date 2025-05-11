-- ===============================
-- * Select Digital Asset Portfolio Details
-- ===============================
SELECT
   u.User_ID,
   u.Full_Name,
   daa.Account_ID,
   fa.Account_Name,
   daa.Digital_Account_Type,
   daa.Wallet_Address,
   CONCAT ('$', FORMAT (daa.Total_Digital_Assets_Value, 2)) AS Total_Assets_Value,
   CONCAT ('$', FORMAT (daa.Total_User_Contribution, 2)) AS Total_Contributed,
   CONCAT ('$', FORMAT (daa.Total_Dividends_Earned, 2)) AS Dividends_Earned,
   CONCAT ('$', FORMAT (daa.Total_Interest_Earned, 2)) AS Interest_Earned,
   IFNULL (
      (
         SELECT
            CONCAT ('$', FORMAT (SUM(dh.Holdings_Value), 2))
         FROM
            Digital_Asset_Holding dh
         WHERE
            dh.Account_ID = daa.Account_ID
      ),
      '$0.00'
   ) AS Total_Holdings_Value,
   IFNULL (
      (
         SELECT
            GROUP_CONCAT (CONCAT (dh.Digital_Asset_Symbol, ': $', FORMAT (dh.Holdings_Value, 2)) SEPARATOR ', ')
         FROM
            Digital_Asset_Holding dh
         WHERE
            dh.Account_ID = daa.Account_ID
      ),
      'No Holdings'
   ) AS Holdings_Overview,
   IFNULL (
      (
         SELECT
            GROUP_CONCAT (CONCAT (da.Action_Type, ': $', FORMAT (da.Quantity * da.Price_Per_Token, 2)) SEPARATOR ', ')
         FROM
            Digital_Asset da
         WHERE
            da.Account_ID = daa.Account_ID
      ),
      'No Transactions'
   ) AS Asset_Transactions,
   IFNULL (
      (
         SELECT
            GROUP_CONCAT (CONCAT (dh.Digital_Asset_Symbol, ': $', FORMAT (dh.Unrealized_Gain_Or_Loss, 2)) SEPARATOR ', ')
         FROM
            Digital_Asset_Holding dh
         WHERE
            dh.Account_ID = daa.Account_ID
      ),
      'No Unrealized Gains/Losses'
   ) AS Unrealized_Gains_Losses,
   DATE_FORMAT (daa.Updated_At, '%b %d, %Y @%h:%i%p') AS Last_Updated
FROM
   User u
   JOIN Financial_Account fa ON u.User_ID = fa.User_ID
   JOIN Digital_Asset_Account daa ON fa.Account_ID = daa.Account_ID
ORDER BY
   daa.Total_Digital_Assets_Value DESC;
-- ===============================