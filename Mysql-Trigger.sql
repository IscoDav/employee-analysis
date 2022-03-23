##########################################################
##########################################################

-- MySQL Triggers 

##########################################################
##########################################################


########################  Task 1   ##################################

/*
a new employee has been promoted to a manager

annual salary should immediately become 20,000 dollars higher than
the highest annual salary they'd ever earned until that moment
a new record in the "department manager" table

create a trigger that will apply several modifications to the
---- "salaries" table once the relevant record in the "department
manager" table has been inserted:
-------- make sure that the end date of the previously highest salary contract
of that employee is the one from the execution of the insert statement
--------insert a new record in the "salaries" table about the same employee that reflects their next contract as a manager


1.1 --- a start date the same as the new "from date" from the newly inserted record in "department manager"
1.2 ----a salary equal to 20,000 dollars higher than their highest-ever salary
1.3 ----let that be a contract of indefinite duration you can display that as a contract ending on the 1st of January in the
year 9999
*/

DELIMITER $$

CREATE TRIGGER trig_ins_dept_mng
AFTER INSERT ON dept_manager
FOR EACH ROW
BEGIN
	DECLARE v_curr_salary int;
    
    SELECT 
		MAX(salary)
	INTO v_curr_salary FROM
		salaries
	WHERE
		emp_no = NEW.emp_no;

	IF v_curr_salary IS NOT NULL THEN
		UPDATE salaries 
		SET 
			to_date = SYSDATE()
		WHERE
			emp_no = NEW.emp_no and to_date = NEW.to_date;

		INSERT INTO salaries 
			VALUES (NEW.emp_no, v_curr_salary + 20000, NEW.from_date, NEW.to_date);
    END IF;
END $$

DELIMITER ;

# After you are sure you have understood how this query works, please execute it and then run the following INSERT statement.  
INSERT INTO dept_manager VALUES ('111534', 'd009', date_format(sysdate(), '%y-%m-%d'), '9999-01-01');


########################  Task 2   ##################################

/*
Create a trigger that checks if the hire date of an employee is higher than the current date. 
If true, set this date to be the current date. Format the output appropriately (YY-MM-DD).
*/


DELIMITER $$ 
create trigger emp_hire_date 
BEFORE INSERT on employees
for each row
begin 

If new.hire_date > date_format(sysdate(), '%Y-%m-%d') THEN
	set new.hire_date = date_format(sysdate(),'%Y-%m-%d');
    end if;

end$$ 
DELIMITER ; 
   
INSERT employees VALUES ('999904', '1970-01-31', 'John', 'Johnson', 'M', '2025-01-01');  

SELECT  
    *  
FROM  
    employees
ORDER BY emp_no DESC;




