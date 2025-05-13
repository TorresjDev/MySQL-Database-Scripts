-- ===============================
-- * Investment Asset - Insert Statement
-- ===============================
INSERT INTO
   Investment_Asset (
      Holdings_ID,
      Account_ID,
      Action_Type,
      Quantity,
      Price_Per_Share,
      Dividend_Amount,
      Reinvestment_Flag,
      Fee_Type,
      Fee_Amount,
      Inv_Timestamp,
      Optional_Note
   )
VALUES
   (
      1,
      3,
      'Purchase',
      10,
      150.00,
      0.00,
      FALSE,
      'Brokerage Fee',
      5.00,
      '2023-05-25 10:00:00',
      'Initial purchase of Apple shares'
   ),
   (
      2,
      3,
      'Purchase',
      5,
      700.00,
      0.00,
      FALSE,
      'Brokerage Fee',
      10.00,
      '2023-09-15 14:30:00',
      'Initial purchase of Tesla shares'
   ),
   (
      3,
      9,
      'Dividend',
      0,
      0.00,
      50.00,
      TRUE,
      'Reinvestment Fee',
      0.00,
      '2023-10-01 12:00:00',
      'Dividend reinvestment for SPY ETF'
   ),
   (
      4,
      12,
      'Purchase',
      2,
      250.00,
      0.00,
      FALSE,
      'Brokerage Fee',
      5.00,
      '2023-07-15 11:30:00',
      'Initial purchase of VOO ETF'
   ),
   (
      5,
      12,
      'Purchase',
      1,
      3000.00,
      0.00,
      FALSE,
      'Brokerage Fee',
      20.00,
      '2023-08-01 09:45:00',
      'Initial purchase of VFIAX Mutual Fund'
   );

-- ===============================