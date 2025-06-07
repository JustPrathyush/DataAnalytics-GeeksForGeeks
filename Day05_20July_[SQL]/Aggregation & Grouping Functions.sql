Use geeksforgeeks_db

SHOW TABLES

SELECT * FROM courses
SELECT * FROM employees
SELECT * FROM learners

-- Give me the total number of employees working in GFG ??
SELECT COUNT(*) AS total_emp 
FROM employees

-- How many different sources of joining [nums] by the learners ??
SELECT COUNT(DISTINCT source_of_joining) AS diff_source_of_joining
FROM learners

-- How many number of learners have joined the courses in the month of july?
INSERT INTO learners(first_name, last_name, email, phone, enrollment_date, selected_course, years_of_exp, company_name, source_of_joining, location, batch_start_date) 
VALUES ("Swati", "Sinha", "swati@gmail.com", '9911234567', '2024-08-1', 2, 3, 'Amazon', 'YouTube', 'Noida', '2024-08-05');

INSERT INTO learners(first_name, last_name, email, phone, enrollment_date, selected_course, years_of_exp, company_name, source_of_joining, location, batch_start_date) 
VALUES ("Devpriya", "Nath", "devpriya@gmail.com", '9911234567', '2024-08-3', 3, 3, 'Amazon', 'YouTube', 'Noida', '2024-08-05');

-- YEAR - MONTH - DAY [timestamp (format)]
-- How many number of learners have joined the courses in the month of july?

SELECT COUNT(*) as num_learners_enrolled_july FROM learners 
WHERE enrollment_date LIKE '%-07-%'

-- How many number of learners have joined the courses in the year 2024?
SELECT COUNT(*) as joined_in_2024 FROM learners 
WHERE enrollment_date LIKE '2024-%-%'


-- Grouping: For any specific column, if you want to specify the unique set of values and want to do aggregation on top of that
-- That is where the need of grouping comes into picture
-- How many learners enrolled via unique source of joining?
-- Insights: Which specific medium in future I need to focus more on for the advertisement purpose
/*
	source_of_joining		number_learners_enrolled
    LinkedIn				3
    YouTube					3
    Insta Ads				1
*/

DESC learners

SELECT source_of_joining, COUNT(*) as number_learners_enrolled
FROM learners
GROUP BY source_of_joining

-- IMPORTANT POINT: Non-aggregated columns after SELECT command you have to use after GROUP BY clause.

SELECT * FROM learners
SELECT * FROM courses

-- How many students have enrolled in each course?
/*
	selected_course		num_students_enrolled
	1					2
    2					2
    3					2
    5					1
*/


SELECT selected_course, COUNT(*) as num_students_enrolled
FROM learners
GROUP BY selected_course

-- Corresponding to each location, what is the average years of experience learner holds?
/*
		location		avg_years_of_exp
        Bengaluru		2.0000
        Noida 			3.0000
        Hyderabad		5.0000
*/

SELECT location, AVG(years_of_exp) as avg_years_of_exp
FROM learners
GROUP BY location


-- Corresponding to each source_of_joining, what is the max experience any learner holds?
/*
	source_of_joining		max_years_exp
    LinkedIn				2
    YouTube					3
    Insta Ads				5
*/


SELECT source_of_joining, MAX(years_of_exp) as max_years_exp
FROM learners
GROUP BY source_of_joining


--  Logical Operations in SQL --> Multiple Conditions
-- AND (all the conditions to be satisfied) 
-- OR (any one of the condition to be satisified)
-- NOT (reverse the results)

-- Display the firstName and lastName of those learners whose source_of_joining is LinkedIn and the location is Bengaluru
SELECT first_name, last_name 
FROM learners
WHERE source_of_joining = 'LinkedIn' AND location = 'Bengaluru'
 

-- Display the firstName and lastName of those learners whose source_of_joining is LinkedIn or the location is Hyderabad
SELECT first_name, last_name 
FROM learners
WHERE source_of_joining = 'LinkedIn' OR location = 'Hyderabad'

-- Display the firstName and lastName of those learners who does not have the years of experience between 1 to 3
SELECT first_name, last_name FROM learners
WHERE years_of_exp NOT BETWEEN 1 and 3

-- Display the courseName apart from 'DSA'
SELECT course_name FROM courses
WHERE course_name NOT LIKE 'DSA'


-- Corresponding to "Noida" location, what is the average years of experience learner holds?
/*
		location		avg_years_of_exp
        Bengaluru		2.0000
        Noida 			3.0000
        Hyderabad		5.0000
*/

-- HAVING CLAUSE: It also serves the purpose of filteration after GROUP BY
-- IMPORTANT NOTE: If you want to do the filteration before GROUP BY (WHERE)
-- If you want to do the filteration after GROUP BY (HAVING)

-- Approach 1
SELECT location, AVG(years_of_exp) as avg_years_of_exp
FROM learners
GROUP BY location
HAVING location = 'Noida'

-- Approach 2
SELECT location, AVG(years_of_exp) as avg_years_of_exp
FROM learners
WHERE location = 'Noida'
GROUP BY location













