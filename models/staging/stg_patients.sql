
{{ config(materialized='view') }}

SELECT
    patient_id,
    TRIM(first_name) AS first_name,
    TRIM(last_name) AS last_name,
    female_at_birth,
    date_of_birth,
    TRIM(phone_number) AS phone_number,
    TRIM(address) AS address,
    primary_care_provider_id
FROM {{ source('raw', 'patients') }}
