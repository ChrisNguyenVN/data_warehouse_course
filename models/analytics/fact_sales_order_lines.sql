with fact_sales__order_lines as (
  select * from `duckdata-320210.wide_world_importers.sales__order_lines`
)
, fact_sales_order_lines__renamed_column as (
  select 
    order_line_id AS sales_order_line_id
  , stock_item_id AS product_id
  , quantity as quantity
  , unit_price as unit_price
  , quantity * unit_price AS gross_amount
  from fact_sales__order_lines
)

, fact_sales_order_lines__cast as (
SELECT 
  CAST(sales_order_line_id AS INT64) AS sales_order_line_id
  , CAST(product_id AS INT64) AS product_id
  , CAST(quantity AS NUMERIC) as quantity
  , CAST(unit_price AS NUMERIC) as unit_price
FROM fact_sales_order_lines__renamed_column
)

, fact_sales_order_lines__calculated as (
  select 
    *,
    quantity*unit_price as gross_amount
from fact_sales_order_lines__cast
)

select 
  sales_order_line_id,
  product_id,
  quantity,
  unit_price,
  gross_amount
from fact_sales_order_lines__calculated