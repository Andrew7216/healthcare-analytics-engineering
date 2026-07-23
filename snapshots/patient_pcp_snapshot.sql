{% snapshot patient_pcp_snapshot %}

{{
    config(
        target_schema='SNAPSHOTS',
        unique_key='patient_id',
        strategy='check',
        check_cols=['primary_care_provider_id']
    )
}}

SELECT
    patient_id,
    primary_care_provider_id
FROM {{ source('raw', 'patients') }}

{% endsnapshot %}