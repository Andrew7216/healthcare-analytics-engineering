{{ config(materialized='table') }}

SELECT
    patient_id,
    lab_order_id,
    result_date AS latest_a1c_result_date,
    result_value AS latest_a1c_value
FROM {{ ref('fct_lab_results') }}
WHERE test_name = 'A1C'
QUALIFY ROW_NUMBER() 
OVER (PARTITION BY patient_id 
      ORDER BY result_date DESC) = 1