WITH stg_dim_city__source AS (
  SELECT 
    *
  FROM `duckdata-320210.wide_world_importers.application__cities`
)

, stg_dim_city__rename AS (
  SELECT
    city_id
    , city_name
    , state_province_id
    , latest_recorded_population 
  FROM stg_dim_city__source
)

, stg_dim_city__cast AS (
  SELECT 
    CAST(city_id AS INTEGER) AS city_id
    , CAST(city_name AS STRING) AS city_name
    , CAST(state_province_id AS INTEGER) AS state_province_id
    , CAST(latest_recorded_population AS INTEGER) AS latest_recorded_population
  FROM stg_dim_city__rename
)

SELECT 
   city_id
    , city_name
    , state_province_id
    , latest_recorded_population 
FROM stg_dim_city__cast