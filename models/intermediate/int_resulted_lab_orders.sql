{{ config(materialized='table') }}

SELECT
    lab_order_id,
    patient_id,
    provider_id,
    order_date,
    result_date,
    test_name,
    result_value,
    result_status
FROM {{ ref('stg_lab_orders') }}
WHERE deleted_yn = FALSE
AND result_date IS NOT NULL
AND result_status = 'Final'