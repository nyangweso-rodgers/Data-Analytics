--------------------- Delivery Note ---------------
with
delivery_notes as (
                SELECT *,
                row_number()over(partition by id order by updated_at desc) as index
                FROM `kyosk-prod.karuru_reports.delivery_notes` dn
                --where date(created_at) = current_date
                where date(created_at) > date_sub(current_date, interval 30 day)
                --and is_pre_karuru = false
                ),
delivery_notes_report as (
                          select distinct --date(created_at) as 
                          created_at,
                          --updated_at,
                          --coalesce(date(delivery_date), date(updated_at)) as delivery_date,
                          --country_code,
                          territory_id,
                          --route_id,
                          --route_name,
                          id,
                          code,
                          --dn.sale_order_id,
                          dn.status,
                          delivery_trip_id,
                          --payment_request_id,
                          --agent_name as market_developer,
                          --outlet.phone_number,
                          --outlet_id,
                          --outlet.name as outlet_name,
                          --outlet.outlet_code as outlet_code,
                          --outlet.latitude,
                          --outlet.longitude,
                          --route_id,
                          from delivery_notes dn
                          where index = 1
                          --and country_code = 'TZ'
                          --and territory_id in ('Vingunguti')
                          --AND dn.status IN ('PAID','DELIVERED','CASH_COLLECTED')
                          --and dni.status = 'ITEM_FULFILLED'
                          )
select *
from delivery_notes_report
--where territory_id not in ('Test NG Territory', 'Kyosk TZ HQ', 'Test TZ Territory', 'Kyosk HQ','DKasarani', 'Test KE Territory', 'Test UG Territory', 'Test Fresh TZ Territory')
--where id = '0G4DPSFMYGDFS'
where code = 'DN-KARA-0FWK97MDPQNST'
order by 1 desc