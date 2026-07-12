{{ config(materialized='view') }}

SELECT
    lab_order_id,
    patient_id,
    provider_id,
    order_date,
    result_date,
    TRIM(test_name) AS test_name,
    TRIM(result_value) AS result_value,
    TRIM(result_status) AS result_status,
    deleted_yn
FROM {{ source('raw', 'lab_orders')}}