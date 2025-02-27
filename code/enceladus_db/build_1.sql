--hot to import from csv files to postgres db
drop table if exists master_plan;
create table master_plan(
    start_time_utc text,
    duration text,
    date text,
    team text,
    spass_type text,
    target text,
    request_name text,
    library_definition text,
    title text,
    description text
);
COPY import.master_plan 
FROM '[path_to_file]/master_plan.csv' 
WITH DELIMITER ',' HEADER CSV;
