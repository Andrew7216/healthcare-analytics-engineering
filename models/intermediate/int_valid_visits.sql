{{ config(materialized='table') }}

SELECT
    visit_id,
    patient_id,
    provider_id,
    visit_date,
    visit_type,
    visit_status
FROM {{ ref('stg_visits') }}
WHERE deleted_yn = FALSE
AND left_without_being_seen_yn = FALSE