#############################                #############################
#############################    SQL-views   #############################
#############################                #############################
                            ##################

###################################### Task 1 ######################################

# Question : What is SQL-views? 
# Answer : a virtual table whose contents are obtained from an existing table or tables, called base tables


/*
Create a view that will extract the average salary of all managers registered in the database. Round this value to the nearest cent. 
If you have worked correctly, after executing the view from the “Schemas” section in Workbench, you should obtain the value of 66924.27.
*/

CREATE OR REPLACE VIEW avg_salary_of_managers AS
    SELECT 
        round(AVG(salary),2)
    FROM
        salaries s
            JOIN
        titles t ON s.emp_no = t.emp_no
    WHERE
        t.title = 'Manager'; 
        