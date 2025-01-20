select time_stamp,
       time_stamp::date as date,
       public.targets.description as targets,
       public.event_types.description as event,
       title
from events
left join event_types on event_type_id=event_types.id
left join targets on target_id=targets.id
where title ilike '%flyby%' or title ilike '%fly by%';