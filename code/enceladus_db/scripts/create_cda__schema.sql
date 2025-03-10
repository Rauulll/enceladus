drop schema if exists cda;
create schema cda;
select
    event_id::integer as event_id,
    impact_event_time::timestamptz as time_stamp,
    impact_event_time::date as impact_date,
    case counter_number
        when '**' then null
        else counter_number::integer
    end as counter_number,
    spacecraft_sun_distance::numeric(6,4) as sun_distance_au,
    spacecraft_saturn_distance::numeric(8,2) as saturn_distance_rads,
    spacecraft_x_velocity::numeric(6,2) as x_velocity,
    spacecraft_y_velocity::numeric(6,2) as y_velocity,
    spacecraft_z_velocity::numeric(6,2) as z_velocity,
    particle_mass::numeric(4,2),
    particle_charge::numeric(4,2)
into cda.impacts
from import.cda
order by impact_event_time::timestamp;

alter table cda.impacts
add id serial primary key;