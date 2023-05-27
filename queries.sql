-- SPECIFIC QUERIES
-- Written as individual views

-- 1. Count highest population of data (all artifacts)
DROP VIEW IF EXISTS highest_pop;
CREATE VIEW highest_pop AS
SELECT COUNT(*)
FROM ARTIFACT;
SELECT * FROM highest_pop;

-- 2. List all exhibits
DROP VIEW IF EXISTS all_exhibits;
CREATE VIEW all_exhibits AS
SELECT EID, Exhibit_Name
FROM Exhibit
ORDER BY EID;
SELECT * FROM all_exhibits;

-- 3. Show exhibits and which sections they belong to
DROP VIEW IF EXISTS sectioned_exhibits;
CREATE VIEW sectioned_exhibits AS
SELECT Exhibit_Name, SID
FROM (Exhibit AS E) JOIN (Section AS S) ON E.EID = S.EID
ORDER BY Exhibit_Name;
SELECT * FROM sectioned_exhibits;

-- 4. Show a cost
# Our database does not support actual monetary costs of our business. 
# However, we wrote a query that still uses aggregate functions.
DROP VIEW IF EXISTS avg_artifacts;
CREATE VIEW avg_artifacts AS
SELECT AVG(Count_Artifact_Per_Exhibit) AS Average_Artifacts_Per_Exhibit
FROM (SELECT COUNT(*) AS Count_Artifact_Per_Exhibit
    FROM (Exhibit AS E) JOIN (Artifact AS A) ON E.EID = A.EID
    GROUP BY E.EID) AS Exhibits_Artifacts;
SELECT * FROM avg_artifacts;

-- 5. Show currently active exhibits
DROP VIEW IF EXISTS active_exhibits;
CREATE VIEW active_exhibits AS
	SELECT EID, Exhibit_name, Start_date, End_date
    FROM Exhibit
	WHERE (Start_date < NOW())
    AND (End_date > NOW())
    ORDER BY Start_date ASC;
SELECT * FROM active_exhibits;