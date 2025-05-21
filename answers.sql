-- Question 1
SELECT 
  OrderID,
  CustomerName,
  TRIM(product) AS Product
FROM (
  SELECT 
    OrderID,
    CustomerName,
    jt.product
  FROM ProductDetail,
  JSON_TABLE(
    CONCAT('["', REPLACE(Products, ', ', '","'), '"]'),
    '$[*]' COLUMNS (product VARCHAR(100) PATH '$')
  ) AS jt
) AS normalized;


-- Question 2
-- Create Orders table (removes partial dependency)
CREATE TABLE Orders AS
SELECT DISTINCT
  OrderID,
  CustomerName
FROM OrderDetails;

-- Create OrderItems table (only fully dependent columns remain)
CREATE TABLE OrderItems AS
SELECT
  OrderID,
  Product,
  Quantity
FROM OrderDetails;
