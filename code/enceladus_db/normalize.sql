-- Create Lookups

drop table if exists
    public.events,
    public.event_types,
    public.spass_types,
    public.targets,
    public.teams,
    public.requests
cascade
;

-- event_types
select distinct(library_definition)
    as description
into event_types
from import.master_plan;

alter table event_types
    add id serial primary key;

--requests
select distinct(request_name)
    as description
into requests
from import.master_plan;

alter table requests
    add id serial primary key;

--spass_types
select distinct(spass_type)
    as description
into spass_types
from import.master_plan;

alter table spass_types
    add id serial primary key;

--teams
select distinct(team)
    as description
into teams
from import.master_plan;

alter table teams
    add id serial primary key;

--targets
select distinct (target)
    as description
into targets
from import.master_plan;

alter table targets
    add id serial primary key;

--Create Events table in the public schema
drop table if exists events;
create table events(
   id            serial primary key,
   time_stamp    timestamptz not null,
   title         varchar(500),
   description   text,
   event_type_id int references event_types (id),
   target_id     int references targets (id),
   team_id       int references teams (id),
   request_id    int references requests (id),
   spass_type_id int references spass_types (id)
);

insert into events(
    time_stamp,
    title,
    description
)
select
    import.master_plan.start_time_utc::timestamptz at time zone 'UTC',
    import.master_plan.title,
    import.master_plan.description
from import.master_plan;

select import.master_plan.start_time_utc::timestamp,
       import.master_plan.title,
       import.master_plan.description,
       public.event_types.id as even_type_id,
       public.targets.id     as target_id,
       public.requests.id    as request_id,
       public.spass_types.id as spass_type_id,
       public.teams.id       as team_id
from import.master_plan
         left join event_types
                   on event_types.description = import.master_plan.library_definition
         left join targets
                   on targets.description = import.master_plan.target
         left join requests
                   on requests.description = import.master_plan.request_name
         left join spass_types
                   on spass_types.description = import.master_plan.spass_type
         left join teams
                   on teams.description = import.master_plan.team




