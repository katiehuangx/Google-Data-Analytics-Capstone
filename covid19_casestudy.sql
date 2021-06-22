USE covid19;

DESC klse_index;
DESC covid19;

-- convert date from TEXT to DATE format
UPDATE klse_index
SET date = STR_TO_DATE(date,'%d/%m/%Y');

-- convert date from TEXT to DATE format
UPDATE covid19
SET date = STR_TO_DATE(date,'%d/%m/%Y');

-- Looking at Total Cases vs Total Deaths
-- Show the likelihood of dying if you contract Covid-19
-- Insights: Highest % on 2020-04-28 with 100 deaths and 5,851 cases
SELECT date, total_cases, total_deaths, (total_deaths/total_cases) * 100 AS death_perc
FROM covid19
ORDER BY death_perc DESC;

-- Looking at Total Cases vs Population
-- Show the percentage of population contracting Covid-19
-- Insights: Hits 1% on 2021-03-14, 2% on 2021-06-12
SELECT date, total_cases, population, (total_cases/population) * 100 AS pop_perc
FROM covid19
ORDER BY date;

-- Looking at New Cases vs Total Cases
-- Show the percentage of new cases against total cases
-- Insights: Highest # of cases of 2021-06-03 with 8,209 cases
SELECT c.date, c.new_cases, c.total_cases, (c.new_cases/c.total_cases) * 100 AS new_cases_perc
FROM covid19 AS c
ORDER BY new_cases DESC;

-- Looking at Highest Death Count per Day
-- Insights: 
SELECT total_deaths
FROM covid19
ORDER BY total_deaths DESC;

-- Retrieved important lockdown dates
-- MCO 1.0 18 Mar 2020 - 3 May 2020
-- MCO 2.0 11 Jan 2021 - 31 May 2021
-- MCO 3.0 1 Jun 2021 - 28 Jun 2021

-- Looking at New Cases vs KLSE Index Price
-- Shows the impact of Covid-19 cases on index prices during MCO 1.0
-- Insight: KLSE prices badly impacted during MCO 1.0 with new cases rate at 14%
SELECT c.date, c.total_cases, c.new_cases, k.close, (new_cases/total_cases) * 100 AS new_cases_perc
FROM covid19 AS c
LEFT JOIN klse_index AS k
USING (date)
WHERE c.date BETWEEN '2020-03-18' AND '2020-05-03'
ORDER BY c.date;

-- Shows the impact of Covid-19 cases on index prices during MCO 2.0
-- Insight: No impact on index prices during MCO 2.0. New cases rate averaging 1-2%
SELECT c.date, c.total_cases, c.new_cases, k.close, (new_cases/total_cases) * 100 AS new_cases_perc
FROM covid19 AS c
LEFT JOIN klse_index AS k
USING (date)
WHERE c.date BETWEEN '2021-01-11' AND '2021-05-31'
ORDER BY c.date;

-- Shows the impact of Covid-19 cases on index prices during MCO 3.0
-- Insight: No impact on index prices during MCO 2.0. New cases rate averaging 0-1%
SELECT c.date, c.total_cases, c.new_cases, k.close, (new_cases/total_cases) * 100 AS new_cases_perc
FROM covid19 AS c
LEFT JOIN klse_index AS k
USING (date)
WHERE c.date BETWEEN '2021-05-31' AND '2021-06-20'
ORDER BY c.date;




