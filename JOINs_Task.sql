#############################                #############################
#############################    JOINS       #############################
#############################                #############################
                            ##################

###################################### Task 1 ######################################

/* Extract a list containing information about all managers' employee number,
first and last name, department number, and hire date. */

SELECT
    e.emp_no, e.first_name, e.last_name, d.dept_no, e.hire_date
FROM
    employees e
        INNER JOIN
    dept_manager d ON e.emp_no = d.emp_no
ORDER BY e.emp_no;

###################################### Task 2 ######################################

-- inner join
-- to handle the duplicate values we need to use GROUP by

# in case code gives error uncomment code block below and run
# SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

SELECT
    m.dept_no, m.emp_no, d.dept_name
FROM
    dept_manager_dup m
        INNER JOIN
    departments d ON m.dept_no = d.dept_no
GROUP BY m.emp_no
ORDER BY dept_no;

###################################### Task 3 ######################################

/*
Join the 'employees' and the 'dept_manager' tables to return a subset of all the
employees whose last name is Markovitch. See if the output contains a manager with that name.

Hint: Create an output containing information corresponding to the following fields:
 "emp_no", "first_name", "last_name", "dept_no", "from_date". Order by 'dept_no' descending, and then by 'emp_no'.
*/

SELECT
    e.emp_no, e.first_name, e.last_name, d.dept_no, d.from_date
FROM
    employees e
        LEFT JOIN
    dept_manager d ON e.emp_no = d.emp_no
WHERE
        e.last_name = 'Markovitch'
ORDER BY d.dept_no DESC , e.emp_no;

###################################### Task 4 ######################################

/*
Extract a list containing information about all managers' employee number,
first and last name, department number, and hire date. Use the old type of
join syntax to obtain the result.
*/

# OLD JOINS
SELECT
    e.emp_no, e.first_name, e.last_name, d.dept_no, e.hire_date
FROM
    employees e,
    dept_manager d
WHERE
        e.emp_no = d.emp_no
ORDER BY dept_no;

# NEW JOINS
SELECT
    e.emp_no, e.first_name, e.last_name, d.dept_no, e.hire_date
FROM
    employees e
        INNER JOIN
    dept_manager d ON e.emp_no = d.emp_no
ORDER BY dept_no;

###################################### Task 5 ######################################

/*
Select the first and last name, the hire date, and the job title of all employees
 whose first name is "Margareta" and have the last name "Markovitch".
*/

select e.first_name, e.last_name, e.hire_date, t.title
from employees e
         JOIN titles t on e.emp_no = t.emp_no
where e.first_name = 'Margareta' and e.last_name = 'Markovitch';

/*

###################################### Task 6 ######################################

Use a CROSS JOIN to return a list with all possible combinations
between managers from the dept_manager table and department number 9.

*/

SELECT
    dm.*, d.*
FROM
    dept_manager_dup dm
        CROSS JOIN
    departments d
WHERE
        d.dept_no = 'd009'
ORDER BY d.dept_no;



/*

###################################### Task 7 ######################################

Return a list with the first 10 employees with all the departments they can be assigned to.
Hint: Don’t use LIMIT; use a WHERE clause.
*/

SELECT
    e.*, d.*
FROM
    employees e
        CROSS JOIN
    departments d
WHERE
        e.emp_no < 10011
ORDER BY e.emp_no , d.dept_name;

# average salaries of Male and Female
SELECT
    e.gender, AVG(s.salary) AS average_salary
FROM
    employees e
        JOIN
    salaries s ON e.emp_no = s.emp_no
GROUP BY e.gender;


# Average salary of departments
SELECT
    dm.dept_no, d.dept_name, AVG(s.salary) AS average_salary
FROM
    dept_manager dm
        JOIN
    departments d ON dm.dept_no = d.dept_no
        JOIN
    salaries s ON dm.emp_no = s.emp_no
GROUP BY d.dept_no
order by average_salary desc;

###################################### Task 8 ######################################

/*

Select all managers' first and last name, hire date, job title, start date, and department name.

*/

select
    e.first_name,
    e.last_name,
    e.hire_date,
    t.title,
    dm.from_date,
    d.dept_name

from employees e
         JOIN
     titles t on e.emp_no = t.emp_no
         JOIN
     dept_manager dm on e.emp_no = dm.emp_no
         JOIN
     departments d on d.dept_no = dm.dept_no
where t.title = 'Manager'
ORDER BY e.emp_no;

###################################### Task 9 ######################################

SELECT
    d.dept_name, AVG(salary) AS Average_salary
FROM
    departments d
        JOIN
    dept_manager dm ON d.dept_no = dm.dept_no
        JOIN
    salaries s ON dm.emp_no = s.emp_no
GROUP BY d.dept_name
HAVING Average_salary > 60000
ORDER BY Average_salary DESC;

###################################### Task 10 ######################################

/*
How many male and how many female managers do we have in the "employees" database?
*/
SELECT
    e.gender, COUNT(dm.emp_no)
FROM
    employees e
        JOIN
    dept_manager dm ON e.emp_no = dm.emp_no
GROUP BY gender;









