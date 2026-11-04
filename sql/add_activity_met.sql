ALTER TABLE analysis ADD COLUMN activity_met_min_week REAL;

UPDATE analysis
SET activity_met_min_week = 
    8 * (vigorous_work_minutes + vigorous_rec_minutes)
    + 4 * (moderate_work_minutes + moderate_rec_minutes + walkbike_minutes)