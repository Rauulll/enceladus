select
    public.events.time_stamp,
    public.event_types.description as event,
    public.targets.description as target
from events
inner join event_types on events.event_type_id = event_types.id
inner join targets on events.target_id = targets.id
where events.time_stamp::date = '2005-02-17' and targets.id = '46'
order by events.time_stamp;