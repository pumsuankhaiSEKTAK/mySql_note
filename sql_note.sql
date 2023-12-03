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
