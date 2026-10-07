-- Toronto Job Market Analysis
-- Queries run against job_postings and noc_codes tables in PostgreSQL

-- Confirm which GTA-area cities appear in the data, and how many postings each has
SELECT DISTINCT "City", COUNT(*) 
FROM job_postings 
WHERE "City" ILIKE '%toronto%' 
   OR "City" ILIKE '%scarborough%' 
   OR "City" ILIKE '%etobicoke%' 
   OR "City" ILIKE '%north york%'
GROUP BY "City"
ORDER BY COUNT(*) DESC;

-- Top occupations in the Toronto area by posting count and total vacancies
SELECT "NOC21 Code Name", COUNT(*) AS posting_count, SUM("Vacancy Count") AS total_vacancies
FROM job_postings
WHERE "City" IN ('Toronto', 'North York', 'Etobicoke', 'Scarborough')
GROUP BY "NOC21 Code Name"
ORDER BY total_vacancies DESC
LIMIT 15;

-- Same data grouped into broader occupational categories via a join against
-- the NOC reference table. Codes are padded/truncated to 2 digits to match
-- the "Level 2" (broad category) rows in the NOC hierarchy.
SELECT n."Class title" AS broad_category, 
       COUNT(*) AS posting_count,
       SUM(j."Vacancy Count") AS total_vacancies
FROM job_postings j
JOIN noc_codes n 
  ON LEFT(CAST(j."NOC21 Code" AS TEXT), 2) = LPAD(CAST(n."Code - NOC 2021 V1.0" AS TEXT), 2, '0')
WHERE j."City" IN ('Toronto', 'North York', 'Etobicoke', 'Scarborough')
  AND n."Level" = '2'
GROUP BY n."Class title"
ORDER BY total_vacancies DESC
LIMIT 15;

-- Top industries (NAICS) by posting count and total vacancies
SELECT "NAICS", COUNT(*) AS posting_count, SUM("Vacancy Count") AS total_vacancies
FROM job_postings
WHERE "City" IN ('Toronto', 'North York', 'Etobicoke', 'Scarborough')
  AND "NAICS" IS NOT NULL
  AND "NAICS" != ''
GROUP BY "NAICS"
ORDER BY total_vacancies DESC
LIMIT 15;