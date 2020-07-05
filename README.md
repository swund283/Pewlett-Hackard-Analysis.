# Pewlett-Hackard-Analysis.



With this database we are auditing the amount of staff that will be of retirement age soon vs the entire population.  To do this we created a database with data around the age and current department the employee works in.  We then divided this data up into a few different views to compare the risk to an each department having a lot of retirements.


Forward looking at all the 4 datasets required I choose to create a few extra tables that held data with various information.  As we wanted to make sure that we were only looking at current employee positions we chose to partition that data of early before we started to count employees by departments.  With this tact I chose to output more info into other tables than was suggested.  This allowed me to contain the majority of my syntax in the same tool.  The only challenge that I encountered was that the 4 output files we're not very 'organized' in the way they were requested.  The 1st pass at the data I did the files in sequence, only to find out I needed additional information to complete them all.  So, I chose to go all the way back up stream and add additional columns not requested to the original partitioned data.  Then just defined the queries more as the data was requested.  


Packard-Hewitt has no department with more than a 15% retiring population, with most departments having closer to 10% retiring.  The 4 csv files give a very high level of the data.  However, only using sql this doesn't paint a very good executive summary.  Nor does it allow you to 'explore' the data easily.  We are easily able to see that there is a need to create a mentor program.  However, using only sql to analyze the data this effort is not as flexible as other tools.  I feel that to best interpret the data we can build a large dataset with a few parameters; then, utilize that data in a more flexible tool like a panda data frame.  This is why chose to add additional columns to the originally joined tables, that dataset is perfect for a deeper analysis in pandas.  In that deeper analysis I would look through at a more granular level by department as well as look at the correct range of ages to train through the mentorship.  Using only the fixed dates provided in the where clause with this 4th dataset doesn't provide the dynamic insight required to make the educated decison.

To assist with my file naming, all 4 csv files + 1 sql query + 1 ERD diagram are contained in 'challenge data' folder:
    1. all_titles.csv - this is grouped data to see all current employees count by department 
    2. all_silver_titles.csv - this is the ground data for the 'retiring age' by current employees department.
    3. all_silver.csv - this is the raw information about the 'retiring age' population in the company.
    4. Mentorship.csv - this is the raw information about the 'mentor age' associates in the company.
    5. Challenge.sql - is a cleaned up sql code to create all the tables needed and the syntax to do the analysis
    6. employeeDB.png - ERD