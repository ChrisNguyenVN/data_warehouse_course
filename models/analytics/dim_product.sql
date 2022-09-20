with dim_product__souce as (
  select * from `duckdata-320210.wide_world_importers.warehouse__stock_items`
)

, dim_product__renamed_column as (
  select 
    stock_item_id AS product_id
  , stock_item_name AS product_name
  , brand AS brand_name
  from dim_product__souce
)
, dim_product__cast as (
  select 
    CAST(product_id AS INT64) AS product_id
  , CAST(product_name AS STRING) AS product_name
  , CAST(brand_name AS STRING) AS brand_name
  from dim_product__renamed_column
)


SELECT 
  product_id,
  product_name,
  brand_name
FROM dim_product__cast