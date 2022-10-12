WITH stg_dim_supplier_category__source AS (
  SELECT * FROM `duckdata-320210.wide_world_importers.purchasing__supplier_categories`
)

, stg_dim_supplier_category__rename AS (
  SELECT 
    supplier_category_id
    , supplier_category_name
  FROM stg_dim_supplier_category__source
)

, stg_dim_supplier_category__cast AS (
  SELECT 
    CAST(supplier_category_id AS INT64) AS supplier_category_id
    , CAST(supplier_category_name AS STRING) AS supplier_category_name
  FROM stg_dim_supplier_category__rename
)

SELECT 
  supplier_category_id
  , supplier_category_name
FROM stg_dim_supplier_category__cast
