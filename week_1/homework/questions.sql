--Question 3
select 
	count(*) 
from green_taxi_data gtd 
	where lpep_pickup_datetime::date = '2019-09-18' 
	and lpep_dropoff_datetime::date = '2019-09-18'
    
--Question 4
select 
	lpep_pickup_datetime::date, 
	sum(trip_distance) as distance 
from green_taxi_data gtd 
	group by lpep_pickup_datetime::date
	order by 2 desc
	limit 1

--Question 5
select zpu."Borough", sum(total_amount) from green_taxi_data gtd 
	inner join zones zpu on gtd."PULocationID" = zpu."LocationID" 
where lpep_pickup_datetime::date = '2019-09-18' 
    and zpu."Borough" <> 'Unknown'
    group by zpu."Borough" 
    order by 2 desc 
    limit 3

--Question 6
select 
    zdo."Zone"  
from green_taxi_data gtd 
    inner join zones zpu on gtd."PULocationID" = zpu."LocationID" 
    inner join zones zdo on gtd."DOLocationID" = zdo."LocationID" 
where extract(month from gtd.lpep_pickup_datetime::date) = 9    
    and extract(year from gtd.lpep_pickup_datetime::date) = 2019
    and zpu."Zone" = 'Astoria' order by tip_amount desc limit 1