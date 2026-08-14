{{ config(materialized='table') }}

-- Section 4: `monitor_runs=True` streaming test. Chain of three slow models
-- gives Dagster enough time between per-model completions to visibly stream
-- AssetMaterialization events mid-run. Each model is ~5-10s on BigQuery.
--
-- BigQuery caps GENERATE_ARRAY at ~1M elements — use CROSS JOIN of two smaller
-- arrays to reach a few million rows without hitting the limit.

SELECT
  a.n * 1000 + b.n AS n,
  SHA256(CAST(a.n * 1000 + b.n AS STRING)) AS hash_val,
  CURRENT_TIMESTAMP() AS created_at
FROM UNNEST(GENERATE_ARRAY(1, 2000)) AS a(n)
CROSS JOIN UNNEST(GENERATE_ARRAY(1, 1000)) AS b(n)
