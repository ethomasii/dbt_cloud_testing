{{ config(materialized='table') }}

SELECT
  a.n,
  SHA256(CONCAT(TO_HEX(a.hash_val), 'salt_b')) AS deeper_hash,
  a.created_at
FROM {{ ref('slow_a') }} AS a
