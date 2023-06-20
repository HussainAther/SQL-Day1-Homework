-- -- Let's start by taking a look at our table names
-- SELECT table_name
-- FROM information_schema.tables
-- WHERE table_schema = 'information_schema';

-- -- How many actors are there with the last name 'Wahlberg'?
-- SELECT COUNT(*)
-- FROM actor
-- WHERE last_name = 'Wahlberg';
-- Answer: 2

-- -- How many payments were made between $3.99 and $5.99?
-- -- Assuming this is an inclusive range...
-- SELECT COUNT(*) AS num_payments
-- FROM payment
-- WHERE amount >= 3.99 AND amount <= 5.99;
-- Answer: 5607

-- -- What film does the store have the most of? (search in inventory)
-- SELECT film.title, COUNT(inventory.inventory_id) AS num_copies
-- FROM film
-- JOIN inventory ON film.film_id = inventory.film_id
-- GROUP BY film.title
-- ORDER BY num_copies DESC;
-- LIMIT 1;
-- Answer: "Rush Goodfellas", if we limit ourselves to 1

-- -- If we want to get all the films if they're tied for first, we run this:
-- SELECT film.title, COUNT(inventory.inventory_id) AS num_copies
-- FROM film
-- JOIN inventory ON film.film_id = inventory.film_id
-- GROUP BY film.title
-- HAVING COUNT(inventory.inventory_id) = (
--     SELECT MAX(copy_count)
--     FROM (
--         SELECT COUNT(inventory.inventory_id) AS copy_count
--         FROM film
--         JOIN inventory ON film.film_id = inventory.film_id
--         GROUP BY film.title
--     ) AS copy_counts
-- );
-- Answer: many

-- -- How many customers have the last name 'William' ?
-- SELECT COUNT(*) AS num_customers
-- FROM customer
-- WHERE last_name = 'William';
-- Answer: 0

-- -- What store employee (get the id) sold the most rentals?
-- SELECT staff_id, COUNT(*) AS num_rentals
-- FROM rental
-- GROUP BY staff_id
-- ORDER BY num_rentals DESC
-- LIMIT 1;
-- Answer: 1, with 8040 rentals

-- -- How many different district names are there?
-- SELECT COUNT(DISTINCT district) AS num_districts
-- FROM address;
-- Answer: 378

-- -- Which film has the most actors ?
-- SELECT film_id, COUNT(actor_id) AS num_actors
-- FROM film_actor
-- GROUP BY film_id
-- ORDER BY num_actors DESC
-- LIMIT 1;
-- Answer: film_id 508 - 15 actors

-- -- From store_id 1, how many customers have a last name ending with 'es'? (use customer table)
-- SELECT COUNT(*) AS num_customers
-- FROM customer
-- WHERE store_id = 1 AND last_name LIKE '%es';
-- Answer: 13

-- -- How many payment amounts (4.99, 5.99, etc.) had a number of rentals above 250 for customers with ids between 380 and 430? (use group by and having > 250)
-- SELECT COUNT(*) AS num_amounts
-- FROM (
--     SELECT amount, COUNT(*) AS num_payments
--     FROM payment
--     WHERE customer_id BETWEEN 380 AND 430
--     GROUP BY amount
--     HAVING COUNT(*) > 250
-- ) AS subquery;
-- Answer: 3

-- -- Within the film table, how many rating categories are there? And what rating has the most movies total?
-- Count the number of rating categories
-- SELECT COUNT(DISTINCT rating) AS num_rating_categories
-- FROM film;

-- -- Identify the rating with the most movies total
-- SELECT rating, COUNT(*) AS num_movies
-- FROM film
-- GROUP BY rating
-- ORDER BY num_movies DESC
-- LIMIT 1;
-- Answer: 5 ratings, PG-13 has the most