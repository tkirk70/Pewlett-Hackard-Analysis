-- Deliverable #1 Returns 33,118 rows

SELECT  e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
INTO new_table
FROM employees AS e
INNER JOIN titles AS t
ON t.emp_no = e.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND t.to_date = ('9999-01-01')
ORDER BY e.emp_no;

SELECT COUNT(title)
FROM new_table;

DROP TABLE new_table;
