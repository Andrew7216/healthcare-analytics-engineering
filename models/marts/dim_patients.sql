{{ config(materialized='table') }}

SELECT
    patient_id,
    first_name,
    last_name,
    date_of_birth,
    female_at_birth,
    phone_number,
    address,
    primary_care_provider_id
FROM {{ ref('stg_patients') }}