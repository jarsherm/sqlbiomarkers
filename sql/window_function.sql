SELECT *
FROM (
    SELECT
        seqn,
        age_group,
        crp,
        ROUND(AVG(crp) OVER (PARTITION BY age_group), 2) AS age_group_mean_crp,
        ROUND(PERCENT_RANK() OVER (
            PARTITION BY age_group
            ORDER BY crp
        ), 3) AS crp_percentile_in_age_group,
        ROW_NUMBER() OVER (
                PARTITION BY age_group ORDER BY crp DESC
            ) AS rn
    FROM analysis
    WHERE activity_met_min_week IS NOT NULL
        AND implausible = 0
)
WHERE rn <= 5
ORDER BY age_group, rn