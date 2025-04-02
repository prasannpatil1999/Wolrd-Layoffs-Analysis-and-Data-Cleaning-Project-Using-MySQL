-- EXPLORATORY DATA ANALYSIS

SELECT *
FROM layoffs_staging2

-- Maximum laid off in a day
select max(total_laid_off),max(percentage_laid_off)
from layoffs_staging2

-- Where 100% of employees were laid off
select *
from layoffs_staging2
where percentage_laid_off = 1
order by total_laid_off desc

-- Total laid off by comapnies
select company,sum(total_laid_off) as total_lay_off_by_company
from layoffs_staging2
group by company
order by total_lay_off_by_company desc

-- Get date range
select min(date) as start_date ,max(date) as end_date
from layoffs_staging2

-- Total laid off by industry
select industry,sum(total_laid_off) as total_lay_off_by_company
from layoffs_staging2
group by industry
order by total_lay_off_by_company desc

-- Total laid off by country
select country,sum(total_laid_off) as total_lay_off_by_company
from layoffs_staging2
group by country
order by total_lay_off_by_company desc

-- Total laid off by year
select YEAR(date),sum(total_laid_off) as total_lay_off_by_company
from layoffs_staging2
group by YEAR(date)
order by total_lay_off_by_company desc

-- Total laid off by stage
select stage,sum(total_laid_off) as total_lay_off_by_company
from layoffs_staging2
group by stage
order by total_lay_off_by_company desc

-- Total laid off by MONTH
select SUBSTRING(date,1,7) AS date_format,sum(total_laid_off) as total_lay_off_by_company
from layoffs_staging2
where `date` is not null
group by date_format WITH ROLLUP
order by date_format 

-- Total laid off by companies by year
select company,YEAR(`date`) AS year,sum(total_laid_off) as total_lay_off_by_company
from layoffs_staging2
group by company, year
order by company

-- Maximum laid off by a company in a year
select company,YEAR(`date`) AS year,MAX(total_laid_off) as max_lay_off_by_company
from layoffs_staging2
group by company, year
order by max_lay_off_by_company DESC

-- Ranking companies by Maximum laid off by a in a year
SELECT company,year,max_lay_off_by_company,RANK() OVER (ORDER BY max_lay_off_by_company DESC) AS ranking
FROM 
(
SELECT company,YEAR(date) AS year,MAX(total_laid_off) AS max_lay_off_by_company
FROM layoffs_staging2
where `date` is not null
GROUP BY company, year
) AS subquery
ORDER BY ranking;

-- END