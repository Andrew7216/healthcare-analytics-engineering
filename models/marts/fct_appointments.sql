{{ config(materialized='view') }}

SELECT 
    appointment_id,
    patient_id,
    provider_id,
    appointment_date,
    appointment_time,
    appointment_type,
    appointment_status
FROM {{ ref('int_valid_appointments')}}