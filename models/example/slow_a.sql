{{ config(materialized='table') }}

-- Section 4: `monitor_runs=True` streaming test. Chain of three slow models
-- gives Dagster enough time between per-model completions to visibly stream
-- AssetMaterialization events mid-run. Each model is ~10-15s on BigQuery.

SELECT
  n,
  SHA256(CAST(n AS STRING)) AS hash_val,
  CURRENT_TIMESTAMP() AS created_at
FROM UNNEST(GENERATE_ARRAY(1, 3000000)) AS n
