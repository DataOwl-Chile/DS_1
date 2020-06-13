-- #######################################################################################
-- Pregunta 1
-- #######################################################################################

CREATE DATABASE "DS_1"
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Spanish_Chile.1252'
    LC_CTYPE = 'Spanish_Chile.1252'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
;

-- #######################################################################################
-- Pregunta 2
-- #######################################################################################

CREATE TABLE company(
   worker_id INT NOT NULL
   ,last_name TEXT NOT NULL
   ,first_name TEXT NOT NULL
   ,age INT NOT NULL
   ,department VARCHAR(50) NOT NULL
   ,salary INT NOT NULL

   , CONSTRAINT worker_pkey PRIMARY KEY (worker_id)
)
;

INSERT INTO company(worker_id, last_name, first_name, age, department, salary)
VALUES
	(12, 'Mallea', 'Patricio', 27, 'Systems', 600000)
    ,(13, 'Mallea', 'Valeska', 21, 'Finance', 600000)
;


-- #######################################################################################
-- Pregunta 3
-- #######################################################################################

CREATE TABLE titanic
(
    passengerid INT NOT NULL
	,survived VARCHAR(20)
	,pclass TEXT
	,last_name TEXT
	,first_name TEXT
	,sex varchar(6)
	,age INT
	,parch TEXT
	,ticket TEXT
	,cabin VARCHAR(30)
	,embarked VARCHAR(40)
    ,sibsp INT

	,CONSTRAINT persons_pkey PRIMARY KEY (passengerid)
)
;

-- #######################################################################################
-- Pregunta 4
-- #######################################################################################

SELECT passengerid, age, survived
FROM titanic
;

CREATE TEMPORARY TABLE survival AS
SELECT passengerid, age, survived
FROM titanic
;

-- #######################################################################################
-- Pregunta 5
-- #######################################################################################

SELECT COUNT(*) FROM survival
WHERE age IS NULL
;

SELECT * FROM survival
WHERE age > 60
LIMIT 5
;

-- #######################################################################################
-- Pregunta 6
-- #######################################################################################

SELECT *
	, CASE
		WHEN age > 60 THEN 'Adulto Mayor'
		WHEN age < 10 THEN 'Niño'
	END AS categoria
FROM survival
WHERE ((age > 60) OR (age < 10)) AND survived = '1'
;

-- #######################################################################################
-- Pregunta 7
-- #######################################################################################

SELECT passengerid, age, first_name, survived
FROM titanic
WHERE first_name LIKE '%William%' or first_name LIKE '%Hanna%'
ORDER BY age ASC
;

-- #######################################################################################
-- Pregunta 8
-- #######################################################################################

CREATE TEMPORARY TABLE anexo AS 
SELECT passengerid
    ,age
    ,survived
    ,CASE
        WHEN age < 10 THEN 'Niño o Niña'
        WHEN age < 30 THEN 'Joven'
        WHEN age < 65 THEN 'Adulto'
        WHEN age >=65 THEN 'Adulto Mayor'
        ELSE "Sin edad"
    END AS categoria
FROM titanic
;


SELECT categoria
	,COUNT(*)
	,AVG(age)
	,SUM(age)/COUNT(age)
	,MIN(age)
	,MAX(age)
FROM anexo
GROUP BY categoria
;

-- #######################################################################################
-- Pregunta 9
-- #######################################################################################

CREATE TEMPORARY TABLE tabla_final AS
SELECT categoria
	,COUNT(*) AS n_total
	,AVG(age) AS promedio_edad_1
	,SUM(age)/COUNT(age) AS promedio_edad_2
	,MIN(age) as menor
	,MAX(age) as mayor
FROM anexo
GROUP BY categoria


-- #######################################################################################
-- Pregunta 10
-- #######################################################################################