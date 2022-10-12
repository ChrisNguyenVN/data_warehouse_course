WITH stg_dim_delivery_method__source AS (
  SELECT 
    *
  FROM `duckdata-320210.wide_world_importers.application__delivery_methods`
)

, stg_dim_delivery_method__rename AS (
  SELECT 
    delivery_method_id
    , delivery_method_name
  FROM stg_dim_delivery_method__source
)

, stg_dim_delivery_method__cast AS (
  SELECT 
    CAST(delivery_method_id AS INT64) AS delivery_method_id
    , CAST(delivery_method_name AS STRING) AS delivery_method_name
  FROM stg_dim_delivery_method__rename
)

SELECT 
  delivery_method_id
  , delivery_method_name
FROM stg_dim_delivery_method__cast