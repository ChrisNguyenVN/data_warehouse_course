WITH fact_inventory_transaction__source AS (
  SELECT * FROM `duckdata-320210.wide_world_importers.warehouse__stock_item_transactions`
)

, fact_inventory_transaction__rename AS (
  SELECT 
    stock_item_transaction_id as product_transaction_id
    , stock_item_id as product_id
    , transaction_type_id
    , customer_id
    , invoice_id
    , supplier_id
    , purchase_order_id
    , transaction_occurred_when
    , quantity as quanity_on_hand
    , last_edited_when
  FROM fact_inventory_transaction__source
)

, fact_inventory_transaction__cast AS (
  SELECT 
    CAST(product_transaction_id AS INT64) AS product_transaction_id
    , CAST(product_id AS INT64) AS product_id
    , CAST(transaction_type_id AS INT64) AS transaction_type_id
    , CAST(customer_id AS INT64) AS customer_id
    , CAST(invoice_id AS INT64) AS invoice_id
    , CAST(supplier_id AS INT64) AS supplier_id
    , CAST(purchase_order_id AS INT64) AS purchase_order_id 
    , CAST(transaction_occurred_when AS TIMESTAMP) AS transaction_occurred_when 
    , CAST(quanity_on_hand AS INT64) AS quanity_on_hand 
    , CAST(last_edited_when AS TIMESTAMP) AS last_edited_when 
  FROM fact_inventory_transaction__rename
)

SELECT 
    product_transaction_id
    , product_id
    , transaction_type_id
    , customer_id
    , invoice_id
    , supplier_id
    , purchase_order_id
    , transaction_occurred_when
    , quanity_on_hand
    , last_edited_when
FROM fact_inventory_transaction__cast

