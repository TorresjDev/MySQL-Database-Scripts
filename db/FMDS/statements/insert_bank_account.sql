-- ===============================
-- * Bank Account - Insert Statement
-- ===============================
INSERT INTO
    Bank_Account (
        Account_ID,
        Routing_Number,
        APY
    )
VALUES (1, '123456789', 0.05),
       (2, '987654321', 0.03),
       (12, '456789123', 0.04),
       (14, '173456789', 0.05),
       (15, '827654321', 0.03);

SELECT * FROM Bank_Account;
-- ===============================