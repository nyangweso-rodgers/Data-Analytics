------------------- Karuru ----------
------------- Vehicles ------------
with
karuru_vehicle as (
                    SELECT *,
                    row_number()over(partition by id order by updated_at desc) as index
                    FROM `kyosk-prod.karuru_reports.vehicle` 
                    WHERE date(created_at) >= '2023-10-01'
                    ),
vehicles as (
              select distinct
              created_at,
              updated_at,
              bq_upload_time,
              id,
              license_plate,
              code,
              vehicle_type_id
              from karuru_vehicle
              where index = 1
              --where id = '0D6GEQY6YDCP9'
              )
select *
--max(created_at) as max_created_at, max(updated_at) as max_updated_at, max(bq_upload_time) as max_bq_upload_time
from vehicles
--where license_plate like "%T463AMS%"