--------------------- Data Product ---------------
------------------ DNs  ------------------------
with
karuru_dns as (
                SELECT *,
                row_number()over(partition by id order by updated_at desc) as index
                FROM `kyosk-prod.karuru_reports.delivery_notes` dn
                where territory_id not in ('Test NG Territory', 'Kyosk TZ HQ', 'Test TZ Territory', 'Kyosk HQ','DKasarani', 'Test KE Territory', 'Test UG Territory', 'Test Fresh TZ Territory')
                and date(created_at) > '2023-08-01'
                --and is_pre_karuru = false
                ),
dns_list as (
              select distinct --date(created_at) as 
              created_at,
              updated_at,
              --coalesce(date(delivery_date), date(updated_at)) as delivery_date,
              --country_code,
              territory_id,
              --route_id,
              --route_name,
              id,
              code,
              --dn.sale_order_id,
              --dn.status,
              --delivery_trip_id,
              --payment_request_id,
              --agent_name as market_developer,
              --outlet.phone_number,
              --outlet_id,
              --outlet.name as outlet_name,
              --outlet.outlet_code as outlet_code,
              --outlet.latitude,
              --outlet.longitude,
              bq_upload_time
              --route_id,
              from karuru_dns dn
              where index = 1
              --and country_code = 'TZ'
              --and territory_id in ('Vingunguti')
              --AND dn.status IN ('PAID','DELIVERED','CASH_COLLECTED')
              --and dni.status = 'ITEM_FULFILLED'
              )
select distinct max(created_at),max(updated_at), max(bq_upload_time)
from dns_list