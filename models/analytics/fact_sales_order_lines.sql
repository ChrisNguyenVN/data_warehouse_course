with sales_order_lines__source as (
  select * from `duckdata-320210.wide_world_importers.sales__order_lines`
)

, sales_order_lines__rename as (
  select
   order_line_id as sales_order_line_id,
   quantity,
   unit_price
  from sales_order_lines__source
)

, sales_order_lines__cast as (
  select 
    cast(sales_order_line_id as INT64) AS sales_order_line_id,
    cast(quantity as numeric) as quantity,
    cast(unit_price as numeric) as unit_price
  from sales_order_lines__rename
)

select 
  *
from sales_order_lines__cast