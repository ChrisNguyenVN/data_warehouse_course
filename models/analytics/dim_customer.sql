WITH dim_customer__source AS (
  SELECT * FROM `duckdata-320210.wide_world_importers.sales__customers`
)

, dim_customer__rename AS (
  SELECT
    customer_id
    , customer_name
    {# , bill_to_customer_id
    , customer_category_id
    , buying_group_id
    , primary_contact_person_id
     #}
  FROM dim_customer__source
)

, dim_customer__cast AS (
  SELECT 
    CAST(customer_id AS INT64) AS customer_id
    , CAST(customer_name AS STRING) AS customer_name
  FROM dim_customer__rename
)

SELECT
  customer_id
  , customer_name
FROM dim_customer__cast