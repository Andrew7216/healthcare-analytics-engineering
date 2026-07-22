{{ config(materialized='view') }}

SELECT
    lab_order_id,
    patient_id,
    provider_id,
    order_date,
    result_date,
    test_name,
    result_value,
    result_status,
    last_modified_date
FROM {{ ref('int_resulted_lab_orders') }}
WHERE valid_lab_result_yn = TRUE