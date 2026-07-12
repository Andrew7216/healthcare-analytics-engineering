{{ config(materialized='table') }}

SELECT 
    patient_id,
    care_gap_id,
    care_gap_name,
    care_gap_reason
FROM {{ ref('rpt_all_care_gaps') }}
WHERE care_gap_due = TRUE