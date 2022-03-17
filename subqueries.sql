#############################                #############################
#############################   SUBQUERIES   #############################
#############################                #############################
                            ##################


###################################### Task 1 ######################################

/*
Select first and lastname from the table 'employees' for the same employee numbers that
can be found in the 'Department Manager' table
*/

select e.first_name, e.last_name
from employees e
where e.emp_no in (select
                     dm.emp_no
                from
                     dept_manager dm
);

###################################### Task 2 ######################################

/*
Extract the information about all department managers who were hired between
the 1st of January 1990 and the 1st of January 1995.
*/

SELECT * FROM
dept_manager
WHERE
emp_no IN (SELECT
                emp_no
             FROM
                employees
            WHERE
                hire_date BETWEEN '1990-01-01' AND '1995-01-01');


###################################### Task 3 ######################################
/*
Select the entire information for all employees whose job title is "Assistant Engineer".

Hint: To solve this exercise, use the 'employees' table.
*/

select * from employees e
where EXISTS (
    select * from titles t
    where t.emp_no = e.emp_no and title='Assistant Engineer')  ;

###################################### Task 4 ######################################

/*
Assign employee number 110022 as a manager to all employees from 10001 to 10020,

and employee number 110039 as a manager to all employees from 10021 to 10040.
*/

select A.* from
    (select e.emp_no as employee_ID,
           MIN(de.dept_no) as department_code,
           (select emp_no from dept_manager where emp_no = 110022) as manager_ID
    from employees e
    join dept_emp de on e.emp_no = de.emp_no
    where e.emp_no <= 10020
    group by e.emp_no
    order by e.emp_no) as A

UNION

select B.* from
    (select e.emp_no as employee_ID,
            MIN(de.dept_no) as department_code,
            (select emp_no from dept_manager where emp_no = 110039) as manager_ID
     from employees e
              join dept_emp de on e.emp_no = de.emp_no
     where e.emp_no > 10020
     group by e.emp_no
     order by e.emp_no
     limit 20) as B;

###################################### Task 5 ######################################

/*
Starting your code with “DROP TABLE”, create a table called “emp_manager” \
(emp_no – integer of 11, not null; dept_no – CHAR of 4, null; manager_no – integer of 11, not null).
*/

DROP TABLE  IF EXISTS emp_manager;

create table emp_manager (
    emp_no int(11) not null ,
    dept_no char(4) null,
    manager_no int(11) not null
);

###################################### Task 6 ######################################

/*
Fill emp_manager with data about employees, the number of the department they are working in, and their managers.

Your query skeleton must be:

Insert INTO emp_manager SELECT
U.*
FROM
                 (A)
UNION (B) UNION (C) UNION (D) AS U;

A and B should be the same subsets used in the last lecture
(SQL Subqueries Nested in SELECT and FROM). In other words,
assign employee number 110022 as a manager to all employees
from 10001 to 10020 (this must be subset A), and employee
number 110039 as a manager to all employees from 10021 to
10040 (this must be subset B).

Use the structure of subset A to create subset C,
where you must assign employee number 110039 as a manager to employee 110022.

Following the same logic, create subset D. Here you must
do the opposite - assign employee 110022 as a manager to employee 110039.

Your output must contain 42 rows.
*/

INSERT INTO emp_manager
SELECT
    u.*
FROM
    (SELECT
         a.*
     FROM
         (SELECT
              e.emp_no AS employee_ID,
              MIN(de.dept_no) AS department_code,
              (SELECT
                   emp_no
               FROM
                   dept_manager
               WHERE
                       emp_no = 110022) AS manager_ID
          FROM
              employees e
                  JOIN dept_emp de ON e.emp_no = de.emp_no
          WHERE
                  e.emp_no <= 10020
          GROUP BY e.emp_no
          ORDER BY e.emp_no) AS a UNION
    SELECT
         b.*
     FROM
         (SELECT
              e.emp_no AS employee_ID,
              MIN(de.dept_no) AS department_code,
              (SELECT
                   emp_no
               FROM
                   dept_manager
               WHERE
                       emp_no = 110039) AS manager_ID
          FROM
              employees e
                  JOIN dept_emp de ON e.emp_no = de.emp_no
          WHERE
                  e.emp_no > 10020
          GROUP BY e.emp_no
          ORDER BY e.emp_no
          LIMIT 20) AS b UNION
    SELECT
         c.*
     FROM
         (SELECT
              e.emp_no AS employee_ID,
              MIN(de.dept_no) AS department_code,
              (SELECT
                   emp_no
               FROM
                   dept_manager
               WHERE
                       emp_no = 110039) AS manager_ID
          FROM
              employees e
                  JOIN dept_emp de ON e.emp_no = de.emp_no
          WHERE
                  e.emp_no = 110022
          GROUP BY e.emp_no) AS c UNION
    SELECT
         d.*
     FROM
         (SELECT
              e.emp_no AS employee_ID,
              MIN(de.dept_no) AS department_code,
              (SELECT
                   emp_no
               FROM
                   dept_manager
               WHERE
                       emp_no = 110022) AS manager_ID
          FROM
              employees e
                  JOIN dept_emp de ON e.emp_no = de.emp_no
          WHERE
                  e.emp_no = 110039
          GROUP BY e.emp_no) AS d) as u;