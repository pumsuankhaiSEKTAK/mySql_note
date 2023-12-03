JOIN 
- Inner Join or Join : matching values = matching records

e.g., SELECT 
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        JOIN
    departments_dup d ON m.dept_no = d.dept_no
GROUP BY m.emp_no
ORDER BY dept_no;

set @@global.sql_mode := replace(@@global.sql_mode, 'ONLY_FULL_GROUP_BY', '');

it means that the 'ONLY_FULL_GROUP_BY' setting was not present in the sql_mode to begin with, or it was successfully removed.


- Left JOIN
