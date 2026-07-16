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
FROM {{ ref('int_resulted_lab_orders') }}