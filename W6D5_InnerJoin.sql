-- prdotti con categoria e subcategoria
SELECT 
p.EnglishProductName
, s.EnglishProductSubcategoryName
, c.EnglishProductCategoryName
FROM dimproduct p
INNER JOIN dimproductsubcategory s
ON p.ProductSubcategoryKey = s.ProductSubcategoryKey
INNER JOIN dimproductcategory c
ON s.ProductCategoryKey = c.ProductCategoryKey;

-- Prodotti Venduti
SELECT 
p.ProductKey
, p.EnglishProductName
, f.SalesAmount
FROM dimproduct p
INNER JOIN factresellersales f
ON f.ProductKey = p.ProductKey;

-- Prodotti Non Venduti
SELECT 
p.ProductKey Prodotto
, p.EnglishProductName 
, f.ProductKey Vendita
, p.FinishedGoodsFlag ProdottoFinito
FROM dimproduct p
LEFT OUTER JOIN factresellersales f
ON f.ProductKey = p.ProductKey
WHERE f.ProductKey is null AND p.FinishedGoodsFlag = 1;

-- Lista nome prodotto per vendita 
SELECT  
f.ProductKey
, p.EnglishProductName 
FROM factresellersales f
LEFT OUTER JOIN dimproduct p
ON f.ProductKey = p.ProductKey;

-- Categoria per ciascun prodotto venduto
SELECT  
f.ProductKey
, p.EnglishProductName 
, k.ProductCategoryKey
FROM factresellersales f
LEFT OUTER JOIN dimproduct p
ON f.ProductKey = p.ProductKey
INNER JOIN dimproductsubcategory s
ON s.ProductSubcategoryKey = p.ProductSubcategoryKey
INNER JOIN dimproductcategory k
ON k.ProductCategoryKey = s.ProductCategoryKey;

-- Esplora dimreseller, nome reseller e area geografica
SELECT 
d.ResellerName
, d. BusinessType
, g.EnglishCountryRegionName
, g.StateProvinceName
FROM dimreseller d
INNER JOIN dimgeography g
ON g.GeographyKey = d.GeographyKey;


SELECT 
f.SalesOrderNumber
, f.SalesOrderLineNumber
, f.OrderDate 
, f.UnitPrice
, f.OrderQuantity
, f.TotalProductCost
, p.EnglishProductName NomeProdotto
, k.EnglishProductCategoryName Categoria 
, r.ResellerName
, g.EnglishCountryRegionName
, g.StateProvinceName
, g.City
FROM factresellersales f 
INNER JOIN dimproduct p
ON f.ProductKey = p.ProductKey -- nome prodotto
INNER JOIN dimproductsubcategory s
ON s.ProductSubcategoryKey = p.ProductSubcategoryKey
INNER JOIN dimproductcategory k
ON k.ProductCategoryKey = s.ProductCategoryKey -- categoria prodotto
INNER JOIN dimreseller r
ON r.ResellerKey = f.ResellerKey -- RESELLER
INNER JOIN dimgeography g
ON g.GeographyKey = r.GeographyKey;

