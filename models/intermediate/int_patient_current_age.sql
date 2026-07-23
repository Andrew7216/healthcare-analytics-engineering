{{ config(materialized='table') }}

WITH patients_with_age AS (

    SELECT
        patient_id,
        first_name,
        last_name,
        date_of_birth,
        {{ calculate_age('date_of_birth') }} AS current_age
    FROM {{ ref('stg_patients') }}

)

SELECT
    patient_id,
    first_name,
    last_name,
    date_of_birth,
    current_age,
    CASE
        WHEN current_age BETWEEN 0 AND 17 THEN '0-17'
        WHEN current_age BETWEEN 18 AND 44 THEN '18-44'
        WHEN current_age BETWEEN 45 AND 64 THEN '45-64'
        WHEN current_age BETWEEN 65 AND 75 THEN '65-75'
        ELSE '76+'
    END AS current_age_group
FROM patients_with_age
