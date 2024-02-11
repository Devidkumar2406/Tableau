create database data_analysis;

CREATE TABLE sales1(
salesman_id int(6) ,
Sname varchar (25),
city varchar (10),
commission decimal (2,2));

desc sales1;

INSERT INTO sales1 (salesman_id,sname,city,commission)
 values
(5001,"james Hoog","New york",0.15),
 (5002,"Nail Knite","Paris",0.13),
 (5005,"Pit Alex","London",0.11),
 (5006,"Mc Lyon","Paris",0.14),
 (5007, "Paul Adam"," Rome",0.13),
 (5003, "Lauson Hen", "San Jose", 0.12);

SELECT * FROM SALES1;

create table SALES2(
cust_id int(6) primary key ,
cust_name varchar(15),
city varchar(10),
grade int(4),
salesman_id int(4));

INSERT INTO sales2 (cust_id, cust_name, city, grade, salesman_id)
VALUES
	(3002, 'Nick Rimando', 'New York', 100, 5001),
    (3007, 'Brad Davis', 'New York', 200, 5001),
    (3005, 'Graham Zusi', 'California', 200, 5002),
    (3008, 'Julion Green', 'London', 300, 5005),
    (3004, 'Fabion Johson', 'Paris', 300, 5006),
    (3009, 'Geoff Cameron', 'Berlin', 100, 5003),
    (3003, 'Jozy Altidor', 'Moscow', 200, 5007);

select * from sales2;


update sales1 set commission = 0.22
where sname = 'Pit Alex';

update sales1 set city = 'Paris'
where salesman_id = 5003;

select * from sales1;

update sales2 set grade = 300
where cust_name = "Graham Zusi";

update sales2 set city = 'London'
where cust_id = 3009;

select salesman_id, sname, city, commission from sales1
where city in ('paris','Rome');

update sales1 set city= "Rome"
where salesman_id = 5007;


SELECT salesman_id, sname, city, commission
FROM sales1
WHERE commission BETWEEN 0.12 AND 0.14;

SELECT salesman_id, sname, city, commission
FROM sales1
WHERE sname between 'a' and 'k';


select * from sales2
where cust_name like "B%";

select * from sales2
where cust_name like"%n";

select * from sales1
where sname like "N__l%";

create table nobel (
Year int (5),
subject varchar (10),
winner varchar (20),
country varchar (10),
category varchar (11)
);

alter table nobel 
modify winner varchar(50);

alter table nobel
modify category varchar(30);

alter table nobel
modify subject varchar(30);

insert into nobel (year, subject, winner, country, category)
values ( 1970, 'physics', 'Hannes alfven', 'sweden', 'scientist'),
(1970,'Physics', 'Louis Neel', 'France', 'Scientist'),
(1970, 'chemestry', 'Luis Federico Leloir', 'France', 'Scientist'),
(1970,'Physiology', 'Ulf von Euler', 'Sweden', 'Scientist'),
(1970, 'Physiology', 'Bernard Katz', 'Germany', 'Scientist'),
(1970, 'Literature', 'Aleksandr Solzhenitsyn', 'Russia', 'Linguist'),
(1970, 'Economics', 'Paul Samuelson', 'USA', 'Economist'),
(1970, 'Physiology', 'julius Axelrod', 'usa', 'scientist'),
(1971, 'physics', 'Deniss Gabor', 'Hungry', 'scientist'),
(1971, 'chemistry', 'Gerhard Herzberg', 'germany', 'scientist'),
(1971, 'peace', 'willy brandt', 'germany', 'chancellor'),
(1971, 'litreure', 'Pablo Neruda', 'chile', 'linguist'),
(1971, 'Economics', 'simon kuznets', 'Russia', 'Economist'),
(1978, 'peace', 'Anwae al-sadat', 'Egypty', 'President'),
(1978, 'peace', 'menachem Begin', 'israel', 'prime minister'),
(1987, 'chemistry', 'donald j. cram', 'usa', 'scientist'),
(1987, 'chemistry', 'jean-marie lehn', 'france', 'scientist'),
(1987, 'physiologist', 'susumu tonegawa', 'japan', 'scientist'),
(1994, 'economics', 'reinhard selten', 'germany', 'economist'),
(1994, 'peace', 'yitzhak rabin', 'israel', 'prime miniser'),
(1987, 'physics', 'johannes georg bednorz', 'germany', 'scientist'),
(1987, 'literature', 'joseph brodsky', 'russia', 'linguist'),
(1987, 'economics', 'robert solow', 'usa', 'ecomonist'),
(1994, 'literature', 'kenzaburo oe', 'japan', 'linguist');

SELECT year, subject, winner, country, category
FROM nobel
WHERE (subject = 'Physics' AND year = 1970)
   OR (subject = 'Economics' AND year = 1971);

select * from sales1;

SELECT 
    sname, sales1.city, cust_name
FROM
    sales1
        JOIN
    sales2 ON sales1.city = sales2.city;

SELECT *
FROM sales1
WHERE commission > 0.12
order by commission desc;

select cust_name, sales2.city as cust_city,
sname, sales1.city as salesman_city, sales1.commission
from sales2
join sales1
on sales2.salesman_id=sales1.salesman_id
where sales1.city<>sales2.city
and commission > 0.12;

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(255),
    City VARCHAR(255)
);

INSERT INTO Customers (CustomerID, CustomerName, City) VALUES
(1, 'John Smith', 'New York'),
(2, 'Jane Doe', 'Los Angeles'),
(3, 'Bob Johnson', 'Chicago');

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    Product VARCHAR(255),
    Quantity INT,
    Price DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

INSERT INTO Orders (OrderID, CustomerID, Product, Quantity, Price) VALUES
(1, 1, 'Laptop', 2, 340.00),
(2, 1, 'Printer', 1, 240.00),
(3, 2, 'Smartphone', 3, 70.00),
(4, 3, 'Tablet', 2, 80.00);

SELECT DISTINCT CustomerName
FROM Customers
JOIN Orders ON Customers.CustomerID = Orders.CustomerID
WHERE Orders.Price > 100;

SELECT DISTINCT Product, CITY
FROM Orders 
JOIN Customers ON Orders.CustomerID = Customers.CustomerID
WHERE Customers.City = (SELECT City FROM Customers WHERE CustomerName = 'John Smith');

SELECT OrderID, SUM(Quantity * Price) AS TotalAmount
FROM Orders
WHERE OrderID IN (
    SELECT DISTINCT OrderID
    FROM Orders
    WHERE Quantity > 2
)
GROUP BY OrderID;