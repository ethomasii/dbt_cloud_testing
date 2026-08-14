{{ config(
    materialized='table',
    enabled=var('include_failing_model', false)
) }}

-- Section 5: `fail_fast=True` test. Fails at execution via BigQuery's ERROR()
-- function so Dagster's fail_fast path can cancel the Cloud run mid-flight.
-- Disabled by default so section 4 doesn't get poisoned; enable via:
--   dbt build --vars 'include_failing_model: true'

SELECT
  ERROR('Intentional failure for fail_fast test') AS should_fail,
  b.n
FROM {{ ref('slow_b') }} AS b
