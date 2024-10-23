SELECT * FROM actor;
SELECT * FROM address;
SELECT * FROM category;
SELECT * FROM city;
SELECT * FROM country;
SELECT * FROM customer;
SELECT * FROM film;
SELECT * FROM film_actor;
SELECT * FROM film_category;
SELECT * FROM film_text;
SELECT * FROM inventory;
SELECT * FROM language;
SELECT * FROM payment;
SELECT * FROM rental;
SELECT * FROM staff;
SELECT * FROM store;

-- 2
SELECT SUM(customer_id)
FROM customer
Group by customer_id, create_date
HAVING 	year(create_date) = 2006;

-- Versione unna sola stringa 
SELECT COUNT(DISTINCT customer_id) AS total_customers_2006
FROM customer
WHERE YEAR(create_date) = 2006;

-- 3 
SELECT COUNT(DISTINCT rental_id) AS TotalRents
FROM rental
WHERE YEAR(rental_date) = '01-01-2006';


-- 4
SELECT 
f.Title 
, c. first_name
, c.last_name
, r.rental_date
FROM rental r
INNER JOIN inventory i
ON r.inventory_id = i.inventory_id
INNER JOIN film f 
ON f.film_id = i.film_id
INNER JOIN store s 
ON s.store_id = i.store_id
INNER JOIN customer c
ON c.store_id = s.store_id
WHERE  r.rental_date BETWEEN '2005-05-28'  AND '2006-06-03';-- INTERVAL 7  DAY; -- ultima settimana 

-- 5 Durata media noleggio per categoria 
SELECT cc.name Categoria
, avg(datediff(r.return_date, r.rental_date)) DurataMedia
FROM rental r
INNER JOIN inventory i
ON r.inventory_id = i.inventory_id
INNER JOIN film f 
ON f.film_id = i.film_id
INNER JOIN film_category c
ON c.film_id = f.film_id
INNER JOIN category cc
ON c.category_id = cc.category_id
GROUP BY c.category_id;


-- 6 Trova la durata del noleggio più lungo 

SELECT rental_id
, MAX(return_date-rental_date) as DurataMaxima
FROM rental 
GROUP BY rental_id
ORDER BY DurataMaxima DESC;

Select MAX(DurataMaxima)
FROM (SELECT rental_id
, MAX(datediff(return_date, rental_date)) as DurataMaxima
FROM rental 
GROUP BY rental_id
) maxi;





