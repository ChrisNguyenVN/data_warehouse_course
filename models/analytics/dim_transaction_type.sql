WITH dim_transaction_type__source AS (
  SELECT * FROM `duckdata-320210.wide_world_importers.application__transaction_types`
)

, dim_transaction_type__rename AS (
  SELECT 
    transaction_type_id
    , transaction_type_name
  FROM dim_transaction_type__source
)

SELECT 
 *
FROM dim_transaction_type__rename