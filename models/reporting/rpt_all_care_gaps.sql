{{ config(materialized='table') }}

SELECT 
    patient_id,
    1 AS care_gap_id,
    'Diabetes A1C' AS care_gap_name,
    care_gap_due,
    care_gap_status,
    care_gap_reason
FROM {{ ref('rpt_diabetes_care_gap') }}

UNION ALL

SELECT 
    patient_id,
    2 AS care_gap_id,
    'Lead Screening' AS care_gap_name,
    care_gap_due,
    care_gap_status,
    care_gap_reason
FROM {{ ref('rpt_lead_screening_care_gap') }}