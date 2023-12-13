--create customers table
CREATE TABLE customers_theater24(
	customer_id int PRIMARY KEY,
	customer_name VARCHAR(100),
	address VARCHAR(150)
);


--insert to customers
insert into customers_theater24(
	customer_id,
	customer_name,
	address
)
values(
	12345,
	'Jessica Carter',
	'1230 Circle Dr Chicago IL'
)

--create movies table
create table movies_theater24(
	movie_id serial primary key,
	movie_title varchar(250),
	movie_date date,
	movie_rating varchar(30)
);


--insert to movies table
insert into movies_theater24(
	movie_id,
	movie_title,
	movie_date,
	movie_rating
)
values(
	1000001,
	'Dusk Till Dawn',
	'2005-05-20',
	'IBM 8.9'
);

--create tickets table
create table tickets_theater24(
	ticket_id serial primary key,
	customer_id int,
	ticket_price int,
	movie_id serial,
	foreign key(customer_id) references customers_theater24(customer_id),
	foreign key(movie_id) references movies_theater24(movie_id)
);

--insert to tickets
insert into tickets_theater24(
	ticket_id,
	customer_id,
	ticket_price,
	movie_id
)

values(
	0003,
	12345,
	16.99,
	1000001
);

--create concessions table
create table concessions_theater24(
	conc_price int primary key,
	customer_id int,
	ticket_id serial not null,
	conc_category varchar(55),
	foreign key(customer_id) references customers_theater24(customer_id),
	foreign key(ticket_id) references tickets_theater24(ticket_id)
);

--insert to concessions
insert into concessions_theater24(
	conc_price,
	ticket_id,
	conc_category
)
values(
	3.99,
	0003,
	'senior'
);





