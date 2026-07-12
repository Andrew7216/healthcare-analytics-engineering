{{ config(materialized='view') }}

SELECT 
    appointment_id,
    patient_id,
    provider_id,
    appointment_date,
    appointment_time,
    TRIM(appointment_type) AS appointment_type,
    TRIM(appointment_status) AS appointment_status,
    deleted_yn
FROM {{ source('raw', 'appointments') }}