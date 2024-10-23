-- 1 nome prodotto, il nome della sottocategoria associata e il nome della categoria associata

CREATE VIEW Prodotto as 
Select p.EnglishProductName Prodotto
, c.EnglishProductCategoryName Categoria
, s.EnglishProductSubcategoryName Sottocategoria
FROM dimproduct p
INNER JOIN dimproductsubcategory s
ON p.ProductSubcategoryKey = s.ProductCategoryKey
INNER JOIN dimproductcategory c
ON c.ProductCategoryKey = s.ProductCategoryKey;

-- 2 nome del reseller, il nome della città e il nome della regione
CREATE VIEW Reseller as 
Select r.ResellerName Reseller
, g.EnglishCountryRegionName Regione 
, g.city Città
FROM dimreseller r 
INNER JOIN dimgeography g
ON g.GeographyKey = r.GeographyKey;

-- a data dell’ordine, il codice documento, 
-- la riga di corpo del documento??, la quantità venduta, l’importo totale e il profitto

CREATE VIEW Sales as
SELECT s.Orderdate Data
, s.SalesOrderNumber CodiceDoc
, s.SalesOrderLineNumber CorpoDoc
, s.OrderQuantity Quantità
, s.SalesAmount ImportoTotale 
, CASE 
	WHEN s.TotalProductCost IS NOT NULL THEN s.SalesAmount - s.TotalProductCost
    ELSE s.SalesAmount - p.StandardCost*s.OrderQuantity
    end as Profitto
from factresellersales s
inner join dimproduct p
on p.ProductKey = s.ProductKey



