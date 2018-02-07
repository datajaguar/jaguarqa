This set of scripts are used for testing data visualizations 
using zepplin

Feb. 6, 2018

We may have three tables:
bank:   100,000,000 rows
bank_1:      45,000 rows
bank_2:  30,000,000 rows


New SQL:

SQL1: 

select education, count(1) as value  from  zeppeline1_bank_2  group by  education order by education timeout 500;

