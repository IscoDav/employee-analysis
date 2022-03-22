#############################                    #############################
#############################  Stored Routines   #############################
#############################                    #############################
                            #####################
                            
# routine (in a context other than computer science)
-- a usual, fixed action, or series of actions, repeated periodically

# Question : What is Stored Routines? 
# Answer : an SQL statement, or a set of SQL statements, that can be stored on the database server
--  whenever a user needs to run the query in question, they can call, reference, or invoke the routine



###################################### Task 1 ######################################

/*
Create a procedure that will provide the average salary of all employees. Then, call the procedure.
*/

DELIMITER $$ 
create procedure avg_salary() 
begin 

		select round(avg(salary),2) from salaries 
        limit 1000; 

end$$
DELIMITER ; 

# Calling procedure 
call avg_salary(); 


###################################### Task 2 ######################################

/* Create a procedure with parameter that executes the average salary of the employee  */ 

DELIMITER $$ 
use employees $$ 
create procedure emp_avg_salary(IN p_emp_no integer) 
begin 

select 
	e.first_name, e.last_name, AVG(s.salary) as avg_salary
from employees e 
	join 
salaries s on e.emp_no = s.emp_no 
	where e.emp_no = p_emp_no; 

end$$
DELIMITER ; 

# run this below code below if the query does not work 
# set @@global.sql_mode := replace(@@global.sql_mode, 'ONLY_FULL_GROUP_BY', '');

call emp_avg_salary(11300);


###################################### Task 3 ######################################

/*
Create the same procedure with outer parameter 
*/

drop procedure if exists emp_avg_salary_out; 

DELIMITER $$
use employees $$ 
create procedure emp_avg_salary_out(in p_emp_no integer, out p_avg_salary decimal(10,2))
begin 

select avg(s.salary)
into p_avg_salary from 
employees e 
	join 
salaries s on e.emp_no = s.emp_no
	where e.emp_no = p_emp_no; 

end$$ 
DELIMITER ; 


###################################### Task 4 ######################################

/*
Create a procedure called "emp_info" that uses as parameters 
the first and the last name of an individual, and returns their employee number.
*/

drop procedure if exists emp_info ; 

DELIMITER $$ 
use employees $$ 
create procedure emp_info(in p_first_name varchar(255), in p_last_name varchar(255), out p_emp_no integer) 
begin 

select emp_no into p_emp_no
from employees where first_name = p_first_name and last_name = p_last_name; 

end$$ 
DELIMITER ; 


###################################### Task 5 ######################################

/*
Create a variable, called "v_emp_no", where you will store the output of the procedure you created in the last exercise.

Call the same procedure, inserting the values "Aruna" and "Journel" as a first and last name respectively.

Finally, select the obtained output.
*/
set @v_emp_no = 0;  # creating new variable 
call employees.emp_info('Aruna', 'Journel', @v_emp_no); # saving outpit result in the variable creted 
select @v_emp_no; # printing the reslut 

###################################### Task 6 ######################################

/*
Create a function called "emp_info" that takes for parameters the first and last name of an employee, 
and returns the salary from the newest contract of that employee.

Hint: In the BEGIN-END block of this program, you need to declare and use 
two variables - v_max_from_date that will be of the DATE type, and v_salary, that will be of the DECIMAL (10,2) type.

Finally, select this function.

*/


drop function if exists emp_info; 

DELIMITER $$ 
use employees $$ 
create function emp_info (p_first_name varchar(255) , p_last_name varchar(255)) returns  decimal(10,2)
DETERMINISTIC NO SQL READS SQL DATA
begin 

declare v_max_date date; # creating variable for max_date
declare v_salary decimal(10,2); # creating variable for salary of employee

# first we selecting lates contract of the employee and saving it into v_max_date variable
select max(from_date) into v_max_date 
from employees e 
join 
salaries s on e.emp_no = s.emp_no 
where e.first_name = p_first_name and e.last_name = p_last_name; 

# second, we selecting the salary of employee and saving it into v_salary variable
select salary  into v_salary 
from employees e 
join 
salaries s on e.emp_no = s.emp_no 
where e.first_name = p_first_name and e.last_name = p_last_name 
						and s.from_date = v_max_date;

return v_salary;  # returning final result

end$$
DELIMITER ;  

select emp_info("Georgi", "Facello"); 






