with source as (

select * from {{source("tap_toggl", "time_entries") }}

), stage as (

 SELECT 
 	billable, 
 	client, 
 	cur, 
 	description, 
 	dur, 
    "end" as end_date, --"end" at TIME zone 'UTC' as "end_date", 
 	id, 
 	is_billable, 
 	pid, 
 	project, 
 	"start" as start_date, --at TIME zone 'UTC' as "start_date", 
 	tags, 
 	task, 
 	tid, 
 	uid, 
 	updated, 
 	use_stop, 
 	"user"
FROM tap_toggl.time_entries

)

select * from stage

