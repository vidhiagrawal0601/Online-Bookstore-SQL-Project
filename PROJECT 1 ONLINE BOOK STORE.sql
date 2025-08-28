DROP TABLE IF EXISTS CUSTOMERS;

CREATE TABLE CUSTOMERS (
CUSTOMER_ID SERIAL PRIMARY KEY,
NAME VARCHAR(100),
EMAIL VARCHAR(50),
PHONE VARCHAR(15),
CITY VARCHAR(50),
COUNTRY VARCHAR(50)
);

DROP TABLE IF EXISTS BOOKS;
CREATE TABLE BOOKS(
BOOK_ID SERIAL PRIMARY KEY,
TITTLE VARCHAR(200),
AUTHOR VARCHAR(100),
GENRE VARCHAR (50),
PUBLISHED_YEAR INT,
PRICE DECIMAL(10,2),
STOCK INT
);

DROP TABLE IF EXISTS ORDERS;
CREATE TABLE ORDERS(
ORDER_ID SERIAL PRIMARY KEY,
CUSTOMER_ID INT REFERENCES CUSTOMERS(CUSTOMER_ID),
BOOK_ID INT REFERENCES BOOKS(BOOK_ID),
ORDER_DATE DATE,
QUANTITY INT,
TOTAL_AMOUNT DECIMAL(10,2)
);


--IMPORT DATA INTO TABLE(CUSTOMERS)THROUGH CSV 
COPY
CUSTOMERS(CUSTOMER_ID, NAME, EMAIL, PHONE, CITY, COUNTRY)
FROM 'D:\Customers.csv'
CSV HEADER;

ALTER TABLE CUSTOMERS
ALTER COLUMN COUNTRY TYPE VARCHAR (100);


SELECT* FROM CUSTOMERS;

--IMPORT DATA INTO TABLE(BOOKS)
COPY
BOOKS(BOOK_ID, TITTLE, AUTHOR, GENRE, PUBLISHED_YEAR, PRICE, STOCK)
FROM'D:\Books.csv'
CSV HEADER;

SELECT* FROM BOOKS;

--IMPORT DATA INTO TABLE(ORDERS)
COPY
ORDERS(ORDER_ID, CUSTOMER_ID, BOOK_ID, ORDER_DATE, QUANTITY, TOTAL_AMOUNT)
FROM'D:\Orders.csv'
CSV HEADER;

SELECT* FROM ORDERS;

--  1) Retrieve all books in the "Fiction" genre:
SELECT* FROM BOOKS
WHERE GENRE='Fiction';

--  2) Find books published after the year 1950:
	SELECT * FROM BOOKS
	WHERE PUBLISHED_YEAR>1950;

-- 3) List all customers from the Canada:
	SELECT * FROM CUSTOMERS
	WHERE COUNTRY= 'Canada'

-- 4) Show orders placed in November 2023:
SELECT * FROM ORDERS
WHERE ORDER_DATE BETWEEN '2023-11-01' AND '2023-11-30';

-- 5) Retrieve the total stock of books available:
SELECT SUM(STOCK) AS TOTAL_STOCK FROM BOOKS;

-- 6) Find the details of the most expensive book:
SELECT * FROM BOOKS
ORDER BY PRICE DESC
LIMIT 1;

-- 7) Show all customers who ordered more than 1 quantity of a book:
SELECT * FROM ORDERS
WHERE QUANTITY > 1;

-- 8) Retrieve all orders where the total amount exceeds $20:
SELECT* FROM ORDERS
WHERE TOTAL_AMOUNT >20;

-- 9) List all genres available in the Books table:
SELECT DISTINCT GENRE FROM BOOKS;

-- 10) Find the book with the lowest stock:
SELECT * FROM BOOKS
ORDER BY STOCK ASC
LIMIT 1;

-- 11) Calculate the total revenue generated from all orders:
SELECT SUM(TOTAL_AMOUNT) AS TOTAL_REVENUE FROM ORDERS;

-- 12) Retrieve the total number of books sold for each genre
SELECT 
    b.genre,
    SUM(o.quantity) AS total_books_sold
FROM orders o
JOIN books b ON o.book_id = b.book_id
GROUP BY b.genre
ORDER BY total_books_sold DESC;

-- 13) List customers who have placed at least 2 orders:
SELECT 
    customer_id,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id) >= 2
ORDER BY total_orders DESC;

-- 14) Find the most frequently ordered book:

SELECT BOOK_ID, COUNT(ORDER_ID) AS COUNTED_BOOKS
FROM ORDERS
GROUP BY BOOK_ID
ORDER BY COUNT(ORDER_ID) DESC
LIMIT 1;

-- 15) Show the top 3 most expensive books of 'Fantasy' Genre :
SELECT * FROM BOOKS
WHERE GENRE ='Fantasy'
ORDER BY PRICE DESC LIMIT 3;

-- 16) Retrieve the total quantity of books sold by each author:
SELECT B.AUTHOR, SUM(O.QUANTITY) AS TOTAL_BOOK_SOLD
FROM BOOKS B
JOIN
ORDERS O 
ON B.BOOK_ID= O.ORDER_ID
GROUP BY B.AUTHOR;

-- 17) List the cities where customers who spent over $30 are located:
SELECT DISTINCT(C.CITY), O.TOTAL_AMOUNT
FROM CUSTOMERS C
JOIN ORDERS O
ON C.CUSTOMER_ID= O.CUSTOMER_ID
WHERE O.TOTAL_AMOUNT>30;

-- 18) Find the customer who spent the most on orders:
SELECT C.NAME, SUM(O.TOTAL_AMOUNT)
FROM CUSTOMERS C
JOIN
ORDERS O
ON C.CUSTOMER_ID = O.CUSTOMER_ID
GROUP BY C.NAME
ORDER BY SUM(O.TOTAL_AMOUNT) DESC LIMIT;




















