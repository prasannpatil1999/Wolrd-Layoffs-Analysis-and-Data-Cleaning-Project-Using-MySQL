-- DATA CLEANING

use world_layoffs;

select *
from layoffs;

select count(*)
from layoffs;

-- Remove Duplicates
-- Standardize data (check for spelling mistakes)
-- Remove Null or Blank values
-- Remove cols and rows if needed

-- STAGING TABLE
-- In below code we copied data from raw table into staging table (copied original data source into a new table)
-- So any changes made doesn't affect origianl table

-- Creates table with name and gets col names from specified (layoffs) table as col names
create table layoffs_staging
like layoffs
-- Take a look at table
select *
from layoffs_staging;
-- Inserting records from lkayoffs atble into staging table
INSERT layoffs_staging
select *
from layoffs
-- Take a look at STAGING table
select *
from layoffs_staging;

-- REMOVE DUPLICATES

-- Sub Query
SELECT company, location, industry, total_laid_off,percentage_laid_off,`date`, stage, country, funds_raised_millions,
		ROW_NUMBER() OVER (
			PARTITION BY company, location, industry, total_laid_off,percentage_laid_off,`date`, stage, country, funds_raised_millions
			) AS row_num
	FROM 
		world_layoffs.layoffs_staging

SELECT *
FROM (
	SELECT company, location, industry, total_laid_off,percentage_laid_off,`date`, stage, country, funds_raised_millions,
		ROW_NUMBER() OVER (
			PARTITION BY company, location, industry, total_laid_off,percentage_laid_off,`date`, stage, country, funds_raised_millions
			) AS row_num
	FROM 
		world_layoffs.layoffs_staging
) duplicates
WHERE 
	row_num > 1;
    
-- these are the ones we want to delete where the row number is > 1 or 2or greater essentially

-- now you may want to write it like this:
WITH DUPLICATE_CTE AS 
(
SELECT *
FROM (
	SELECT company, location, industry, total_laid_off,percentage_laid_off,`date`, stage, country, funds_raised_millions,
		ROW_NUMBER() OVER (
			PARTITION BY company, location, industry, total_laid_off,percentage_laid_off,`date`, stage, country, funds_raised_millions
			) AS row_num
	FROM world_layoffs.layoffs_staging
) duplicates
)
SELECT *
FROM DUPLICATE_CTE
WHERE row_num > 1;

-- Remove Duplicates from DUPLICATE_CTE
WITH DUPLICATE_CTE AS 
(
SELECT *
FROM (
	SELECT company, location, industry, total_laid_off,percentage_laid_off,`date`, stage, country, funds_raised_millions,
		ROW_NUMBER() OVER (
			PARTITION BY company, location, industry, total_laid_off,percentage_laid_off,`date`, stage, country, funds_raised_millions
			) AS row_num
	FROM world_layoffs.layoffs_staging
) duplicates
)
DELETE FROM DUPLICATE_CTE
WHERE row_num > 1;

-- As we saw from Above code that is DELETE statemet is UPDATE statement and can't be executed
-- So we will create Staging2 table and then will delete from there
-- We created a new column called row_num
CREATE TABLE `world_layoffs`.`layoffs_staging2` (
`company` text,
`location`text,
`industry`text,
`total_laid_off` INT,
`percentage_laid_off` text,
`date` text,
`stage`text,
`country` text,
`funds_raised_millions` int,
row_num INT
);

-- Check for staging2 table
select * 
from layoffs_staging2

-- INSERT data into layoffs_staging2
INSERT INTO `world_layoffs`.`layoffs_staging2`
SELECT `company`,
`location`,
`industry`,
`total_laid_off`,
`percentage_laid_off`,
`date`,
`stage`,
`country`,
`funds_raised_millions`,
		ROW_NUMBER() OVER (
			PARTITION BY company, location, industry, total_laid_off,percentage_laid_off,`date`, stage, country, funds_raised_millions
			) AS row_num
	FROM 
		world_layoffs.layoffs_staging;
                
-- Check for staging2 table again
SELECT * 
FROM layoffs_staging2

-- Here are our duplicates
SELECT *
FROM world_layoffs.layoffs_staging2
WHERE row_num >= 2;

-- now that we have this we can delete rows were row_num is greater than 2
DELETE FROM world_layoffs.layoffs_staging2
WHERE row_num >= 2;

-- Check whether staging2 table still contains duplicate values
SELECT *
FROM world_layoffs.layoffs_staging2
WHERE row_num >= 2;

-- 2. Standardize Data

SELECT * 
FROM world_layoffs.layoffs_staging2;

-- Company column
-- if we look at "company "col we have _ Included Health but is should be just  Included Health
SELECT DISTINCT(company)
FROM world_layoffs.layoffs_staging2
ORDER BY company;
-- side by side col comparison
SELECT company,trim(company)
FROM world_layoffs.layoffs_staging2
-- Update col
UPDATE layoffs_staging2
SET company = TRIM(company)
-- Check col again
SELECT DISTINCT(company)
FROM world_layoffs.layoffs_staging2

-- industry column
-- if we look at industry it looks like we have some null and empty rows, let's take a look at these
SELECT DISTINCT industry
FROM world_layoffs.layoffs_staging2
ORDER BY industry;

SELECT *
FROM world_layoffs.layoffs_staging2
WHERE industry LIKE "Crypto%"
-- Update col
UPDATE layoffs_staging2
SET industry = "Crypto"
WHERE industry LIKE "Crypto%"
-- Check col again
SELECT DISTINCT industry
FROM world_layoffs.layoffs_staging2
ORDER BY industry;


-- location
-- nothing wrong
SELECT DISTINCT location
FROM world_layoffs.layoffs_staging2
ORDER BY location;


-- country
-- We have Unite States and unites States., so just have Uniotes States
SELECT DISTINCT country
FROM world_layoffs.layoffs_staging2
ORDER BY country;
-- Shows records where problem is
SELECT *
FROM world_layoffs.layoffs_staging2
WHERE country LIKE "United States%"
-- Update col
UPDATE layoffs_staging2
SET country = "United States"
WHERE country LIKE "United States%"
-- Check col again
SELECT DISTINCT country
FROM world_layoffs.layoffs_staging2
ORDER BY country;


-- date
-- change `date` col from text data type to date data type
SELECT `date`
FROM world_layoffs.layoffs_staging2
ORDER BY `date`;
-- This is how it would look after update
SELECT `date`,STR_TO_DATE(`date`, '%m/%d/%Y')
FROM world_layoffs.layoffs_staging2
ORDER BY `date`;
-- Update col
-- we can use str to date to update this field
UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');
-- Check col again
SELECT `date`
FROM world_layoffs.layoffs_staging2
ORDER BY `date`;
-- 'date' col is still text data type, change it to date data type
-- NOTE: Earlier date col was text data type and wasn't in date format, 
-- at this point if we tried to turn that into date data type that would have thrown error
-- After changing 'date' col in date format change data type from TEXT to DATE data type
-- now we can convert the data type properly
ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

-- STEP3: DEALING with NULL and BLANK values
-- If total_laid_off and percentage_laid_off cols are null they that record is pretty useless
SELECT *
FROM world_layoffs.layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- industry col
SELECT *
FROM world_layoffs.layoffs_staging2
WHERE industry IS NULL OR industry = ""

-- let's look at company col
-- For company Airbnb it has Travel industry but it doesn't appear everywhere where company "Airbnb" appears
-- so see and change that
SELECT *
FROM world_layoffs.layoffs_staging2
WHERE company ="Airbnb"

-- we should set the blanks to nulls since those are typically easier to work with
UPDATE world_layoffs.layoffs_staging2
SET industry = NULL
WHERE industry = '';
-- look at industry col to confirm the update from BLANK to NULL vlaues
SELECT *
FROM world_layoffs.layoffs_staging2
WHERE industry IS NULL OR industry = ""
ORDER BY industry;

-- now we need to populate those nulls if possible
-- Code that just show what result would look like

-- Here we join a Table with itself
SELECT *
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
ON t1.company = t2.company AND t1.location = t2.location
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

-- Update "industry" column
UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
ON t1.company = t2.company  AND t1.location = t2.location
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

-- Check if we filled NULL or BLANK values of industry col?
--  and if we check it looks like Bally's was the only one without a populated row to populate this null values
SELECT *
FROM world_layoffs.layoffs_staging2
WHERE industry IS NULL 
OR industry = ''
ORDER BY industry;

-- the null values in total_laid_off, percentage_laid_off, and funds_raised_millions all look normal. I don't think I want to change that
-- I like having them null because it makes it easier for calculations during the EDA phase

-- so there isn't anything I want to change with the null values


-- 4. remove any columns and rows we need to

-- If total_laid_off and percentage_laid_off cols are null they that record is pretty useless
-- Delete Rows
SELECT *
FROM world_layoffs.layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- Delete Useless data we can't really use
DELETE FROM world_layoffs.layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;
-- Check to confirm delete
SELECT *
FROM world_layoffs.layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- Check table
SELECT *
FROM world_layoffs.layoffs_staging2

-- Delete Cols
ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

-- Check table
SELECT *
FROM world_layoffs.layoffs_staging2







