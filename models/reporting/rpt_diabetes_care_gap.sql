{{ config(materialized='table') }}

SELECT
    p.patient_id,
    p.first_name,
    p.last_name,
    p.date_of_birth,
    a.current_age,
    l.latest_a1c_result_date,
    DATEDIFF('DAY', l.latest_a1c_result_date, CURRENT_DATE) AS days_since_latest_a1c,

    CASE
        WHEN a.current_age BETWEEN 18 AND 75
            AND (l.latest_a1c_result_date IS NULL
                 OR DATEDIFF('DAY', latest_a1c_result_date, CURRENT_DATE) > 365)
        THEN TRUE
        ELSE FALSE
    END AS care_gap_due,

    CASE
        WHEN a.current_age NOT BETWEEN 18 AND 75 THEN 'Not Due'
        WHEN l.latest_a1c_result_date IS NULL THEN 'Due'
        WHEN DATEDIFF('DAY', l.latest_a1c_result_date, CURRENT_DATE) > 365 THEN 'Due'
        ELSE 'Not Due'
    END AS care_gap_status,

    CASE
        WHEN a.current_age NOT BETWEEN 18 AND 75 THEN 'Not Due: Patient is outside the 18-75 age range'
        WHEN l.latest_a1c_result_date IS NULL THEN 'Due: No resulted A1C found'
        WHEN DATEDIFF('DAY', l.latest_a1c_result_date, CURRENT_DATE) > 365
             THEN 'Due: Last A1C was on ' || l.latest_a1c_result_date
          ELSE 'Not Due: Last A1C was on' || l.latest_a1c_result_date
    END AS care_gap_reason


FROM {{ ref('dim_patients') }} p 
LEFT JOIN {{ ref('int_patient_current_age') }} a ON p.patient_id = a.patient_id
LEFT JOIN {{ ref('rpt_latest_a1c_by_patient') }} l ON p.patient_id = l.patient_id