{{ config(materialized='table') }}

SELECT 
    cg.patient_id,
    p.first_name,
    p.last_name,
    p.date_of_birth,
    cg.care_gap_name,
    cg.care_gap_reason,
    appt.appointment_id,
    appt.appointment_date AS next_appointment_date,
    appt.appointment_time AS next_appointment_time,
    appt.appointment_type AS next_appointment_type,
    pr.provider_name,
    pr.specialty
FROM {{ ref('rpt_care_gaps_due') }} cg 
JOIN {{ ref('dim_patients') }} p ON cg.patient_id = p.patient_id
LEFT JOIN {{ ref('rpt_next_appointment_by_patient') }} appt ON cg.patient_id = appt.patient_id
LEFT JOIN {{ ref('dim_providers') }} pr ON appt.provider_id = pr.provider_id
