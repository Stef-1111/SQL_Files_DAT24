-- 1 Identificate tutti i clienti che non hanno effettuato nessun noleggio a gennaio 2006
SELECT 
    c.first_name, c.last_name
FROM
    rental r
        INNER JOIN
    inventory i ON r.inventory_id = i.inventory_id
        INNER JOIN
    film f ON f.film_id = i.film_id
        INNER JOIN
    store s ON s.store_id = i.store_id
        LEFT OUTER JOIN
    customer c ON c.store_id = s.store_id
WHERE
    MONTH(rental_date) = 01 & YEAR(rental_date) = 2005 & rental_date IS NULL;

SELECT 
    c.first_name, c.last_name
FROM
    rental r
        LEFT OUTER JOIN
    inventory i ON r.inventory_id = i.inventory_id
        LEFT OUTER JOIN
    film f ON f.film_id = i.film_id
        LEFT OUTER JOIN
    store s ON s.store_id = i.store_id
        LEFT OUTER JOIN
    customer c ON c.store_id = s.store_id
WHERE
    c.first_name = NULL;

-- 2 Elencate tutti i film che sono stati noleggiati più di 10 volte nell’ultimo quarto del 2005
SELECT 
    titolo, conteggio, data
FROM
    (SELECT 
        COUNT(f.film_id) conteggio,
            f.title titolo,
            QUARTER(r.rental_date) data
    FROM
        rental r
    LEFT OUTER JOIN inventory i ON r.inventory_id = i.inventory_id
    LEFT OUTER JOIN film f ON f.film_id = i.film_id
    GROUP BY f.film_id , QUARTER(r.rental_date)) films
WHERE
    conteggio > 10 AND data < '4'
ORDER BY conteggio

-- 3 Trovate il numero totale di noleggi effettuati il giorno 1/1/2006.

SELECT RENTAL_DATE AS DATA_NOLEGGIO
,COUNT(RENTAL_ID) AS CODICE_NOLEGGIO
FROM RENTAL 
 WHERE RENTAL_DATE = '2006-01-01' 
GROUP BY REntal_date;

-- 4 Calcolate la somma degli incassi generati nei weekend (sabato e domenica)

SELECT 
    F.TITLE AS TitoloFilm,
    COUNT(R.RENTAL_ID) AS NumeroNoleggi,
    R.RENTAL_DATE AS DataNoleggio,
    C.CUSTOMER_ID AS CodiceCliente,
    C.FIRST_NAME AS NomeCliente,
    C.LAST_NAME AS CognomeCliente
FROM 
    RENTAL R
JOIN 
    CUSTOMER C ON R.CUSTOMER_ID = C.CUSTOMER_ID
JOIN 
    INVENTORY I ON R.INVENTORY_ID = I.INVENTORY_ID
JOIN 
    FILM F ON I.FILM_ID = F.FILM_ID
WHERE 
    r.rental_date between '2005-05-28' and '2005-06-03'
GROUP BY 
    F.TITLE, R.RENTAL_DATE, C.CUSTOMER_ID, C.FIRST_NAME, C.LAST_NAME
ORDER BY 
    R.RENTAL_DATE DESC;


-- 5 Individuate il cliente che ha speso di più in noleggi
SELECT 
    CAT.NAME AS CategoriaFilm,
    AVG(DATEDIFF(R.RETURN_DATE, R.RENTAL_DATE)) AS DurataMediaNoleggio
FROM
    RENTAL R
        JOIN
    INVENTORY I ON R.INVENTORY_ID = I.INVENTORY_ID
        JOIN
    FILM F ON I.FILM_ID = F.FILM_ID
        JOIN
    FILM_CATEGORY FC ON F.FILM_ID = FC.FILM_ID
        JOIN
    CATEGORY CAT ON FC.CATEGORY_ID = CAT.CATEGORY_ID
WHERE
    R.RETURN_DATE IS NOT NULL
GROUP BY CAT.NAME
ORDER BY DurataMediaNoleggio DESC
  
    
-- 6 Individuate il cliente che ha speso di più in noleggi


SELECT 
    R.RENTAL_DATE AS DataNoleggio,
    DATEDIFF(R.RETURN_DATE, R.RENTAL_DATE) AS DurataNoleggio
FROM 
    RENTAL R
WHERE 
    R.RETURN_DATE IS NOT NULL  
ORDER BY 
    DurataNoleggio DESC
LIMIT 1;


SELECT 
    F.TITLE AS TitoloFilm,
    -- COUNT(R.RENTAL_ID) AS NumeroNoleggi,
    R.RENTAL_DATE AS DataNoleggio,
    C.CUSTOMER_ID AS CodiceCliente,
    C.FIRST_NAME AS NomeCliente,
    C.LAST_NAME AS CognomeCliente
FROM 
    RENTAL R
JOIN 
    CUSTOMER C ON R.CUSTOMER_ID = C.CUSTOMER_ID
JOIN 
    INVENTORY I ON R.INVENTORY_ID = I.INVENTORY_ID
JOIN 
    FILM F ON I.FILM_ID = F.FILM_ID
WHERE 
DATEDIFF('2005-06-03 23:00:00', R.RENTAL_DATE)<=6
and DATEDIFF('2005-06-03 23:00:00', R.RENTAL_DATE)>=0
GROUP BY 
F.TITLE, R.RENTAL_DATE, C.CUSTOMER_ID, C.FIRST_NAME, C.LAST_NAME
ORDER BY 
    R.RENTAL_DATE DESC;

-- 7 Calcolate il tempo medio tra due noleggi consecutivi da parte di un cliente

SELECT r1.customer_id Customer, 
avg(datediff( r2.rental_date , r1.rental_date)) TempoMedioTraNoleggio
from rental r1
INNER JOIN rental r2
ON r1.customer_id = r2.customer_id AND r1.rental_date < r2.rental_date 
GROUP BY r1.customer_id;

CREATE VIEW ViewMEDIANOLEGGI AS
SELECT 
r.customer_id ID_Cliente
, AVG(DATEDIFF(r.rental_date, (SELECT 
	rental_date 
  FROM rental
	WHERE rental_date < r.rental_date AND customer_id = r.customer_id
    AND year(RENTAL_DATE)<> 2006
	ORDER BY rental_date DESC
	LIMIT 1))) Media_Tempo_Tra_Noleggi
FROM rental r
WHERE year(R.RENTAL_DATE)<> 2006
GROUP BY r.customer_id
ORDER BY r.customer_id;

SELECT *
FROM ViewMEDIANOLEGGI_GIACOMO;

SELECT CUSTOMER_ID, DIFF_NOLEGGI-MEDIA_TEMPO_TRA_NOLEGGI AS DIFFERENZA_QUERY
FROM VIEW_MEDIANOLEGGI_SAL S
JOIN ViewMEDIANOLEGGI_GIACOMO G ON S.CUSTOMER_ID=G.ID_Cliente
ORDER BY DIFFERENZA_QUERY;

-- 8 Individuate il numero di noleggi per ogni mese del 2005

SELECT MONTHNAME(rental_date)
, count(Rental_id) NumeroNoleggi
FROM rental
WHERE year(rental_date) = 2005 
GROUP BY MONTHNAME(rental_date);

-- 9 Trovate i film che sono stati noleggiati almeno due volte lo stesso giorno

 SELECT f.title, count( r.rental_date) n1, count(distinct(r.rental_date)) n2
FROM rental r
INNER JOIN inventory i
ON r.inventory_id = i.inventory_id
INNER JOIN film f
on f.film_id = i.film_id
group by f.title
HAVING n1<>n2;



-- non va looses connection witht the server why?
-- 10 Calcolate il tempo medio di noleggio
SELECT avg(datediff(return_date, rental_date ))
FROM rental 
