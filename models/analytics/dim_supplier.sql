WITH dim_product__source AS (
SELECT 
  * 
FROM `duckdata-320210.wide_world_importers.purchasing__suppliers`
)

, dim_product_rename AS (
  SELECT 
    supplier_id
    , supplier_name
    , supplier_category_id
    , supplier_category_name
    , delivery_method_id
    , delivery_method_name
    , delivery_city_id
    , delivery_city_name
    , supplier_reference
    , bank_account_name
    , bank_account_code
    , bank_account_number
    , bank_international_code
    , payment_days
    , phone_number
    , delivery_address_line_1
    , delivery_address_line_2
    , delivery_postal_code
    , postal_address_line_1
    , postal_address_line_2
    , postal_postal_code
  FROM dim_product__source
)

, dim_product__cast AS (
  SELECT 
    CAST(supplier_id AS INT64) AS supplier_id
    , CAST(supplier_name AS STRING) AS supplier_name
    , CAST(supplier_category_id AS INT64) AS supplier_category_id
    {# , CAST(supplier_category_name AS STRING) AS supplier_category_name #}
    , CAST(delivery_method_id AS INT64) AS deldelivery_method_id
    , CAST(delivery_method_name AS STRING) AS deldelivery_method_name
    , CAST(delivery_city_id AS INT64) AS delivery_city_id
    , CAST(delivery_city_name AS STRING) AS delivery_city_name
    , CAST(supplier_reference AS STRING) AS supplier_reference
    , CAST(bank_account_name AS STRING) AS bank_account_name
    , CAST(bank_account_code AS INT64) AS bank_account_code
    , CAST(bank_account_number AS INT64) AS bank_account_number
    , CAST(bank_international_code AS INT64) AS bank_international_code
    , CAST(payment_days AS INT64) AS payment_days
    , CAST(phone_number AS INT64) AS phone_number
    , CAST(delivery_address_line_1 AS STRING) AS delivery_address_line_1
    , CAST(delivery_address_line_2 AS STRING) AS delivery_address_line_2
    , CAST(delivery_postal_code AS INT64) AS delivery_postal_code
    , CAST(postal_address_line_1 AS STRING) AS postal_address_line_1
    , CAST(postal_address_line_2 AS STRING) AS postal_address_line_2
    , CAST(postal_postal_code AS INT64) AS postal_postal_code
  FROM dim_product_rename
)

SELECT 
  dim_supplier.*
  , dim_supplier_category.supplier_category_name
FROM dim_supplier__cast as dim_supplier 
LEFT JOIN {{ ref('stg_dim_supplier_category') }} AS dim_supplier_category
    ON dim_supplier.supplier_category_id = dim_supplier_category.supplier_category_id
