ALTER TABLE analysis ADD COLUMN implausible INTEGER;

UPDATE analysis
SET implausible = CASE
    WHEN (vigorous_work_minutes + moderate_work_minutes
    + vigorous_rec_minutes + moderate_rec_minutes + walkbike_minutes) > 6720 THEN 1
    ELSE 0
END;