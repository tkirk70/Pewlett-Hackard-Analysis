-- 7.3.6 Create a Tailored List
-- 7.3.6 Create a Tailored List

SELECT * FROM public.retirement_info;

SELECT * FROM public.current_emp;

SELECT ri.emp_no, first_name, last_name, dept_name
INTO sales_retirees
FROM retirement_info as ri
JOIN dept_emp as de
ON ri.emp_no = de.emp_no
JOIN departments as d
ON d.dept_no = de.dept_no
WHERE dept_name = 'Sales';

SELECT * FROM sales_retirees;

SELECT ri.emp_no, first_name, last_name, dept_name
INTO development_retirees
from retirement_info as ri
JOIN dept_emp as de
ON ri.emp_no = de.emp_no
JOIN departments as d
ON d.dept_no = de.dept_no
WHERE dept_name = 'Development';

SELECT * FROM development_retirees;

-- Combined Sales and Development
SELECT ri.emp_no, first_name, last_name, dept_name
INTO combined_sd
from retirement_info as ri
JOIN dept_emp as de
ON ri.emp_no = de.emp_no
JOIN departments as d
ON d.dept_no = de.dept_no
WHERE dept_name IN ('Sales','Development');

SELECT * FROM combined_sd;
