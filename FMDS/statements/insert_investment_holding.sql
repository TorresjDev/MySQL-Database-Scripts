-- ===============================
-- * Investment Holding - Insert Statement
-- ===============================
INSERT INTO
   Investment_Holding (
      Account_ID,
      Investment_Type,
      Investment_Symbol,
      Investment_Name,
      Total_Quantity,
      Average_Price_Per_Share,
      Current_Price,
      Holdings_Value,
      Unrealized_Gain_Or_Loss,
      Realized_Gain_Or_Loss,
      Date_Opened,
      Holding_Status
   )
VALUES
   (3, 'Stock', 'AAPL', 'Apple Inc.', 50, 150.00, 160.00, 8000.00, 500.00, 0.00, '2023-05-25', 'Active'),
   (
      3,
      'Stock',
      'TSLA',
      'Tesla Inc.',
      30,
      700.00,
      720.00,
      21600.00,
      600.00,
      0.00,
      '2023-09-15',
      'Active'
   ),
   (
      9,
      'ETF',
      'SPY',
      'SPDR S&P 500 ETF Trust',
      100,
      400.00,
      410.00,
      41000.00,
      1000.00,
      0.00,
      '2023-10-01',
      'Active'
   ),
   (
      12,
      'ETF',
      'VOO',
      'Vanguard S&P 500 ETF',
      20,
      250.00,
      260.00,
      5200.00,
      200.00,
      0.00,
      '2023-07-15',
      'Active'
   ),
   (
      12,
      'Mutual Fund',
      'VFIAX',
      'Vanguard 500 Index Fund',
      10,
      3000.00,
      3100.00,
      31000.00,
      1000.00,
      0.00,
      '2023-08-01',
      'Active'
   );

-- ===============================