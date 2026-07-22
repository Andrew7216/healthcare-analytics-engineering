{{ config(
    materialized='incremental',
    incremental_strategy='merge',
    unique_key='lab_order_id',
    on_schema_change='sync_all_columns'
    ) }}

SELECT
    lab_order_id,
    patient_id,
    provider_id,
    order_date,
    result_date,
    test_name,
    result_value,
    result_status,
    deleted_yn,
    last_modified_date,

    CASE
        WHEN deleted_yn = FALSE 
        AND result_date IS NOT NULL
        AND result_status = 'Final'
        THEN TRUE
        ELSE FALSE
    END AS valid_lab_result_yn
FROM {{ ref('stg_lab_orders') }}

{% if is_incremental() %}

WHERE last_modified_date > (
    SELECT COALESCE(
         MAX(last_modified_date),
         '1900-01-01'::TIMESTAMP
    )
    FROM {{ this }}
)

{% endif %}