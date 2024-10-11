-- Restore ancora non visto a lezione	
	SELECT 
    ProductKey,
    ProductAlternateKey,
    EnglishProductName,
    Color,
    StandardCost,
    FinishedGoodsFlag AS FinishedGood
FROM
    dimproduct;
    
SELECT 
    ProductKey,
    ProductAlternateKey,
    EnglishProductName,
    Color,
    StandardCost,
    FinishedGoodsFlag AS FinishedGood
FROM
    dimproduct
WHERE
    FinishedGoodsFlag = 1;
    
SELECT 
    ProductKey,
    ProductAlternateKey,
    EnglishProductName,
    StandardCost,
    ListPrice
FROM
    dimproduct
WHERE
    ProductAlternateKey LIKE 'FR%'
        OR ProductAlternateKey LIKE 'BK%';-- Usa like solo con OR, si usa per caratteri speciali %(Sequeza di 0 o più caratteri) o _ (carattere specifico)
    
	SELECT 
    ProductKey,
    ProductAlternateKey,
    EnglishProductName,
    StandardCost,
    ListPrice,
    ListPrice - StandardCost AS Markup
FROM
    dimproduct
WHERE
    LEFT(ProductAlternateKey, 2) IN ('FR' , 'BK');

	SELECT 
    ProductKey,
    ProductAlternateKey,
    EnglishProductName,
    StandardCost,
    ListPrice,
    ListPrice - StandardCost AS Markup,
    FinishedGoodsFlag AS Fin
FROM
    dimproduct
WHERE
    FinishedGoodsFlag = 1
        AND ListPrice BETWEEN 1000 AND 2000;

SELECT 
    *
FROM
    dimemployee;

SELECT 
    EmployeeKey,
    FirstName,
    MiddleName,
    LastName,
    Title,
    EmailAddress,
    Phone,
    SalespersonFlag AS InSales
FROM
    dimemployee
WHERE
    SalesPersonFlag = 1;

SELECT 
    *
FROM
    factresellersales;

SELECT 
    OrderDate,
    ProductKey,
    UnitPrice,
    TotalProductCost,
    SalesAmount,
    SalesAmount - TotalProductCost AS Profitto
FROM
    factresellersales
WHERE
    OrderDate > '2020-01-01'
        AND ProductKey IN (597 , 598, 477, 214)
    