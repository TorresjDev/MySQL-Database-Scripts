-- ===============================
-- * Select Investment Portfolio Details
-- ===============================
SELECT
   u.User_ID,
   u.Full_Name,
   ia.Account_ID,
   fa.Account_Name,
   fa.Institution_Name,
   CONCAT ('$', FORMAT (ia.Total_Investment_Value, 2)) AS Total_Investment_Value,
   CONCAT ('$', FORMAT (ia.Total_User_Contribution, 2)) AS Total_Contributed,
   CONCAT ('$', FORMAT (ia.Total_Dividends_Earned, 2)) AS Dividends_Earned,
   CONCAT ('$', FORMAT (ia.Total_Interest_Earned, 2)) AS Interest_Earned,
   CONCAT ('$', FORMAT (ia.Cash_Balance, 2)) AS Cash_On_Hand,
   CONCAT ('$', FORMAT (ia.Buying_Power, 2)) AS Buying_Power,
   IFNULL (
      (
         SELECT
            CONCAT ('$', FORMAT (SUM(ih.Holdings_Value), 2))
         FROM
            Investment_Holding ih
         WHERE
            ih.Account_ID = ia.Account_ID
      ),
      '$0.00'
   ) AS Total_Holdings_Value,
   IFNULL (
      (
         SELECT
            GROUP_CONCAT (CONCAT (ih.Investment_Symbol, ': $', FORMAT (ih.Holdings_Value, 2)) SEPARATOR ', ')
         FROM
            Investment_Holding ih
         WHERE
            ih.Account_ID = ia.Account_ID
      ),
      'No Holdings'
   ) AS Holdings_Overview,
   IFNULL (
      (
         SELECT
            GROUP_CONCAT (CONCAT (iaa.Action_Type, ': $', FORMAT (iaa.Quantity * iaa.Price_Per_Share, 2)) SEPARATOR ', ')
         FROM
            Investment_Asset iaa
         WHERE
            iaa.Account_ID = ia.Account_ID
      ),
      'No Transactions'
   ) AS Recent_Transactions,
   IFNULL (
      (
         SELECT
            GROUP_CONCAT (CONCAT (ih.Investment_Symbol, ': $', FORMAT (ih.Unrealized_Gain_Or_Loss, 2)) SEPARATOR ', ')
         FROM
            Investment_Holding ih
         WHERE
            ih.Account_ID = ia.Account_ID
      ),
      'No Unrealized Gains/Losses'
   ) AS Unrealized_Gains_Losses,
   DATE_FORMAT (ia.Updated_At, '%b %d, %Y @%h:%i%p') AS Last_Updated
FROM
   User u
   JOIN Financial_Account fa ON u.User_ID = fa.User_ID
   JOIN Investment_Account ia ON fa.Account_ID = ia.Account_ID
ORDER BY
   ia.Total_Investment_Value DESC;
-- ===============================