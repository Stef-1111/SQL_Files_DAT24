
-- Esercizo 1 - Capire se una determinata Chiave è primaria. 
SELECT 
    ProductKey, COUNT(*) count
FROM
    Dimproduct
GROUP BY ProductKey
HAVING COUNT(*) > 1;


-- Alternativa più Tecnica 
SHOW KEYS
	FROM dimproduct
	WHERE Key_name = 'PRIMARY';
 
SELECT 
    COUNT(ProductKey) TotalCount,
    COUNT(DISTINCT ProductKey) UniqueCount
FROM
    dimproduct;
-- Se sono uguali sono calori univoci;

SELECT DISTINCT ProductKey
FROM dimproduct;


SELECT 
    *
FROM
    factresellersales;

SELECT 
    SalesOrderLineNumber, SalesOrderNumber, COUNT(*)
FROM
    factresellersales
GROUP BY SalesOrderLineNumber , SalesOrderNumber
HAVING COUNT(*) >= 1;

SELECT 
    OrderDate, COUNT(DISTINCT SalesOrderNumber) Vendite
FROM
    factresellersales
GROUP BY OrderDate
HAVING OrderDate >= '2020-01-01'
ORDER BY Vendite DESC;


SELECT 
p.ProductKey CodiceProdotto
, p.EnglishProductName
, SUM(s.SalesAmount) FatturatoTotale
, SUM(s.OrderQuantity) Quantità
, CAST(SUM(s.SalesAmount)/SUM(S.OrderQuantity) AS DECIMAL(10,2)) PrezzoMedio
-- la formula cast ha una formula in output. Hai un datatype diverso e lo scegli tu, dopo la funzione.
FROM factresellersales s
LEFT JOIN dimproduct p -- Puoi usare anche inner, perché è indifferente in questo caso
ON p.ProductKey = s.ProductKey
WHERE OrderDate > '2020-01-01'
GROUP BY p.ProductKey, p.EnglishProductName;


SELECT *
FROM dimproductsubcategory;

SELECT
m.EnglishProductCategoryName Categoria
, COUNT(p.ProductKey) Prodotti
, SUM(s.SalesAmount) SalesAmount
, SUM(s.OrderQuantity) Quantità
, CAST(SUM(s.SalesAmount)/SUM(S.OrderQuantity) AS DECIMAL(10,2)) PrezzoMedio
FROM factresellersales s
INNER JOIN dimproduct p
ON p.ProductKey = s.ProductKey
INNER JOIN dimproductsubcategory sub
ON p.ProductSubcategoryKey = sub.ProductSubcategoryKey
INNER JOIN dimproductcategory m
ON m.ProductCategoryKey = sub.ProductCategoryKey
GROUP BY EnglishProductCategoryName;




    
SELECT 
    g.City Città, SUM(SalesAmount) FATTURATO
FROM
    factresellersales f
        INNER JOIN
    dimreseller t ON t.ResellerKey = f.ResellerKey
        INNER JOIN
    dimgeography g ON g.GeographyKey = t.GeographyKey
WHERE
    f.OrderDate > '2020-01-01'
GROUP BY g.City
HAVING SUM(SalesAmount) > 60000
ORDER BY SUM(SalesAmount) DESC;

SELECT 
    g.City Città, SUM(SalesAmount) FATTURATO
FROM
    factresellersales f
        INNER JOIN
    dimreseller t ON t.ResellerKey = f.ResellerKey
        INNER JOIN
    dimgeography g ON g.GeographyKey = t.GeographyKey
WHERE
    f.OrderDate > '2020-01-01'
GROUP BY g.City
HAVING SUM(SalesAmount) > 60000
order by FATTURATO desc;
