
##########################################################
##########################################################

-- MySQL Index

##########################################################
##########################################################


########################  Task 1   ##################################

/*
Select all records from the ‘salaries’ table of people whose salary is higher than $89,000 per annum.
Then, create an index on the ‘salary’ column of that table, and check if it has sped up the search of the same SELECT statement.
*/

select * from salaries where salary > 89000; # 0.0045 sec 

create index i_salary on salaries(salary); 

select * from salaries where salary > 89000; # 0.0025 sec 