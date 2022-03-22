################# Question 1  #################

/*
First, John had to retrieve a list with all employees hired in the year 2000, sorted by first name in ascending order.
Using theemployees table and the YEAR function to obtain the year from the relevant hire date, what is the last name of the
third employee from the obtained output?
*/

select * from employees 
where year(hire_date) = 2000; 
# answer : Luit

################# Question 3  #################

/*
The interviewers asked John to obtain the average male and female employee salary values for each department.
and in which departments Female employee earn more money than Male
*/

SELECT 
    d.dept_name, e.gender, AVG(s.salary)
FROM
    salaries s
        JOIN
    employees e ON e.emp_no = s.emp_no
        JOIN
    dept_emp de ON e.emp_no = de.emp_no
        JOIN
    departments d ON d.dept_no = de.dept_no
GROUP BY d.dept_name , e.gender
ORDER BY de.dept_no; 
# In Customer Service department, Females earn more money 



################# Question 3  #################

/*
The interviewers told John that his job will sometimes require creating stored routines -a tool we use when we want to apply a fixed series
of actions on certain parts of the database periodically. To show that he can do this, John tries to create a stored routine that asks the
user to insert an employee number to obtain an output containing:

---- The same employee number
---- The number of the last department the employee has worked for
---- The name of the last department the employee has worked for 

*/

DROP PROCEDURE IF EXISTS last_dept;

DELIMITER $$
CREATE PROCEDURE last_dept(in p_emp_no integer)
begin 
select e.emp_no, d.dept_no, d.dept_name 
from employees e 
join 
dept_emp de on e.emp_no = de.emp_no
join 
departments d on d.dept_no = de.dept_no 
where e.emp_no = p_emp_no 
and de.from_date = (select max(from_date) from dept_emp where emp_no = p_emp_no );

end$$
DELIMITER ;

call last_dept(10100); 

