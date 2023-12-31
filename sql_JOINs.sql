--JOIN 
-- Inner Join or Join : matching values = matching records

--e.g., 
SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        JOIN
    departments_dup d ON m.dept_no = d.dept_no
GROUP BY m.emp_no
ORDER BY dept_no;

set @@global.sql_mode := replace(@@global.sql_mode, 'ONLY_FULL_GROUP_BY', '');

---it means that the 'ONLY_FULL_GROUP_BY' setting was not present in the sql_mode to begin with, or it was successfully removed.


-- Left JOIN or LEFT OUTER JOIN
--- The LEFT JOIN keyword returns all records from the left table (table1), and the matching records from the right table (table2). The result is 0 records from the right side, if there is no match.
--- Right JOIN or Right OUTER JOIN is an invert of LEFT JOIN
--- LEFT and RIGHT joins are perfect examples of one-to-many realationships
e.g.2,
SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        LEFT JOIN
    departments_dup d ON m.dept_no = d.dept_no
WHERE
    dept_name IS NOT NULL
ORDER BY dept_no;

--- old type of join
SELECT 
    e.emp_no, e.first_name, e.last_name, d.dept_no
FROM
    employees e,
    dept_manager d
WHERE
    e.emp_no = d.emp_no;

--e.g.2,
SELECT 
    e.emp_no, 
    e.first_name, 
    e.last_name, 
    d.dept_no, 
    d.from_date
FROM
    employees e
        LEFT JOIN
    dept_manager d ON e.emp_no = d.emp_no
WHERE
    e.last_name = 'Markovitch'
ORDER BY d.dept_no DESC, e.emp_no;


---JOIN plus WHERE clause
--- e.g., 
SELECT 
    e.emp_no, 
    e.first_name, 
    e.last_name, 
    s.salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
WHERE
s.salary > 145000


--- CROSS JOIN
--- a cross join will take the values from a certain table and connect them with all the values from the tables we want to join it with
--- INNER JOIN typically connects only the matching value

--- CROSS JOIN 
--connects all the values, not just those that match
--the cartesian product of the value of two or more sets
--particularly useful when the tables in a database are not well connected
--e.g., 
SELECT 
    dm.*, d.*
FROM
    dept_manager dm
        CROSS JOIN
    departments d
ORDER BY dm.emp_no , d.dept_no;


-- e.g., 
SELECT 
    dm.*, d.*
FROM
    departments d
        CROSS JOIN
    dept_manager dm
WHERE
    d.dept_no <> dm.dept_no
ORDER BY dm.emp_no , d.dept_no;


e.g., 
SELECT 
    e.*, d.*
FROM
    departments d
        CROSS JOIN
    dept_manager dm
    JOIN
    employees e ON dm.emp_no = e.emp_no
WHERE
    d.dept_no <> dm.dept_no
ORDER BY dm.emp_no , d.dept_no;

---Using Aggregate Function with Joins
--- Aggregate Function always use with GROUP BY clause
--e.g.,
SELECT 
    e.gender, AVG(s.salary) AS average_salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
GROUP BY e.gender;


--e.g.,
SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    m.from_date,
    d.dept_name
FROM
    departments d
        JOIN
    dept_manager m ON d.dept_no = m.dept_no
        JOIN
    employees e ON m.emp_no = e.emp_no;


--e.g.,
SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    t.title,
    dm.from_date,
    d.dept_name
FROM
    employees e
        JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
        JOIN
    departments d ON dm.dept_no = d.dept_no
        JOIN
    titles t ON e.emp_no = t.emp_no
WHERE
    t.title = 'Manager'
ORDER BY e.emp_no;

--e.g., 2 solutions
SELECT 
    e.first_name,
    e.last_name,
    e.hire_date,
    t.title,
    dm.from_date,
    d.dept_name
FROM
    employees e
        JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
        JOIN
    departments d ON dm.dept_no = d.dept_no
        JOIN
    titles t ON e.emp_no = t.emp_no AND dm.from_date = t.from_date
WHERE
    t.title = 'Manager'
ORDER BY e.emp_no;


-- Tips and tricks for joins
SELECT 
    d.dept_name, AVG(salary) AS average_salary
FROM
    departments d
        JOIN
    dept_manager m ON d.dept_no = m.dept_no
        JOIN
    salaries s ON m.emp_no = s.emp_no
GROUP BY d.dept_name
HAVING average_salary > 60000
ORDER BY average_salary DESC;


---e.g.,
SELECT 
    e.gender, COUNT(m.dept_no) AS number_of_employees
FROM
    employees e
        JOIN
    dept_manager m ON e.emp_no = m.emp_no
GROUP BY e.gender;

--- UNION vs UNION ALL: used to combine a few SELECT statements in a single output
---create and insert duplicate table 
DROP TABLE IF EXISTS employees_dup;

CREATE TABLE employees_dup (
    emp_no INT(11),
    birth_date DATE,
    first_name VARCHAR(14),
    last_name VARCHAR(16),
    gender ENUM('M', 'F'),
    hire_date DATE
);

insert into employees_dup
select e.* 
from employees e 
LIMIT 20;

---Union example
SELECT 
e.emp_no,
e.first_name,
e.last_name,
NULL AS dept_no,
NULL AS from_date
from
employees_dup e
Where 
e.emp_no = 10001
UNION SELECT
NULL AS emp_no,
NULL AS first_name,
NULL AS last_name,
m.dept_no,
m.from_date
From
dept_manager m; 

---UNION vs UNION ALL
-- UNIONs displays only distinct values in the output
-- UNION ALL retrieves the duplicates as well
SELECT 
    *
FROM
    (SELECT 
        e.emp_no,
            e.first_name,
            e.last_name,
            NULL AS dept_no,
            NULL AS from_date
    FROM
        employees e
    WHERE
        last_name = 'Denis' UNION SELECT 
        NULL AS emp_no,
            NULL AS first_name,
            NULL AS last_name,
            dm.dept_no,
            dm.from_date
    FROM
        dept_manager dm) AS a
ORDER BY - a.emp_no DESC;







