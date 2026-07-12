{{ config(materialized='table') }}

SELECT
    provider_id,
    first_name,
    last_name,
    first_name || ' ' || last_name AS provider_name,
    specialty,
    active_yn
FROM {{ ref('stg_providers') }}