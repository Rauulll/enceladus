select time_stamp,
       public.targets.description as targets,
       title
from events
         inner join targets on target_id=targets.id
where title ~* '^T\d.*? flyby';