SELECT 
  product_id
  , sum(quanity) as quantity_on_hand
FROM {{ ref('fact_inventory_transaction') }}
group by product_id
order by 2
