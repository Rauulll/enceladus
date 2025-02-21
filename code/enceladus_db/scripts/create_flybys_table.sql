-- flyby table 2.0
-- add name, start_time and end_time in the CTE generated flybys table

-- convenience for redoing
drop table if exists flybys;

with lows_by_week as (
    select year, week,
    min(altitude) as altitude
    from flyby_altitudes
    group by year, week
), nadirs as (
    select low_time(altitude, year, week) as time_stamp, altitude
    from lows_by_week
)
-- exec CTE
select nadirs.*,
       --set initial values as null
       null::varchar as name,
       null::timestamptz as start_time,
       null::timestamptz as end_time
-- create a new table
into flybys
from nadirs;

--add primary key
alter table flybys
add column id serial primary key;

-- using the key, create
-- the name using the new id
-- || concatenates strings
-- and also coerces to string
update flybys
set name='E-'|| id-1
where name is null;