drop view if exists materialized_enceladus_events;
create materialized view materialized_enceladus_events as
    select
        events.id,
        events.time_stamp::date as date,
        events.title,
        events.description,
        event_types.description as event,
        to_tsvector(
                concat(events.description, '', events.title)
        ) as search
    from events
             inner join event_types on event_types.id = events.event_type_id
    where target_id = '46'
    order by events.time_stamp;
create index idx_event_search
on materialized_enceladus_events using GIN(search);