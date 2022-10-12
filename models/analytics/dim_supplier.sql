WITH dim_supplier__source AS (
SELECT 
  * 
FROM `duckdata-320210.wide_world_importers.purchasing__suppliers`
)

, dim_supplier__rename AS (
  SELECT 
    supplier_id
    , supplier_name
    , supplier_category_id
    {# , supplier_category_name #}
    , delivery_method_id
    {# , delivery_method_name #}
    , delivery_city_id
    {# , delivery_city_name #}
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
  FROM dim_supplier__source
)

, dim_supplier__cast AS (
  SELECT 
    CAST(supplier_id AS INTEGER) AS supplier_id
    , CAST(supplier_name AS STRING) AS supplier_name
    , CAST(supplier_category_id AS INTEGER) AS supplier_category_id
    {# , CAST(supplier_category_name AS STRING) AS supplier_category_name #}
    , CAST(delivery_method_id AS INTEGER) AS delivery_method_id
    {# , CAST(delivery_method_name AS STRING) AS deldelivery_method_name #}
    , CAST(delivery_city_id AS INTEGER) AS delivery_city_id
    {# , CAST(delivery_city_name AS STRING) AS delivery_city_name #}
    , CAST(supplier_reference AS STRING) AS supplier_reference
    , CAST(bank_account_name AS STRING) AS bank_account_name
    , CAST(bank_account_code AS INTEGER) AS bank_account_code
    , CAST(bank_account_number AS INTEGER) AS bank_account_number
    , CAST(bank_international_code AS INTEGER) AS bank_international_code
    , CAST(payment_days AS INTEGER) AS payment_days
    , CAST(phone_number AS STRING) AS phone_number
    , CAST(delivery_address_line_1 AS STRING) AS delivery_address_line_1
    , CAST(delivery_address_line_2 AS STRING) AS delivery_address_line_2
    , CAST(delivery_postal_code AS INTEGER) AS delivery_postal_code
    , CAST(postal_address_line_1 AS STRING) AS postal_address_line_1
    , CAST(postal_address_line_2 AS STRING) AS postal_address_line_2
    , CAST(postal_postal_code AS INTEGER) AS postal_postal_code
  FROM dim_supplier__rename
)

SELECT 
    dim_supplier.supplier_id
    , dim_supplier.supplier_name
    , dim_supplier.supplier_category_id
    , dim_supplier_category.supplier_category_name
    , dim_supplier.delivery_method_id
    , dim_delivery_method.delivery_method_name
    , dim_supplier.delivery_city_id
    , dim_city.city_name AS delivery_city_name
    , dim_supplier.supplier_reference
    , dim_supplier.bank_account_name
    , dim_supplier.bank_account_code
    , dim_supplier.bank_account_number
    , dim_supplier.bank_international_code
    , dim_supplier.payment_days
    , dim_supplier.phone_number
    , dim_supplier.delivery_address_line_1
    , dim_supplier.delivery_address_line_2
    , dim_supplier.delivery_postal_code
    , dim_supplier.postal_address_line_1
    , dim_supplier.postal_address_line_2
    , dim_supplier.postal_postal_code
FROM dim_supplier__cast as dim_supplier 
LEFT JOIN {{ ref('stg_dim_supplier_category') }} AS dim_supplier_category
    ON dim_supplier.supplier_category_id = dim_supplier_category.supplier_category_id
LEFT JOIN {{ ref('stg_dim_delivery_method') }} AS dim_delivery_method
    ON dim_supplier.delivery_method_id = dim_delivery_method.delivery_method_id
LEFT JOIN {{ ref('stg_dim_city') }} AS dim_city
    ON dim_supplier.delivery_city_id = dim_city.city_id
