{{ config(materialized='view') }}

SELECT
    provider_id,
    TRIM(first_name) AS first_name,
    TRIM(last_name) AS last_name,
    TRIM(specialty) AS specialty,
    active_yn
FROM {{ source('raw', 'providers') }}