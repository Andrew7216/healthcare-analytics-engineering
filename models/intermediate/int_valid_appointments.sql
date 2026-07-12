{{ config(materialized='table') }}

SELECT
    appointment_id,
    patient_id,
    provider_id,
    appointment_date,
    appointment_time,
    appointment_type,
    appointment_status
FROM {{ ref('stg_appointments') }}
WHERE deleted_yn = FALSE