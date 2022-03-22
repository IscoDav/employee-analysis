#############################                #############################
#############################    Self-JOINs  #############################
#############################                #############################
                            ##################

###################################### Task 1 ######################################

# Question : When is it appropriate to use self-joins?
# Answer:  When a column in a table is referenced in the same table

/*
From the emp_manager table, extract the record
data only of those employees who are
managers as well.
*/

SELECT DISTINCT
    e1.*
FROM
    emp_manager e1
        JOIN
    emp_manager e2 ON e1.emp_no = e2.manager_no;
