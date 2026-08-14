{{ config(materialized='table') }}

SELECT
  b.n,
  SHA256(CONCAT(TO_HEX(b.deeper_hash), 'salt_c')) AS deepest_hash,
  b.created_at
FROM {{ ref('slow_b') }} AS b
