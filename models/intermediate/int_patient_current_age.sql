{{ config(materialized='table' )}}

SELECT
    patient_id,
    first_name,
    last_name,
    date_of_birth,
    DATEDIFF('YEAR', date_of_birth, CURRENT_DATE) AS current_age,
    CASE 
    WHEN DATEDIFF('YEAR',date_of_birth, CURRENT_DATE) BETWEEN 0 AND 17 THEN '0-17'
    WHEN DATEDIFF('YEAR',date_of_birth, CURRENT_DATE) BETWEEN 18 AND 44 THEN '18-44'
    WHEN DATEDIFF('YEAR',date_of_birth, CURRENT_DATE) BETWEEN 45 AND 64 THEN '45-64'
    WHEN DATEDIFF('YEAR',date_of_birth, CURRENT_DATE) BETWEEN 65 AND 75 THEN '65-75'
    ELSE '76+'
    END AS current_age_group
FROM {{ ref('stg_patients') }}