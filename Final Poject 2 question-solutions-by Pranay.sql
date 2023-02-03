create database final_project2;
use final_project2;
/* 1. Create a table “Station”  to store information about weather observation stations:
ID Number Primary Key 
CITY CHAR(20), 
STATE CHAR(2), 
LAT_N Number 
LONG_W Number */
create table station (ID integer ,CITY char(20),STATE char(2),LAT_N int,LONG_W int,constraint cnk Primary key (ID));

/* Q2. Insert records into table STATION*/
Insert into station(ID ,CITY ,STATE,LAT_N ,LONG_W )
values
(13,"pheonix","AZ",32,112),
(44,"Denver","CO",40,105),
(66,"caribou","ME",47,68);

/* Q3. Execute a  query to look at table STATION in undefined order.*/
select * from station ; /* what I undestood from question is that we need to show data which is present in the table as wrote query as per that */

/* 4. Execute a query to select Northern stations (Northern latitude > 39.7). */
select LAT_N from station 
where LAT_N > 39.7 ;

/* Q5 Create another table, ‘STATS’, to store normalized temperature and precipitation data:  */
create table STATS(ID int,Months int,TEMP_F int,RAIN_I int,constraint cnk primary key(ID,Months));

/* Q6 Populate the table STATS with some statistics for January and July: */
Insert into STATS(ID,Months,TEMP_F,RAIN_I)
values
(13,1,57.4,0.31),
(13,7,91.7,5.15),
(44,1,27.3,0.18),
(44,7,74.8,2.11),
(66,1,6.7,2.1),
(66,7,65.8,4.52);

/* 7. Execute a query to display temperature stats (from STATS table) for each city (from Station
table).  */
select city,TEMP_F from stats s join station st on s.id = st.id;
 
/* 8. Execute a query to look at the table STATS, ordered by month and greatest rainfall, with
columns rearranged. It should also show the corresponding cities. */

select months,rain_i,st.city from stats s inner join station st on s.id=st.id
order by months,rain_i desc ;

/*9. Execute a query to look at temperatures for July from table STATS, lowest temperatures first,
picking up city name and latitude. */

select temp_f,months,city,lat_n
from stats s join station st on s.id = st.id
where months = 7
order by temp_f asc ;

/*10. Execute a query to show MAX and MIN temperatures as well as average rainfall for each city */
select city,max(temp_f),min(temp_f),avg(rain_i)
from station st inner join stats s on st.id=s.id 
group by city;

/*11. Execute a query to display each city’s monthly temperature in Celcius and rainfall in
Centimeter */
select city,months,temp_f*(5/9) as CelciesTemp,rain_i*2.54 as CentimeterRainfall from station st join stats s on s.id=st.id ;

/* 12. Update all rows of table STATS to compensate for faulty rain gauges known to read 0.01
inches low.*/
select id,rain_i,rain_i+0.01 as compensatedrain from stats;

SET SQL_SAFE_UPDATES = 0 ;


/* 13. Update Denver's July temperature reading as 74.9*/
update stats
set temp_f=74.9
where (select city,months from 
stats s join station st on s.id=st.id 
where city="DENVER" and months=





