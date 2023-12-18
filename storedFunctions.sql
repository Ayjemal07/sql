--Create a Cars table
create table t_cars(
	car_serial_id serial primary key,
	car_model varchar(100),
	car_year varchar(100)
)

--Now insert data into Cars using stored function
--Before recreating the add_car function with new parameter names,
-- it is required to drop the existing function if it exists.

DROP FUNCTION if exists add_car(int,varchar,varchar);
--User Stored Function to insert Data
CREATE OR REPLACE FUNCTION add_car(_car_id int, _car_model VARCHAR, _car_year VARCHAR)
RETURNS void 
AS $MAIN$
BEGIN
	INSERT INTO t_cars(car_serial_id,car_model,car_year)
	VALUES(_car_id,_car_model,_car_year);
END;
$MAIN$
LANGUAGE plpgsql;

-- Good Call of Function
SELECT add_car(001,'Toyota GR86', '2021');
-- Verify that new car has been added
SELECT * FROM t_cars WHERE car_serial_id = 001;


--Create Employees Table
create table t_employees(
	emp_id int primary key,
	emp_name varchar(250)
)


--Create Customers Table
create table t_customers(
	cust_id serial primary key,
	customer_name varchar(250)
)

--use regular insert query to customers
insert into t_customers(
	cust_id,
	customer_name
)
values(
	100,'Derick Barret Smith'
)


--Create Service Tickets Table for Repairs and Services
create table service_tickets(
	service_id int primary key,
	service_type varchar(200),
	need_parts boolean,
	emp_id int,
	cust_id serial,
	foreign key(cust_id) references t_customers,
	foreign key(emp_id) references t_employees(emp_id)
)

--Now insert data into Service Tickets using stored function

DROP FUNCTION if exists add_ticket(int,varchar,boolean,int);
--Use Stored Function to insert Data
CREATE OR REPLACE FUNCTION add_ticket(_service_id int, _service_type VARCHAR, _need_parts boolean,_cust_id int)
RETURNS void 
AS $MAIN$
BEGIN
	INSERT INTO service_tickets(service_id,service_type,need_parts,cust_id)
	VALUES(_service_id,_service_type,_need_parts,_cust_id);
END;
$MAIN$
LANGUAGE plpgsql;

-- Good Call of Function
SELECT add_ticket(10,'Filter change', true, 100);
-- Verify that new car has been added
SELECT * FROM service_tickets WHERE service_id = 10;


--Create Invoice for each sale of cars or service
create table t_invoices(
	invoice_id serial primary key,
	cust_id serial,
	emp_id int,
	car_serial_id serial,
	service_id int,
	amount numeric,
	payment_type varchar(200),
	foreign key(cust_id) references t_customers(cust_id),
	foreign key(emp_id) references t_employees(emp_id),
	foreign key(car_serial_id) references t_cars(car_serial_id),
	foreign key(service_id) references service_tickets(service_id)
)
--Now insert data into Invoice using stored function

DROP FUNCTION if exists add_invoice(int,int,int,numeric,varchar);
--Use Stored Function to insert Data
CREATE OR REPLACE FUNCTION add_invoice(_invoice_id int,_cust_id int,_service_id int,_amount numeric,_payment_type VARCHAR)
RETURNS void 
AS $MAIN$
BEGIN
	INSERT INTO t_invoices(invoice_id,cust_id,service_id,amount,payment_type)
	VALUES(_invoice_id,_cust_id,_service_id,_amount,_payment_type);
END;
$MAIN$
LANGUAGE plpgsql;

-- Good Call of Function
SELECT add_invoice(123457,100,10,123.89,'Credit card: Amex');
-- Verify that new invoice has been added
SELECT * FROM t_invoices WHERE invoice_id = 123457;


