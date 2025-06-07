use geeksforgeeks_db

show tables

select * from courses 

-- As per the courseFee, we need to categorize the courses as Expensive, Moderate or Cheap
-- If courseFee > 20000 -> Expensive, courseFee > 13000 -> Moderate, otherwise it's a cheap course
SELECT course_id, course_name, course_fee,
CASE
WHEN course_fee > 20000 THEN 'Expensive'
WHEN course_fee > 13000 THEN 'Moderate'
ELSE 'Cheap' 
END as FeeType
FROM courses

-- CASE Expressions in SQL()
SELECT course_id, course_name, course_fee,
CASE course_fee
WHEN 25000 THEN 'Expensive'
WHEN 20000 THEN 'Moderate'
ELSE 'Cheap' 
END as FeeType
FROM courses