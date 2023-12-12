--How many actors are there with the last name ‘Wahlberg’?
select first_name,last_name from actor where last_name='Wahlberg'


--How many payments were made between $3.99 and $5.99?
select count(*) as payments from payment where amount between 3.99 and 5.99


--What film does the store have the most of? (search in inventory)?
select film_id, count(*) as most_available from inventory group by film_id order by most_available desc limit 1


--How many customers have the last name ‘William’?
select first_name,last_name from actor where last_name='William'


--What store employee (get the id) sold the most rentals?
select staff_id, count(*) as best_employees from rental group by staff_id order by best_employees desc limit 1


--How many different district names are there?

select count(distinct district) from address


--What film has the most actors in it? (use film_actor table and get film_id)
select film_id, count(distinct actor_id) as most_ones from film_actor group by film_id order by most_ones desc limit 1


--From store_id 1, how many customers have a last name ending with ‘es’? (use customer table)
select count(*) from customer where last_name like '%es'and store_id=1


--How many payment amounts (4.99, 5.99, etc.) had a number of rentals above 250 for customers
--with ids between 380 and 430? (use group by and having > 250)

--select count(amount),customer_id as amounted from payment group by customer_id having>250
SELECT payment.amount, COUNT(rental.rental_id) AS num_rentals
FROM payment
JOIN rental ON payment.rental_id = rental.rental_id
JOIN customer ON payment.customer_id = customer.customer_id
WHERE customer.customer_id BETWEEN 380 AND 430
GROUP BY payment.amount
HAVING COUNT(rental.rental_id) > 250;


--Within the film table, how many rating categories are there? And what rating has the most movies total?
select count(distinct rating) as num_films from film
select rating, count(*) as most_movies from film group by rating order by most_movies desc limit 1
