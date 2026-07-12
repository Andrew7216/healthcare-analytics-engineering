{{ config(materialized='table') }}

SELECT 
    patient_id,
    appointment_id,
    provider_id,
    appointment_date,
    appointment_time,
    appointment_type,
    appointment_status
FROM {{ ref('fct_appointments') }} apt
WHERE apt.appointment_date::DATE >= CURRENT_DATE
AND apt.appointment_status NOT IN ('Cancelled', 'No Show')
QUALIFY ROW_NUMBER () OVER (
    PARTITION BY apt.patient_id
    ORDER BY apt.appointment_date ASC
) = 1