{{ config(materialized='table') }}

SELECT
    visit_id,
    patient_id,
    provider_id,
    visit_date,
    visit_type,
    visit_status 
FROM {{ ref('int_valid_visits') }}