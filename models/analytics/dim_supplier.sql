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
    , deldelivery_method_id
    , deldelivery_method_name
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
  LEFT JOIN {{ ref('stg_dim_supplier_category') }}
)

