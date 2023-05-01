with src_current_times as (

    select * from {{ source("tap_toggl", "time_entries_current") }} 

), stg_past_times as (

    select * from {{ ref("stg_time_entries") }}

), current_times as (

select 
	* 
from src_current_times C
	left join stg_past_times  P on p.id = C.id
	where P.id is null
 
), past_time_entries as (
 
select  
	end_date, 
	description, 
	current_timestamp 
from stg_past_times
	where end_date > current_timestamp - interval '30 minutes' 
 	order by end_date desc
 
 )

 select 
 	'Get that timer logging again!' as title,
 	'visch, Its been over 30 minutes since a timer has been logged, get to it!' as body
 where 
	(select count(*) from current_times) = 0 --no timer is current going if 0 rows
 	and --If both are true send an alert 
	(select count(*) from past_time_entries) = 0 --no time entries from the last time window if 0 rows.
