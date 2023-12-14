--1. List all customers who live in Texas
select first_name,last_name,district from customer inner join address on customer.address_id=address.address_id where district='Texas'

--2. Get all payments above $6.99 with the Customer's Full Name
select amount,first_name,last_name from payment left join customer on payment.customer_id=customer.customer_id where amount>6.99

--3. Show all customers names who have made payments over $175
--query without subquery
select first_name, last_name, amount from customer right join payment on customer.customer_id=payment.customer_id where amount>175
--query using subquery
select cust.first_name,cust.last_name,payment.amount from (select first_name,last_name,customer_id from customer) as cust inner join payment on cust.customer_id=payment.customer_id where amount> 175

--4. List all customers that live in Nepal (use the city table)
select city,country from city left join country on city.country_id=country.country_id where country='Nepal'

--5. Which staff member had the most transactions?
select staff.staff_id, count(*) as total_transactions from payment left join staff on payment.staff_id=staff.staff_id group by staff.staff_id order by total_transactions desc limit 1

--How many movies of each rating are there?
select rating, count(*) as total_movies from film group by rating order by total_movies

--7.Show all customers who have made a single payment above $6.99 (Use Subqueries)
select * from 
	(
		select count(customer_id) as num_of_transactions,customer_id as customers
		from payment
		where amount>6.99
		group by customers
	) as a right join customer on a.customers=customer.customer_id
where a.num_of_transactions=1

--8. How many free rentals did our stores give away?
--first answer: displays entire list showing less than $1 amounts for each rental_id, so it basically shows how much each rental got it for free
select amount,rental_id,count(rental_id) as free_rentals from payment where amount<1 group by rental_id,amount
--second answer: displays total number of free rental give aways all added together
select count(*) as total_free_rentals from payment where amount<1;


