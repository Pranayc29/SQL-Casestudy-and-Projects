 create database ola;
 use ola;
 select pickup_date from data;
 
 alter table data
 add column datepickup date;

select pickuparea,droparea,str_to_date(left(pickup_date,10),"%d-%m-%Y") as datepickup
from data;

set sql_safe_updates=0 ;

update data
set datepickup = str_to_date(left(pickup_date,10),"%d-%m-%Y") ;

select * from data ;

alter table data drop column pickup_date;

-- 2 Make a table with count of bookings with booking_type = p2p catgorized by booking mode as 'phone', 'online','app',etc				
select booking_mode,count(*) as cntbooking
from data
where booking_type = "p2p"
group by booking_mode;

-- 4 Find top 5 drop zones in terms of  average revenue				
select droparea,avg(fare) as avgrevenue
from data
group by droparea
order by avg(fare) desc limit 5 ;

-- 5	Find all unique driver numbers grouped by top 5 pickzones				

select Driver_number,count(*) as uniquenumbers
from (
select pickuparea ,count(*) as pickupareacount
from data
group by pickuparea 
order by pickupareacount desc limit 5 ) as pickzone
group by count(*)
having count(*) =1  ;     DOUBT

-- 7 Make a hourwise table of bookings for week between Nov01-Nov-07 and highlight the hours with more than average no.of bookings day wise										

select booking_id,pickup_time,booking_type
from data
where datepickup between '2013-11-01'  and '2013-11-07' ;




