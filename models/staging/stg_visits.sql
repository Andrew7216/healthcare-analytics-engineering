
{{ config(materialized='view') }}

SELECT
    visit_id,
    patient_id,
    provider_id,
    visit_date,
    TRIM(visit_type) AS visit_type,
    TRIM(visit_status) AS visit_status,
    deleted_yn,
    left_without_being_seen_yn
FROM {{ source('raw', 'visits') }}