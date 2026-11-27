SELECT
    t.feat_name,
    LOWER(t.dtype) AS dtype,
    ROUND(AVG(t.avg_val), 2) AS avg_val,
    ROUND(AVG(t.null_pct), 2) AS null_pct
FROM ml_features t
WHERE t.source = 'transactions'

    AND NOT EXISTS (
        SELECT 1
        FROM ml_features p
        WHERE p.source IN ('page_views', 'ad_impressions')
          AND p.feat_name = t.feat_name
          AND LOWER(p.dtype) = LOWER(t.dtype)
    )

GROUP BY
    t.feat_name,
    LOWER(t.dtype);
