create database layoff;

use layoff;

select * from data;

alter table data add  column layoff_date date;

set sql_safe_updates=0;


update data
set layoff_date=str_to_date(left(date,10),"%d-%m-%Y") ;

alter table data
drop date;

select * from data;

-- QUESTIONS__

-- 	Q1 Find the total number distinct of companies who are present in the layoff data
SELECT count(distinct(company)) as TotalUniqueCompany
from data;

-- Q2 . Find total companies from India.
select count(company) from data 
where country="india";

-- Q3. What are the different Industries from which layoff happened AND Show the count of industries in descending order?
select industry ,count(*)
from data
where industry <> "NA"
group by industry
ORDER BY COUNT(*) DESC;

-- Q4. Total layoff during the 4th Quarter of 2022.
select sum(total_laid_off) as TotalLayoffCount
from data
where layoff_date  between '2022-09-01' and '2022-12-31' ;

-- Q5. Find companies that have raised above average funds after layoff.
select company,funds_raised
from data
where funds_raised > (select avg(funds_raised) from data);

-- Q6. Rank companies from worse to best in terms of layoff.
select company,total_laid_off,rank() over (order by total_laid_off asc) as Ranks
from  data
where total_laid_off<>0
group by company;

-- Q7.which countries employees are suffering the most because of layoff.
select sum(total_laid_off) as CountofLaidoff,country
from data
group by country
order by CountofLaidoff desc limit 1;

-- Q8. List of different companies which  have the highest percentage of laid off.
select distinct(company),percentage_laid_off
from data
where percentage_laid_off= (select max(percentage_laid_off) from data) ;

-- Q9. What are the different stages and count of those stages.
select stage,count(*) as Totalstagecount
from data
where stage is not null
group by stage
order by Totalstagecount ;

