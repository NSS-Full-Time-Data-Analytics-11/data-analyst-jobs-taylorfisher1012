--How many rows are in the data_analyst_jobs table?
SELECT COUNT(*) AS row_count
FROM data_analyst_jobs;

--Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row?
--Answer: ExxonMobil
SELECT * 
FROM data_analyst_jobs
LIMIT 10;

--How many postings are in Tennessee? How many are there in either Tennessee or Kentucky?
--Answer: 21 jobs in TN and 27 jobs in TN or KY
SELECT COUNT(title) AS jobs_in_tn
FROM data_analyst_jobs
WHERE location = 'TN';

SELECT COUNT(location) AS jobs_tn_ky
FROM data_analyst_jobs
WHERE location = 'TN' OR location = 'KY';

--How many postings in Tennessee have a star rating above 4?
--Answer: 3 
SELECT COUNT(title)
FROM data_analyst_jobs
WHERE star_rating > 4 
	AND location = 'TN';

--How many postings in the dataset have a review count between 500 and 1000?
--Answer: 151
SELECT COUNT(title)
FROM data_analyst_jobs
WHERE review_count BETWEEN 500 AND 1000;

--Show the average star rating for companies in each state. The output should show the state as state and the average rating for the state as avg_rating. Which state shows the highest average rating?
--Answer:Nebraska (NE)
SELECT location AS state, AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
WHERE location IS NOT NULL
GROUP BY location
ORDER BY avg_rating DESC;

--Select unique job titles from the data_analyst_jobs table. How many are there?
--Answer: 881
SELECT COUNT(DISTINCT(title)) AS unique_jobs
FROM data_analyst_jobs;

--How many unique job titles are there for California companies?
--Answer: 230 unique jobs in CA
SELECT COUNT(DISTINCT(title)) AS unique_jobs_ca
FROM data_analyst_jobs
WHERE location = 'CA';

--Find the name of each company and its average star rating for all companies that have more than 5000 reviews across all locations. How many companies are there with more that 5000 reviews across all locations?
--Answer: 40 companies
SELECT company,AVG(star_rating)
FROM data_analyst_jobs
WHERE review_count > 5000 
	AND company IS NOT NULL
GROUP BY company;

--Add the code to order the query in #9 from highest to lowest average star rating. Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? What is that rating?
--Answer:Unilever with a rating of 4.199
SELECT company,AVG(star_rating)
FROM data_analyst_jobs
WHERE review_count > 5000 
	AND company IS NOT NULL
GROUP BY company
ORDER BY AVG(star_rating) DESC;

--Find all the job titles that contain the word ‘Analyst’. How many different job titles are there?
--Answer: 1754
SELECT COUNT(title) AS analyst_jobs
FROM data_analyst_jobs
WHERE title LIKE '%Analyst%' OR title LIKE '%Analytics%';

--How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? What word do these positions have in common?
--Answer: They all include data and/or a visualization
SELECT title
FROM data_analyst_jobs
WHERE title NOT LIKE '%Analyst%'
	AND title NOT LIKE '%Analytics%'
	AND title NOT LIKE '%ANALYST%'
	AND title NOT LIKE '%analyst%'
	AND title NOT LIKE '%ANALYTICS%';
	
--You want to understand which jobs requiring SQL are hard to fill. Find the number of jobs by industry (domain) that require SQL and have been posted longer than 3 weeks.
SELECT domain, COUNT(title) AS num_jobs
FROM data_analyst_jobs
WHERE CASE WHEN days_since_posting > 21 
	AND skill LIKE '%SQL%'
	AND domain IS NOT NULL THEN 'keep'
	ELSE 'Discard' END='keep'
GROUP BY domain
ORDER BY COUNT(title) DESC;

	