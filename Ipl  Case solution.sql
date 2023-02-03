create database IPL;
use ipl ;
select * from ipl_matches;
Update  ipl_matches
Set ipl_matches= replace ("date", "/","-");
alter table ipl_matches add column MatchDate date;

select id,date,str_to_date(left(date,10),"%d-%m-%Y") as MatchDate from ipl_matches;
set sql_safe_updates=0 ;

update ipl_matches
set MatchDate =  str_to_date(left(date,10),"%d-%m-%Y");
 alter table ipl_matches drop column matchdate;
-- 1. Create a table named 'matches' with appropriate data types for columns
create table Matches
select * from ipl_matches where id is null;

-- 2. Create a table named deliveries with appropriate data types for columns
create table Deliveries
select * from ipl_ball where ID is null;

-- 3. Import data from csv file IPL_matches.csv attached in resources to 'matches'
Insert into matches
select * from ipl_matches;
select * from matches;

-- 4. Import data from csv file IPL_Ball.csv attached in resources to matches
Insert into deliveries 
select * from ipl_ball;

-- 5. Select the top 20 rows of the deliveries table.
select * from deliveries
group by id limit 20;

-- 6. Select the top 20 rows of the matches table.
select * from matches
group by id limit 20;

-- 7. Fetch data of all the matches played on 2nd May 2013.
select * from matches
where date = 2-5-2013 ;

-- 8 Fetch data of all the matches where the margin of victory is more than 100 runs.
select * from matches
where result_margin > 100 ;

-- 9 Fetch data of all the matches where the final scores of both teams tied and order it in descending order of the date.
select * from matches
where result = "NA" 
order by date desc;

-- 10 Get the count of cities that have hosted an IPL match.
select city,count(city)
from matches
group by city;

-- 11 Create table deliveries_v02 with all the columns of deliveries and an additional column ball_result containing value boundary, dot or other 
-- depending on the total_run (boundary for &gt;= 4, dot for 0 and other for any other number) 


