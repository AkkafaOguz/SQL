--Create worker table fiels are worler_id, worker_name, worker_salary
--worker_id will have primary key with name woker_id_pk
--Insert 4 records into the workers table
--See the table on the console


CREATE TABLE worker 
(

    worker_id char(3),
    worker_name VARCHAR2(50),
    worker_salary NUMBER(7,2),
    CONSTRAINT worker_id_pk PRIMARY KEY (worker_id)

);

DROP TABLE worker;

INSERT INTO WORKER VALUES ('123','Oguzhan Akkafa', 12000);
INSERT INTO WORKER VALUES ('102','Veli Han', 2000);
INSERT INTO WORKER VALUES ('103','Ayse Kan', 7000);
INSERT INTO WORKER VALUES ('104', 'Angie Ocean', 8500);

SELECT * FROM WORKER ;

UPDATE WORKER 
SET worker_name = 'Ali Can',
    worker_id = '101'
WHERE worker_salary = 12000 ;    


--insrease the salary of Veli Han to 20 percent less than the higest salary

UPDATE WORKER 
SET  worker_salary = ((SELECT max(worker_salary) FROM WORKER) - (SELECT max(worker_salary) FROM WORKER)*0.20 )
WHERE worker_name = 'Veli Han';


--Decrease the salary of Ali Can to 30 percent more than the lowest salary

UPDATE WORKER 
SET worker_salary = (SELECT min(worker_salary)*1.30 FROM worker)      
WHERE worker_name = 'Ali Can';


--Increase the salaries by 1000 if the salary are less then the avarege salary (AVG)

UPDATE WORKER 
SET worker_salary = worker_salary + 1000
WHERE worker_salary < (SELECT AVG(worker_salary) FROM WORKER );


--Increase the salaries equal to the avarage salary  if the salary are less then the avarege salary (AVG)

UPDATE WORKER 
SET worker_salary = (SELECT AVG(worker_salary) FROM WORKER )
WHERE worker_salary < (SELECT AVG(worker_salary) FROM WORKER );


--IS NULL condition 

CREATE TABLE people 
(

    ssn CHAR (9),
    name VARCHAR2(50),
    address VARCHAR(80)

);

DROP TABLE PEOPLE;


INSERT INTO PEOPLE VALUES (123456789, 'Mark Star', 'Florida');
INSERT INTO PEOPLE VALUES (234567890, 'Angie Way', 'Virginia');
INSERT INTO PEOPLE VALUES (345678901, 'Marry Tien', 'New Jersey');
INSERT INTO PEOPLE (ssn, address) VALUES (456789012, 'Michigan');
INSERT INTO PEOPLE (ssn, address) VALUES (567890123, 'California');
INSERT INTO PEOPLE (ssn, name) VALUES (567890123, 'California');

SELECT * FROM PEOPLE ;

--Change null names to "name will be inserted later"

UPDATE PEOPLE 
SET name = 'Name will be inserted later'
WHERE name IS NULL ;

--Change the null addresses to 'Adress will be inserted later'

UPDATE PEOPLE 
SET address = 'Adress will be inserted later'
WHERE address IS NULL;

--Change all null values 'To be inserted later' in people table -- COALESCE GOES TO THE FIELDS AND CHANGE THE NULL VALUES TO THE SECOND PARAMATER

UPDATE people 
SET name = COALESCE (name,'To be inserted later'),  
    address = COALESCE (address,'To be inserted later');
   
   
   
--HOW TO DELETE DATA(RECORD) FROM A TABLE   
   
   DELETE FROM PEOPLE 
   WHERE ssn = 234567890;
  
--Delete record which do not have name  
  
  DELETE FROM PEOPLE 
  WHERE name = 'To be inserted later';
 
 
--Delete ALL RECORDS	 
--DELETE Command deletes just the records, it does not destrot the table  (Can be onterview question) In your schema table still exist

  DELETE FROM PEOPLE ;    --DELETE ALL RECORDS BECAUSE THERE IS NO ANY FILTER (WHERE) 
   
--DELETE all records whose names is NULL or address is NULL
--Do not use "= NULL" use "IS NULL"
  
  DELETE FROM People 
  WHERE name IS NULL OR address IS NULL;
 
 
--DELETE all records whose ssn is greater than  123456799 and less than 345678901
 
 DELETE FROM people 
 WHERE ssn > 123456799 AND ssn < 345678901;   --AFTER WHERE we can use "OR" and "AND" 
 
 
DELETE FROM PEOPLE ;
 
-- DELETE all records whose name is not null 
 
  DELETE FROM PEOPLE 
  WHERE name IS NOT NULL;
 
 
--TRUNCATE Command removes all records everytime
 
--TRUNCATE TABLE people is the same with the "DELETE FROM people"
 
--What are the differences between TRUNCATE and DELETE FROM  (INTERVIEW QUESTION)
 
-- 1) In DELETE you can use WHERE Clause to filter, but in TRUNCATE you cannot
-- 2) If you remove records by using DELETE FROM, the records can be rolled back, but if you remove records by using TRUNCATE 
--    the records cannot be rolled back (THE MAIN DIFFERENCE)
 
 TRUNCATE TABLE people;    

 SELECT * FROM people;   


--HOW TO REMOVE TABLE FROM SCHEMA (TABLES RELATED WITH EACH OTHER ==> SCHEMA)

DROP TABLE PEOPLE ;       --> IF you do NOT use "PURGE" you can GET the TABLE back by typing same codes
DROP TABLE WORKER PURGE ; --> IF you use "PURGE" YOU CANNOT GET the TABLE back


--In Java "NOT EQUAL" means "!=", in SQL "NOT EQUAL" means "<>"



--DQL : It is language for reading data. We will use "SELECT"

CREATE TABLE worker 
(

    id char(5),
    name VARCHAR2(50),
    salary NUMBER(5),
   
    CONSTRAINT id4_pk PRIMARY KEY (id)

);


INSERT INTO WORKER VALUES ('10001','Ali Can', 12000);
INSERT INTO WORKER VALUES ('10002','Veli Han', 2000);
INSERT INTO WORKER VALUES ('10003','Ayse Kan', 7000);
INSERT INTO WORKER VALUES ('10004', 'Angie Ocean', 8500);


SELECT * 
FROM WORKER;            -->Keyword must be different line in DQL. This IS format.


--How to get a specific field from a table

SELECT name
FROM WORKER w ;

--How to get specific multiple fields

SELECT name, salary
FROM WORKER w ;

--How to get specific record

SELECT *
FROM worker
WHERE id = 10001;

--How to get multiple specific records

SELECT *
FROM WORKER w 
WHERE id < 10003;

--Get records whose salary is 2000 or 7000 or 12000

--1.Way      (NOT RECOMENDED BOECAUSE OF THE REPETITION)

SELECT *
FROM WORKER w 
WHERE salary = 2000 OR SALARY = 7000 OR SALARY =12000;


--2.Way

--Instead of using or again and again use "IN"

SELECT * 
FROM WORKER w 
WHERE salary IN (2000,7000,12000);   --> IF the salaray "IN"SIDE that list it will RETURN ALL recods


--How to select specific cell

SELECT name
FROM WORKER w 
WHERE id = 10002;


-- How to select record whose salary is the highest  (VERY COMMON INTERVIEW QUESTION)

SELECT *
FROM WORKER w 
WHERE salary = (SELECT max(salary) FROM WORKER w2 );
--                 This part is called subquery

--How to select worker name whose salary is the lowest  (VERY COMMON INTERVIEW QUESTION)

SELECT name 
FROM worker 
WHERE salary = (SELECT min(SALARY) FROM WORKER w );


--How to select records whose salary is the lowest and the highest  (VERY COMMON INTERVIEW QUESTION)

--1.Way: (Pereferable one because of the repetation)

SELECT *
FROM WORKER w 
WHERE salary = (SELECT min(SALARY) FROM WORKER w) OR salary =  (SELECT max(salary) FROM WORKER w2 );

--2.Way:

SELECT *
FROM WORKER w 
WHERE salary IN  ((SELECT min(SALARY) FROM WORKER w),(SELECT max(salary) FROM WORKER w2 ));


--1)Select maximum salary (MAX)
--2)Select minimum salary (MIN)
--3)Select average salary (AVG)
--4)Select the number of worker (COUNT)
--5)Select the sum of the salaries (SUM)

--By using "AS" you can put temporary field names for your table on the console

--1)Select maximum salary
SELECT max(salary) AS Maximum_Salary
FROM WORKER w ;

--2)Select minimum salary
SELECT min(salary) AS Minimum_Salary
FROM WORKER w ;

--3)Select average salary
SELECT avg(salary) AS average_salary
FROM WORKER w ;

--4)Select the number of worker
SELECT COUNT(name) AS number_of_workers
FROM WORKER w ;

--5)Select the sum of the salaries
SELECT sum(salary) AS Total_salary
FROM WORKER w ;


--The Best Interview Question : Select the second highest salary (********)

SELECT MAX(SALARY) AS second_maximum_salary
FROM WORKER w 
WHERE salary < (SELECT MAX(SALARY) FROM WORKER);


--Select the second highest salary

SELECT min(salary) AS second_minimum_salary
FROM WORKER w 
WHERE salary > (SELECT min(salary) FROM WORKER);


--Difficult Interview Question: Select the third highest salary  (********)

SELECT MAX(salary) AS third_max_salary
FROM WORKER w 
WHERE salary < (SELECT MAX(SALARY) FROM worker WHERE salary < (SELECT MAX(salary) FROM WORKER));


--Select the third lowest salary 

SELECT min(salary) AS third_min_salary
FROM WORKER w 
WHERE salary > (SELECT MIN(salary) FROM WORKER w2 WHERE salary > (SELECT MIN(SALARY) FROM WORKER w3));


--Select the all data about the worker whose salary ýs the second hýghest

--1.Way : (Can be used all SQL Platforms)

SELECT *
FROM worker
WHERE salary = (SELECT MAX(SALARY) AS second_maximum_salary
                FROM WORKER w 
                WHERE salary < (SELECT MAX(SALARY) 
                                FROM WORKER));
                               
--2.Way: (Can be used only Oracle SQL (PL/SQL))  (I could bot use because of the Oracle version)

SELECT *
FROM WORKER 
ORDER BY salary DESC 
OFFSET 1 ROW 
FETCH NEXT 1 ROW ONLY;
                               

--Select the all data about the worker whose salary ýs the second lowest

--1.Way : (Can be used all SQL Platforms)

SELECT *
FROM worker
WHERE salary = (SELECT min(SALARY) AS second_minimum_salary
                FROM WORKER w 
                WHERE salary > (SELECT min(SALARY) 
                                FROM WORKER));
                               
--2.Way: (Can be used only Oracle SQL (PL/SQL))  (I could bot use because of the Oracle version)
                               
SELECT *
FROM WORKER 
ORDER BY salary ASC 
OFFSET 1 ROW 
FETCH NEXT 1 ROW ONLY;                               
                               
                               

--Challange : Select all data whose salary is the third highest salary from workers table


--1.Way : (Can be used all SQL Platforms)

SELECT *
FROM WORKER 
WHERE salary = (SELECT MAX(salary) 
                FROM WORKER 
                WHERE salary < (SELECT MAX(salary)
                                FROM WORKER
                                WHERE salary < (SELECT MAX(salary) 
                                                FROM worker)));
                                               
                                               
--2.Way: (Can be used only Oracle SQL (PL/SQL))  (I could bot use because of the Oracle version)
                                              
SELECT *
FROM WORKER 
ORDER BY salary DESC 
OFFSET 2 ROW 
FETCH NEXT 1 ROW ONLY;



CREATE TABLE CUSTOMERS_PRODUCTS 
(
  product_id number(10),
  customer_name varchar2(50),
  product_name varchar(50)
);

INSERT INTO CUSTOMERS_PRODUCTS VALUES (10,'Mark','Orange');
INSERT INTO CUSTOMERS_PRODUCTS VALUES (10,'Mark','Orange');
INSERT INTO CUSTOMERS_PRODUCTS VALUES (20,'John','Apple');
INSERT INTO CUSTOMERS_PRODUCTS VALUES (30,'Amy','Palm');
INSERT INTO CUSTOMERS_PRODUCTS VALUES (20,'Mark','Apple');
INSERT INTO CUSTOMERS_PRODUCTS VALUES (10,'Adem','Orange');
INSERT INTO CUSTOMERS_PRODUCTS VALUES (40,'John','Apricot');
INSERT INTO CUSTOMERS_PRODUCTS VALUES (20,'Eddie','Apple');


SELECT * FROM CUSTOMERS_PRODUCTS;



-- IN CONDITION : Instead of multiple OR we use IN  (********)


--1) Select records whose product name is Orange or Apple or Palm

--1.Way: NOT RECOMENDED BECAUSE OF THE REPETITION 

SELECT *
FROM CUSTOMERS_PRODUCTS cp 
WHERE PRODUCT_NAME = 'Orange' OR PRODUCT_NAME = 'Apple' OR PRODUCT_NAME = 'Palm';

--2.Way : 

SELECT *
FROM CUSTOMERS_PRODUCTS cp 
WHERE PRODUCT_NAME IN ('Orange', 'Apple','Palm');



-- NOT IN CONDITION  (********)


--2) Select records whose product name is Orange or Apple or Palm

SELECT *
FROM CUSTOMERS_PRODUCTS cp 
WHERE PRODUCT_NAME NOT IN ('Orange', 'Apple','Palm');



-- BETWEEN CONDITION (Both side inclisuve) (********)


--3) Select records whose product id is less than or equal to 30 and greater than or equal to 20

--1.Way : NOT RECOMENDED BECAUSE OF THE REPETITION 

SELECT *
FROM CUSTOMERS_PRODUCTS cp 
WHERE PRODUCT_ID <= 30 AND PRODUCT_ID >=20;


--2.Way : 

SELECT *
FROM CUSTOMERS_PRODUCTS cp 
WHERE PRODUCT_ID BETWEEN 20 AND 30;  --> 20 and 30 are both inclusive



-- NOT BETWEEN CONDITION (Both side exclusive) (********)


--4) Select records whose product id is less than 20 or greater than 25

--1.Way:

SELECT *
FROM CUSTOMERS_PRODUCTS cp 
WHERE PRODUCT_ID < 20 OR  PRODUCT_ID >25;   --> We use OR instead OF AND because there IS NOT such NUMBER which IS less than 20 and greater than 25 (Look at pics)


--2.Way : 

SELECT *
FROM CUSTOMERS_PRODUCTS cp 
WHERE PRODUCT_ID NOT BETWEEN 20 AND 25;  --> 20 and 25 are both EXCLUSIVE




--EXISTS Condition : EXISTS condition is used with Subquery.
--                   If the Subquery returns any record Outher Query will be executed
--                   If the Subquery does not return any record Outher will not be executed
--                   EXSITS can be used in SELECT, INSERT, UPDATE, and DELETE commands


CREATE TABLE customers_likes
(

product_id number(10),
customer_name varchar2(50),
liked_product varchar (50)


);

DROP TABLE CUSTOMERS_LIKES ;
DROP TABLE CUSTOMERS_PRODUCTS ;


INSERT INTO customers_likes VALUES (10,'Mark','Orange');
INSERT INTO customers_likes VALUES (50,'Mark','Pineapple');
INSERT INTO customers_likes VALUES (60,'John','Avocado');
INSERT INTO customers_likes VALUES (30,'Lary','Cherries');
INSERT INTO customers_likes VALUES (20,'Mark','Apple');
INSERT INTO customers_likes VALUES (10,'Adem','Orange');
INSERT INTO customers_likes VALUES (40,'John','Apricot');
INSERT INTO customers_likes VALUES (20,'Eddie','Apple');

SELECT * FROM CUSTOMERS_LIKES cl ;


--1) Select customer names if the product ids are same in customer product and customer likes table


SELECT product_id, customer_name
FROM CUSTOMERS_PRODUCTS cp 
WHERE EXISTS (SELECT PRODUCT_ID FROM CUSTOMERS_LIKES WHERE cp.PRODUCT_ID = customers_likes.product_id);


--2) Delete records if there is 'Orange' as product name in customers likes table

DELETE FROM  customers_likes
WHERE EXISTS (SELECT liked_product FROM CUSTOMERS_LIKES cl WHERE liked_product= 'Orange' );


--3) Update names to "NO name" if there is Lary among names in customers_likes

UPDATE customers_likes
SET CUSTOMER_NAME = 'NO name'
WHERE EXISTS (SELECT customer_name FROM CUSTOMERS_LIKES cl WHERE CUSTOMER_NAME = 'Lary');



--SUBQUERY (********) ---------------------------------------------------------


--SUBQUERY after WHERE Clause (***)


CREATE TABLE employees1
(

id number(9),
name varchar2(50),
state varchar (50),
salary number(20),
company varchar (20)

);

INSERT INTO employees1 VALUES (123456789,'John Walker','Florida', 2500, 'IBM');
INSERT INTO employees1 VALUES (234567890,'Brad Pitt','Florida', 1500, 'APPLE');
INSERT INTO employees1 VALUES (345678901,'Eddie Murphy','Texas', 3000, 'IBM');
INSERT INTO employees1 VALUES (456789012,'Eddie Murphy','Virginia', 1000, 'GOOGLE');
INSERT INTO employees1 VALUES (567890123,'Eddie Murphy','Texas', 7000, 'MICROSOFT');
INSERT INTO employees1 VALUES (456789012,'Brad Pitt','Texas', 1500, 'GOOGLE');
INSERT INTO employees1 VALUES (123456710,'Mark Stone','Pennsylvania', 2500, 'IBM');


SELECT * FROM EMPLOYEES1;


CREATE TABLE companies
(

company_id number(9),
company varchar2(20),
number_of_employees number(20)

);


INSERT INTO companies VALUES (100,'IBM',12000);
INSERT INTO companies VALUES (101,'GOOGLE',18000);
INSERT INTO companies VALUES (102,'MICROSOFT',10000);
INSERT INTO companies VALUES (103,'APPLE',21000);

SELECT * FROM companies;


--1) Find the employee and company names whose company has more than 15000 employess

SELECT name, company
FROM EMPLOYEES1 
WHERE company IN (SELECT company FROM COMPANIES WHERE companies.number_of_employees > 15000);


--2) Find the company ids and company names which are in Florida

SELECT company_id, company
FROM COMPANIES 
WHERE company IN (SELECT company FROM employees1 WHERE state = 'Florida');


--3) Find the employee name and state which has companies whose company ids are greater than 100

SELECT name,state 
FROM employees1 
WHERE company IN (SELECT company FROM companies WHERE company_id >100);  --> We are using company keyword in every question because it is comman collumn in two tables



--SUBQUERY after SELECT Clause (***) ---------------------------------------------------------



--4) Find the company name, number of employees and avarege salary for every company

SELECT  company, number_of_employees, (SELECT AVG(salary) 
                                       FROM EMPLOYEES1 
                                       WHERE companies.COMPANY = employees1.COMPANY) AS average_salary
FROM COMPANIES ;


--5) Find the name of the companies, company ids, maximum and minimum salaries per company

SELECT company, company_id, (SELECT MAX(salary) 
                             FROM employees1 
                             WHERE companies.COMPANY= employees1.COMPANY) 
                             AS max_salary , 
                            (SELECT min(salary) 
                             FROM employees1 
                             WHERE companies.COMPANY= employees1.COMPANY) 
                             AS min_salary
FROM COMPANIES;



--SUBQUERY after FROM Clause  (***) ---------------------------------------------------------



--6) Get the number of employees whose company id is 100 or 101
--Later




--LIKE Condition: It is used with WildCard  (***) ---------------------------------------------------------




--A) % Wildcard: It represents zero or more characters (***) 



--1) Select employee names which start with 'E';

SELECT name
FROM EMPLOYEES1 e 
WHERE name LIKE 'E%';


--2) Select employee names which end with 'e';

SELECT name 
FROM EMPLOYEES1 e 
WHERE name LIKE '%e';


--3) Select employee names which start with 'B', end with 't;

SELECT name
FROM EMPLOYEES1 e 
WHERE name LIKE 'B%t';


--4) Select employee names which has 'a', in any pozition

SELECT name 
FROM EMPLOYEES1 e 
WHERE name LIKE '%a%';


--5) Select employee names which has 'e' and 'r', in any pozition

SELECT name 
FROM EMPLOYEES1 e 
WHERE name LIKE '%e%r%' OR name LIKE '%r%e%' ;   --> IF we do NOT use "OR name LIKE '%r%e%'" we just GET names only which has 'e' FIRST than 'r'. 



--B) _ Wildcard: It represents single character (***)



--6) Select state whose second caharacter is 'e' and forth character is 'n';

SELECT state
FROM EMPLOYEES1 e 
WHERE state LIKE '_e_n%';


--7) Select state whose last second caharacter is 'i'

SELECT state
FROM EMPLOYEES1 e 
WHERE state LIKE '%i_';


--8) Select state whose second caharacter is 'e' and it has at least 6 characters

SELECT state
FROM EMPLOYEES1 e 
WHERE state LIKE '_e____%';


--9) Select state which has 'i' in any pozition after second character

SELECT state
FROM EMPLOYEES1 e 
WHERE state LIKE '__%i%';

DROP TABLE EMPLOYEES1 ;
DROP TABLE COMPANIES ;



--NOT LIKE Condition         (**********)


--1) Select words which do not have 'h' in any pozition

SELECT word
FROM WORDS w 
WHERE word NOT LIKE '%h%';


--2) Select words which do not end with 't' or 'f'

SELECT word
FROM WORDS w 
WHERE word NOT LIKE '%t' AND  word NOT LIKE '%f';    -- You should use AND instead OF OR ! (***)


--3) Select words which start with any character, not followed by 'a' and not followed by 'e'

SELECT word
FROM WORDS w 
WHERE word NOT LIKE '_a%' AND word NOT LIKE '_e%';



--REGEXP_LIKE Condition: You can use Regular Expression   (***) ---------------------------------------------------------


CREATE TABLE words 
(

  word_id number(10) UNIQUE,
  word varchar2(50) NOT NULL,
  number_of_letter number(6)
  
);


INSERT INTO words VALUES (1001,'hot',3);
INSERT INTO words VALUES (1002,'hat',3);
INSERT INTO words VALUES (1003,'hit',3);
INSERT INTO words VALUES (1004,'hbt',3);
INSERT INTO words VALUES (1008,'hct',3);
INSERT INTO words VALUES (1005,'adem',4);
INSERT INTO words VALUES (1006,'selena',6);
INSERT INTO words VALUES (1007,'yusuf',5);

SELECT * FROM WORDS ;


--1) Select words whose first character is 'h', last character is 't' and second character is 'o' or 'e' or 'i'


--1.Way: by using like not recomended because of repetition

SELECT word
FROM WORDS 
WHERE word LIKE 'ho%t' OR word LIKE 'he%t' OR word LIKE 'hi%t';


--2.Way: by using REGEXP_LIKE

SELECT word
FROM WORDS 
WHERE REGEXP_LIKE(word, 'h[oai]t');  --([]) ***


--2) Select words whose first character is 'h', last character is 't' and second character is from 'a' to 'e'

SELECT word
FROM WORDS w 
WHERE REGEXP_LIKE(word, 'h[a-e]t');   -- 'a' AND 'e' ARE inclusive  ([-]) ***


--3) Select words whose first character is 'a' or 's' or 'y'

SELECT word
FROM WORDS w 
WHERE REGEXP_LIKE(word, '^[asy]');    -- '^' means Startin value ***  

-- We can also use '^[asy](*)' (*) means same with '%' zero or multiple characters. It is optional (*****)


--4) Select words whose last character is 'a' or 'm' or 'f'

SELECT word
FROM WORDS w 
WHERE REGEXP_LIKE(word, '(*)[maf]$');    -- '$' means last value ***  


--5) Select words whose first character is 'a' and last character is 'a'

SELECT word
FROM WORDS w 
WHERE REGEXP_LIKE(word, '^s.*a$'); -- '.*' use FOR multiple OR zero CHARACTERS BETWEEN FIRST AND LAST CHARACTERS (******)


--6) Select words which have 'a' in any pozition


--1.Way:
SELECT word
FROM WORDS w 
WHERE REGEXP_LIKE(word, '(*)[a](*)');        -- '(*)a(*)' works also ***

--2.Way:
SELECT word
FROM WORDS w 
WHERE REGEXP_LIKE(word, 'a');    -- IN regexp_like USING ONLY one letter gets the words which has a IN ANY pozition


--7) Select words which have characters from 'd' to 't' at the begenning followed by and character then 'l'


--1.Way:
SELECT word
FROM WORDS w 
WHERE REGEXP_LIKE(word, '^[d-t].*l');

--2.Way:
SELECT word
FROM WORDS w 
WHERE REGEXP_LIKE(word, '^[d-t].[t]');   -- '.' in REGEXP_LIKE same WITH '_' en LIKE  (*****)


--7) Select words which have characters from 'd' to 't' at the begenning followed by ant two characters then 'e'


--1.Way:
SELECT word
FROM WORDS w 
WHERE REGEXP_LIKE(word, '^[d-t].*[e]');

--2.Way:
SELECT word
FROM WORDS w 
WHERE REGEXP_LIKE(word, '^[d-t]..[e]');




--ORDER BY: To put the records in ascending or descending order we use ORDER BY ---------------------------------------
--          Can be used just with select STATEMENT (*******)


--1) Put the records in ascending order by using number of letters

SELECT *
FROM WORDS w 
ORDER BY NUMBER_OF_LETTER  ASC   ; -- ASC IS optional, as default it is ascending 


--2) Put hte records in descending order by using words

SELECT *
FROM WORDS w 
ORDER BY WORD DESC ;  -- DESC IS NOT optional 


--NOTE: In ORDER BY, instead of field names, field numbers can be used as well (*******)

SELECT *
FROM WORDS w 
ORDER BY 3 ASC ; -- stands FOR number_of_letters (*******)


--3) Put hte records in descending order by using name field, and ascending order by using point field

CREATE TABLE points
(

name varchar2(50),
point number(3)

);

INSERT INTO points VALUES ('Ali', 25);
INSERT INTO points VALUES ('Veli', 37);
INSERT INTO points VALUES ('Kemal', 43);
INSERT INTO points VALUES ('Ali', 36);
INSERT INTO points VALUES ('Ali', 25);
INSERT INTO points VALUES ('Veli', 29);
INSERT INTO points VALUES ('Ali', 45);
INSERT INTO points VALUES ('Veli', 11);
INSERT INTO points VALUES ('Ali', 125);


SELECT *
FROM points
ORDER BY name DESC, point ASC;


--ALIASES, GROUP BY, HAVING, JOINS, ALTER TABLE



