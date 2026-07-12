{{ config(materialized='table') }}

SELECT 
    p.patient_id,
    p.first_name,
    p.last_name,
    p.date_of_birth,
    a.current_age,
    l.latest_lead_result_date,
    l.latest_lead_result_value,

    CASE 
        WHEN a.current_age BETWEEN 1 AND 5
        AND l.latest_lead_result_date IS NULL
        THEN TRUE
        ELSE FALSE
    END AS care_gap_due,

    CASE
        WHEN a.current_age NOT BETWEEN 1 AND 5 THEN 'Not Due'
        WHEN l.latest_lead_result_date IS NULL THEN 'Due'
        ELSE 'Not Due'
    END AS care_gap_status,

    CASE
        WHEN a.current_age NOT BETWEEN 1 AND 5
            THEN 'Not Due: Patient is outside the 1-5 age range'
        WHEN l.latest_lead_result_date IS NULL
            THEN 'Due: No resulted lead screening found'
        ELSE 'Not Due: Latest lead screening was on' || TO_VARCHAR(l.latest_lead_result_date)
    END AS care_gap_reason
FROM {{ ref('dim_patients') }} p
LEFT JOIN {{ ref('int_patient_current_age') }} a ON p.patient_id = a.patient_id
LEFT JOIN {{ ref('rpt_latest_lead_screening_by_patient') }} l ON p.patient_id = l.patient_id