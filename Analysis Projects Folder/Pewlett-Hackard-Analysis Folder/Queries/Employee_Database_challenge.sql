-- Module 7 Challenge - Deliverable #1

SELECT  e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
INTO retirement_titles
FROM employees AS e
INNER JOIN titles AS t
ON t.emp_no = e.emp_no
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
-- AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
-- AND t.to_date = ('9999-01-01')
ORDER BY e.emp_no;

-- Copy/paste Employee_Challenge_starter_code.sql

-- Use Dictinct with Order By to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
  first_name,
  last_name,
  title
INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;

SELECT count(title), title
INTO retiring_titles
FROM public.unique_titles
GROUP BY title
ORDER BY count(title) DESC;

-- Deliverable #2
SELECT DISTINCT ON (e.emp_no) e.emp_no, e.first_name, e.last_name, e.birth_date, de.from_date, de.to_date, t.title
INTO mentorship_eligibility
FROM employees AS e
JOIN dept_emp AS de
ON e.emp_no = de.emp_no
JOIN titles AS t
ON t.emp_no = e.emp_no
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND de.to_date = '9999-01-01'
ORDER BY e.emp_no;
