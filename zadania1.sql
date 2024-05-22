-- Write a query to get Product name and quantity/unit.
SELECT ProductName, QuantityPerUnit FROM Products
-- Write a query to get current Product list (Product ID and name).
SELECT ProductID, ProductName FROM Products WHERE Discontinued='False'
-- Write a query to get discontinued Product list (Product ID and name).
SELECT ProductID, ProductName, Discontinued FROM Products WHERE Discontinued='True'
-- Write a query to get most expense and least expensive Product list (name and unit price).
SELECT ProductName, UnitPrice FROM Products ORDER BY UnitPrice desc
SELECT * FROM Products
-- Write a query to get Product list (id, name, unit price) where current products cost less than $20. 
SELECT ProductID, ProductName, UnitPrice FROM Products WHERE Discontinued='False' and UnitPrice<20
-- Write a query to get Product list (id, name, unit price) where products cost between $15 and $25. 
SELECT ProductID, ProductName, UnitPrice FROM Products WHERE UnitPrice>15 and UnitPrice<25
-- Write a query to get Product list (name, unit price) of above average price.
SELECT ProductName, UnitPrice FROM Products WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM Products)
-- Write a query to get Product list (name, unit price) of ten most expensive products.
SELECT Top 10 ProductName, UnitPrice FROM Products ORDER BY UnitPrice desc


































