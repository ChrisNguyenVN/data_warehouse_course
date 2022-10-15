SELECT 
  product_id
  , sum(quanity_on_hand) as quanity_on_hand
FROM {{ ref('fact_inventory_transaction') }}
group by product_id
order by 2
