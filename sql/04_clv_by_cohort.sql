SELECT
    DATE_TRUNC('quarter', signup_date) AS signup_quarter,
    plan_tier,
    COUNT(*) AS customers,
    ROUND(AVG(
        CASE
            WHEN churn_date IS NOT NULL
            THEN (churn_date - signup_date) / 30.0 * mrr
            ELSE (CURRENT_DATE - signup_date) / 30.0 * mrr
        END
    ), 2) AS avg_clv
FROM customers
GROUP BY 1, 2
ORDER BY 1, avg_clv DESC;