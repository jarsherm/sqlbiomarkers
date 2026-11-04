CREATE TABLE analysis AS
SELECT
    d.SEQN AS seqn,
    d.RIDAGEYR AS age,
    CASE
        WHEN d.RIDAGEYR < 40 THEN '18-39'
        WHEN d.RIDAGEYR < 60 THEN '40-59'
        WHEN d.RIDAGEYR < 80 THEN '60-79'
        ELSE '80+'
    END AS age_group,
    CASE
        WHEN d.RIAGENDR = 1 THEN 'male'
        WHEN d.RIAGENDR = 2 THEN 'female'
    END AS sex,
    b.BMXBMI AS bmi,
    c.LBXHSCRP AS crp,
    g.LBXGH AS hba1c,
    CASE
        WHEN p.PAQ605 = 2 THEN 0
        WHEN p.PAQ605 = 1 AND p.PAD615 IS NOT NULL
            AND p.PAQ610 BETWEEN 1 AND 7
            AND p.PAD615 < 7777 THEN p.PAQ610 * p.PAD615
        ELSE NULL
    END AS vigorous_work_minutes,
    CASE
        WHEN p.PAQ620 = 2 THEN 0
        WHEN p.PAQ620 = 1 AND p.PAD630 IS NOT NULL
            AND p.PAQ625 BETWEEN 1 AND 7
            AND p.PAD630 < 7777 THEN p.PAQ625 * p.PAD630
        ELSE NULL
    END AS moderate_work_minutes,
    CASE
        WHEN p.PAQ635 = 2 THEN 0
        WHEN p.PAQ635 = 1 AND p.PAD645 IS NOT NULL
            AND p.PAQ640 BETWEEN 1 AND 7
            AND p.PAD645 < 7777 THEN p.PAQ640 * p.PAD645
        ELSE NULL
    END AS walkbike_minutes,
    CASE
        WHEN p.PAQ650 = 2 THEN 0
        WHEN p.PAQ650 = 1 AND p.PAD660 IS NOT NULL
            AND p.PAQ655 BETWEEN 1 AND 7
            AND p.PAD660 < 7777 THEN p.PAQ655 * p.PAD660
        ELSE NULL
    END AS vigorous_rec_minutes,
    CASE
        WHEN p.PAQ665 = 2 THEN 0
        WHEN p.PAQ665 = 1 AND p.PAD675 IS NOT NULL
            AND p.PAQ670 BETWEEN 1 AND 7
            AND p.PAD675 < 7777 THEN p.PAQ670 * p.PAD675
        ELSE NULL
    END AS moderate_rec_minutes,
    CASE WHEN p.PAD680 < 7777 THEN p.PAD680 END AS sedentary_minutes,
    d.WTMEC2YR            AS weight,
    d.SDMVPSU             AS psu,
    d.SDMVSTRA            AS strata
FROM demo_j AS d
LEFT JOIN bmx_j   AS b ON d.SEQN = b.SEQN
LEFT JOIN hscrp_j AS c ON d.SEQN = c.SEQN
LEFT JOIN ghb_j   AS g ON d.SEQN = g.SEQN
LEFT JOIN paq_j   AS p ON d.SEQN = p.SEQN
WHERE d.RIDAGEYR >= 18
  AND c.LBXHSCRP IS NOT NULL
  AND g.LBXGH IS NOT NULL