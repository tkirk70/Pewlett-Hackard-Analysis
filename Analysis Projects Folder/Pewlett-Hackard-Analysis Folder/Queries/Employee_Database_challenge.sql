-- Module 7 Challenge - Deliverable #1

SELECT  e.emp_no, e.first_name, e.last_name, t.title, t.from_date, t.to_date
INTO retirement_titles
FROM employees AS e
INNER JOIN titles AS t
ON t.emp_no = e.emp_no
WHERE e.birth_date BETWEEN '1952-01-01' AND '1955-12-31'
ORDER BY e.emp_no;

-- Copy/paste Employee_Challenge_starter_code.sql

-- Use Dictinct ON() with Order By to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
  first_name,
  last_name,
  title
INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;

-- Count potential retirees and groub by title.
SELECT count(title), title
INTO retiring_titles
FROM public.unique_titles
GROUP BY title
ORDER BY count(title) DESC;

-- Deliverable #2
-- Create a mentorship-eligibility table that holds the current employees who
-- were born between January 1, 1965 and December 31, 1965.
SELECT DISTINCT ON (e.emp_no) e.emp_no, e.first_name, e.last_name,
  e.birth_date, de.from_date, de.to_date, t.title
INTO mentorship_eligibility
FROM employees AS e
JOIN dept_emp AS de
ON e.emp_no = de.emp_no
JOIN titles AS t
ON t.emp_no = e.emp_no
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND de.to_date = '9999-01-01'
ORDER BY e.emp_no;


-- Deliverable #3
-- Current employees versus soon_to_retire and percent_leaving
SELECT COUNT(de.emp_no) AS current_employees, COUNT(u.emp_no) AS soon_to_retire,
ROUND(COUNT(u.title) * 100.0/COUNT(de.emp_no), 2) AS percent_leaving
FROM unique_titles u
FULL OUTER JOIN dept_emp de
ON u.emp_no = de.emp_no
WHERE to_date = '9999-01-01';

-- Figure out how many mentors will be available for potential new hires.
SELECT COUNT(u.emp_no) AS soon_to_retire, COUNT(me.emp_no) AS mentors,
ROUND(COUNT(u.emp_no) * 1.0/COUNT(me.emp_no), 2) AS mentee_per_mentor
FROM unique_titles u
FULL OUTER JOIN mentorship_eligibility me
ON u.emp_no = me.emp_no;

-- Figure out the ages of potential retirees.
SELECT *, DATE_PART('year', '2022-01-10'::date) - DATE_PART('year', e.birth_date::date) AS age
FROM employees e
JOIN unique_titles u
ON u.emp_no = e.emp_no;

-- Avg age - How to work with ROUND and Double Precision?
SELECT COUNT(u.emp_no) AS retirees,
	AVG(DATE_PART('year', NOW()::date) -
	DATE_PART('year', e.birth_date::date)) AS avg_age
FROM employees e
JOIN unique_titles u
ON u.emp_no = e.emp_no;

-- Avg Age of Remaining employees
SELECT COUNT(DISTINCT(t.emp_no))
AS remaining_employees,
AVG(DATE_PART('year', NOW()::date) -
	DATE_PART('year', e.birth_date::date))
AS avg_age
FROM titles t
JOIN employees e
ON e.emp_no = t.emp_no
WHERE e.birth_date > '1955-12-31'
AND t.to_date = '9999-01-01';

-- Salaries (retiring)
SELECT count(*) AS number_retirees, ROUND(AVG(s.salary), 2) AS average_salary
FROM salaries s
JOIN public.unique_titles u
ON u.emp_no = s.emp_no;

-- Salaries total
SELECT COUNT(*) AS current_employees, ROUND(AVG(s.salary), 2)
AS average_salary
FROM dept_emp de
JOIN salaries s
ON s.emp_no = de.emp_no
WHERE de.to_date = '9999-01-01';

-- Average Salary of Remaining Employee_Challenge_starter_codeSELECT COUNT(*) AS remaining_employees, ROUND(AVG(s.salary), 2)
AS average_salary
FROM public.remaining_emp re
JOIN salaries s
ON s.emp_no = re.emp_no
WHERE re.to_date = '9999-01-01';
