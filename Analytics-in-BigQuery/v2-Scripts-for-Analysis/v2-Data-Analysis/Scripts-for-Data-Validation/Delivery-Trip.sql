---------------------------- QA - Delivery Trip ------------------------
with delivery_trip_with_index as (
                                    SELECT *, 
                                    row_number()over(partition by name order by modified desc) as index
                                    FROM `kyosk-prod.erp_reports.delivery_trip`
                                    --where date(creation) between '2022-12-01' and '2023-01-28'
                                    ),
delivery_trip_summary as (select distinct date(creation) as creation_date, count(distinct name) as count from  delivery_trip_with_index where index = 1 group by 1 order by 1 desc),
delivery_trip_lists as (select distinct date(creation) as creation_date, name, workflow_state from  delivery_trip_with_index where index = 1 order by 1)

select distinct date(dt.creation),dt.name, workflow_state, count(distinct delivery_note)
from delivery_trip_with_index dt, unnest(delivery_stops) ds