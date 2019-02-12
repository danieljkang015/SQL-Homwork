use sakila;
-- 1a.
 select first_name
 	, last_name
    FROM actor;
    
-- 1b.
select CONCAT(first_name, " ", last_name) as "Actor Name"
FROM actor;

-- 2a.
SELECT actor_id
	, first_name, last_name
FROM actor
	WHERE first_name LIKE "Joe";

-- 2b.
SELECT actor_id
	, first_name, last_name
FROM actor
	WHERE last_name LIKE "%gen%";

-- 2c.
SELECT last_name
	, first_name
FROM actor
	WHERE last_name LIKE "%li%";
    
-- 2d.
SELECT country_id,country FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

-- 3a.
ALTER TABLE actor
	ADD description BLOB(30);

-- 3b.
AlTER TABLE actor
	DROP COLUMN description;
    
-- 4a.
SELECT distinct(last_name)
	, count(last_name) as "Num of Actors"
FROM actor
GROUP BY last_name;

-- 4b.
SELECT distinct(last_name)
	, count(last_name) as "Num of Actors"
FROM actor
GROUP BY last_name HAVING COUNT(last_name) > 1;  

-- 4c.
UPDATE actor
SET first_name = "HARPO" 
WHERE (first_name = "GROUCHO" AND last_name = "WILLIAMS");

-- 4d.
UPDATE actor
SET first_name = "GROUCHO"
WHERE (first_name = "HARPO" AND last_name = "WILLIAMS");

-- 5a.
CREATE TABLE address_again (
	address_id INT AUTO_INCREMENT NOT NULL,
    address BLOB(40),
    address2 BLOB(40),
    district VARCHAR(30),
    city_id INT,
    postal_code INT,
    phone INT,
    location BLOB(30),
    last_update BLOB(30),
    PRIMARY KEY (address_id)
    );

-- 6a.
USE sakila;
SELECT s.first_name
	, s.last_name
    , a.address
FROM staff s
	INNER JOIN address a ON s.address_id = a.address_id;

-- 6b. 
SELECT s.first_name
	, s.last_name
    , SUM(p.amount)
    , p.payment_date
FROM staff s
	INNER JOIN payment p ON s.staff_id = p.staff_id
    WHERE p.payment_date LIKE '%2005_08%';
    
-- 6c.
SELECT film.title
	, COUNT(film_actor.actor_id) AS "Num of Actors"
FROM film
	INNER JOIN film_actor ON film.film_id = film_actor.film_id
    GROUP BY film.title;
    
-- 6d.
SELECT COUNT(*) AS HowMany
FROM inventory
WHERE film_id IN
	(
    SELECT film_id
    FROM film
    WHERE title = 'Hunchback Impossible'
    );

-- 6e.
SELECT customer.first_name
	, customer.last_name
    , SUM(payment.amount) AS 'Total Amount Paid'
FROM customer
JOIN payment
ON payment.customer_id = customer.customer_id
GROUP BY customer.last_name, customer.first_name; 

-- 7a.
SELECT * FROM film f
INNER JOIN language l 
ON f.language_id = l.language_id
WHERE l.name = 'English' AND f.title LIKE 'K%' OR 'Q%';

-- 7b.
SELECT first_name
	, last_name
FROM actor
	WHERE actor_id IN 
    (
    SELECT actor_id
	FROM film_actor
    WHERE film_id IN
		(
		SELECT film_id
        FROM film
        WHERE title = 'Alone Trip'
        )
	);
  
-- 7c.
SELECT c.first_name
	, c.last_name
	, c.email
FROM customer c
INNER JOIN address a
ON c.address_id = a.address_id
	INNER JOIN city
	ON a.city_id = city.city_id
		INNER JOIN country
		ON city.country_id = country.country_id
		WHERE country.country = 'Canada';

-- 7d.
SELECT f.title
FROM film f
INNER JOIN film_category c
ON f.film_id = c.film_id
	INNER JOIN category
    ON c.category_id = category.category_id
WHERE category.name = 'family';

-- 7e.
SELECT f.title
	, COUNT(r.rental_id) AS 'Times Rented'
FROM rental r
INNER JOIN inventory i
ON r.inventory_id = i.inventory_id
	INNER JOIN film f
    ON i.film_id = f.film_id
GROUP BY f.title
ORDER BY 'Times Rented' DESC;

-- 7f.
SELECT s.store_id, SUM(amount) AS 'Revenue'
FROM payment p
INNER JOIN rental r
ON (p.rental_id = r.rental_id)
INNER JOIN inventory i
ON (i.inventory_id = r.inventory_id)
INNER JOIN store s
ON (s.store_id = i.store_id)
GROUP BY s.store_id;

-- 7g.
SELECT s.store_id
	, c.city
    , country.country
FROM store s
INNER JOIN address a
ON s.address_id = a.address_id
	INNER JOIN city c
    ON a.city_id = c.city_id
		INNER JOIN country
        ON c.country_id = country.country_id;

-- 7h.
SELECT c.name as 'Genre'
	, SUM(p.amount) as 'Gross'
FROM category c
INNER JOIN film_category fc
ON c.category_id = fc.category_id
	INNER JOIN inventory i
    ON fc.film_id = i.film_id
		INNER JOIN rental r
        ON i.inventory_id = r.inventory_id
			INNER JOIN payment p
            ON r.rental_id = p.rental_id
GROUP BY c.name
ORDER BY Gross DESC LIMIT 5;

-- 8a.
CREATE VIEW revenue_by_genre AS
SELECT c.name as 'Genre'
	, SUM(p.amount) as 'Gross'
FROM category c
INNER JOIN film_category fc
ON c.category_id = fc.category_id
	INNER JOIN inventory i
    ON fc.film_id = i.film_id
		INNER JOIN rental r
        ON i.inventory_id = r.inventory_id
			INNER JOIN payment p
            ON r.rental_id = p.rental_id
GROUP BY c.name
ORDER BY Gross DESC LIMIT 5;

-- 8b.
SELECT * FROM revenue_by_genre;

-- 8c.
DROP VIEW revenue_by_genre;









