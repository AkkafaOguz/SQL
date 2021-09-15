--How to create table
--We do not use camelCase because SQL makes all variable names Big. That's why we use "_"
--1.Way: Create table frim strach

CREATE TABLE students
(

    student_id char (3),
    student_name varchar (50),
    student_age number(2),
    student_dob date
  

);

--2.Way: Create table by using another table 

CREATE TABLE student_name_age 
AS SELECT student_name, student_age
FROM STUDENTS s ;


SELECT * FROM students;
SELECT * FROM student_name_age;

--While we create a table, we can put some "Constraints" for fields

CREATE TABLE students
(

    student_id char (3) UNIQUE , --student_id IS UNIQUE KEY ==> DATA different FROM NULL must be UNIQUE, you can have multiple NULL 
    student_name varchar (50) NOT NULL , --studen_name will NOT have NULL AS DATA.
    student_age number(2),
    student_dob date
  

);

--If you put some conditions for fields they are constraints. (Interview Question)
--Constraints: 
--a)Unique
--b)not null
--c)primary key
--d)foreing key 
--e)check constraint

--Two ways to create primary key

--1.Way to create


CREATE TABLE students
(

    student_id char (3) PRIMARY KEY,  -- student_id can NOT have repeated DATA and NULL value because it IS PRIMARY KEY 
    student_name varchar (50) NOT NULL , --studen_name will NOT have NULL AS DATA.
    student_age number(2) ,
    student_dob DATE UNIQUE --student_dob IS UNIQUE KEY ==> DATA different FROM NULL must be UNIQUE, you can have multiple NULL
  

);

--2.Way to create

CREATE TABLE students
(

    student_id char (3),
    student_name varchar (50),
    student_age number(2)  ,
    student_dob DATE,
    CONSTRAINT student_id_pk PRIMARY KEY (student_id)  -- Most OF the times we prefer TO use SECOND way because BY doing that we can name our primary KEY 
  
);




CREATE TABLE parents 
(

   student_id char (3),
   parent_name varchar2 (50),
   phone_number char(10),
   CONSTRAINT student_id_pk PRIMARY KEY (student_id)

);

--How to add foreing key constraint 

CREATE TABLE students
(

    student_id char (3),
    student_name varchar2(50),
    student_age number(2)  ,
    student_dob DATE,
    CONSTRAINT student_id_fk FOREIGN KEY (student_id) REFERENCES parents(student_id)  --Foreing KEY IS the END OF the bridge, WITHOUT PRIMARY KEY we can NOT use foreing key
     																				  --There is only one way to create foreing key 	
  
);


--How to add "Check" constraint 


CREATE TABLE students
(

    student_id char (3),
    student_name varchar (50),
    student_age number(2),
    student_dob DATE,
    CONSTRAINT student_age_check CHECK (student_age BETWEEN 0 AND 30) --"CONSTRAINT student_age_check " kismi omadan da kullanilir. Bu kismi isim vermek icin kullandik
  
);



CREATE TABLE students
(

    student_id char (3),
    student_name varchar (50),
    student_age number(2) CHECK (studentage BETWEEN 0 AND 30),   --2.Way TO use CHECK CONSTRAINT 
    student_dob DATE
  
  
);

--Adding more than one check constraints

CREATE TABLE students
(

    student_id char (3),
    student_name varchar (50),
    student_age number(2),
    student_dob DATE,
    CONSTRAINT student_age_check CHECK (student_age BETWEEN 0 AND 30), --"CONSTRAINT student_age_check " kismi omadan da kullanilir. Bu kismi isim vermek icin kullandik
    CONSTRAINT student_name_upper_case CHECK (student_name = upper(student_name))
);

DROP TABLE STUDENTS ;


--How to Insert Data into a table

CREATE TABLE students
(

    student_id char (3) PRIMARY KEY ,
    student_name varchar (50) UNIQUE ,
    student_age number(2) NOT NULL ,
    student_dob DATE,
    CONSTRAINT student_age_check CHECK (student_age BETWEEN 0 AND 30), --"CONSTRAINT student_age_check " kismi omadan da kullanilir. Bu kismi isim vermek icin kullandik 0 AND 30 included 
    CONSTRAINT student_name_upper_case CHECK (student_name = upper(student_name))
);

--1.Way: Insert data for all fields

INSERT INTO students VALUES('101','ALI CAN',13,'08-09-2021');  -- ORDER IS important -- It IS CREATE operation (DML(DATA MANUPULATION LANGUAGE))
INSERT INTO students VALUES('102','ALI CAN',14,'08-09-2007'); --ORA-00001: unique constraint (HR.SYS_C007101) violated
INSERT INTO students VALUES('102','VELI CAN',14,'08-09-2007');
INSERT INTO students VALUES(NULL,'AYSE TAN',14,'10-09-2007'); --ORA-01400: cannot insert NULL into ("HR"."STUDENTS"."STUDENT_ID")
INSERT INTO students VALUES(103,'AYSE TAN',14,'10-09-2007'); --FOR char we use single quotes '' but IF you do NOT use it works AS well
INSERT INTO students VALUES(104,'KEMAL KUZU',15,null);
INSERT INTO students VALUES('105','TOM HANKS',25,'12-09-1985');--FOR VARCHAr YOU HAVE TO USE SINGLE QUOTE ''
INSERT INTO students VALUES('106','ANGELINA JULIE',30,'12-09-1985'); --ORA-02290: check constraint (HR.STUDENT_AGE_CHECK) violated
INSERT INTO students VALUES('107','BRAD PITT',0,'12-09-1985'); 

SELECT * FROM STUDENTS s ; --(DQL - Data Query Language)


--2.Way: How to insert data for specific fields

INSERT INTO STUDENTS (student_id, student_age) VALUES ('108',17);
INSERT INTO STUDENTS (student_name, student_age) VALUES ('JOHN WALKER',17); -- ORA-01400: cannot insert NULL into ("HR"."STUDENTS"."STUDENT_ID")
INSERT INTO STUDENTS (student_id, student_name) VALUES ('JOHN WALKER',109); -- ORDER IS important !
INSERT INTO STUDENTS (student_name, student_id,student_age) VALUES ('JOHN WALKER','109',24); -- ORA-01400: cannot insert NULL into ("HR"."STUDENTS"."STUDENT_AGE")

--How to update existing data

UPDATE students 
SET STUDENT_NAME = 'LEO OCEAN'
WHERE STUDENT_ID = '108';         --FROM BIGGEST TO THE SMALLEST PART (TABLE -> COLUMN -> VARABILE)

--Update the dob of Jhon Walker to 10-11-1997

UPDATE STUDENTS 
SET STUDENT_DOB = '10-11-1997'
WHERE STUDENT_NAME = 'JOHN WALKER';

--Update the dob of 105 11-06-1996 and name to TOM HANKS (HOW TO UPDATE MULTIPLE CELL)
UPDATE STUDENTS 
SET STUDENT_NAME = 'TOM HANKS',
    STUDENT_DOB  = '11-06-1996'
WHERE STUDENT_ID = '105'  ;

--HOW TO UPDATE MULTIPLE RECORDS

--Make the names of all students ****** if their ids are less than 106
UPDATE STUDENTS 
SET STUDENT_NAME = '******'
WHERE STUDENT_ID < '106';  -- ORA-00001: unique constraint (HR.SYS_C007101) violated


--Make the dob of all students ****** if their ids are less than 106
UPDATE STUDENTS 
SET STUDENT_DOB = '******'
WHERE STUDENT_ID < '106';  -- ORA-01858: a non-numeric character was found where a numeric was expected


--Make the dob of all students 01-06-2021 if their ids are less than 106
UPDATE STUDENTS 
SET STUDENT_DOB = '01-06-2021'
WHERE STUDENT_ID < '106'; 


--Update all students age to the maximum age
UPDATE STUDENTS 
SET STUDENT_AGE = (SELECT max(STUDENT_AGE) FROM STUDENTS s ); --NO need TO use WHERE keyword because we want TO UPDATE ALL records 


--update all students' dob to the minimum dob
UPDATE STUDENTS 
SET STUDENT_DOB = (SELECT min(STUDENT_DOB) FROM STUDENTS s );


SELECT * FROM STUDENTS s ; --(DQL - Data Query Language)








