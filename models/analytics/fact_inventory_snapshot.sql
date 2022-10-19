with cte1 as (
    select
    date(date_trunc(transaction_occurred_when, month)) as year_month
    , product_id
    , sum(quantity) as net_change_quantity
  from `learning-dbt-362709.wide_world_importers_dwh.fact_inventory_transaction`
  group by 1, 2
)
, cte2 as (
  select 
    date_trunc(order_date, month)  as year_month
    , product_id
    , sum(quantity) as sold_quantity
  from `learning-dbt-362709.wide_world_importers_dwh.fact_sales_order_line`
  group by 1,2
) 


, cte3 as (
  select 
   distinct cte1.year_month
    , cte1.product_id
from cte1 
cross join `learning-dbt-362709.wide_world_importers_dwh.dim_date` as dim_date
)

, cte4 as (
select 
  cte1.year_month
  , cte3.product_id
  , cte1.net_change_quantity
  , cte2.sold_quantity
from cte3
left join cte1 as cte1 
  on cte1.product_id = cte3.product_id and cte1.year_month = cte3.year_month 
left join cte2 as cte2
  on cte2.product_id = cte3.product_id and cte2.year_month = cte3.year_month 
)

select
  year_month
  , product_id
  , net_change_quantity
  , sum(net_change_quantity) 
    over (partition by product_id order by year_month) as closing_onhand_quantity
  , sold_quantity
  from cte4
order by year_month
  