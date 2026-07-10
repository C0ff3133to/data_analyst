-- Data Cleaning project with commentary

SELECT *
FROM layoffs;

-- Strategy for Data Cleaning
-- 1. Remove Duplicates
-- 2. Standardize the Data such as spelling
-- 3. Null Values or Blank Values
-- 4. Remove Any Columns (Blank ones)

CREATE TABLE layoffs_staging
LIKE layoffs;

SELECT *
FROM layoffs_staging;

INSERT layoffs_staging
SELECT *
FROM layoffs;

-- 1. Remove Duplicates
-- where a 2 show up in row_num will be marked as a duplicate
SELECT *,
ROW_NUMBER() OVER(PARTITION BY company, industry, total_laid_off, percentage_laid_off, `date`) AS row_num
FROM layoffs_staging;

-- Display duplicates only
WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, 
industry, total_laid_off, percentage_laid_off, `date`, stage, 
country, funds_raised_millions) AS row_num
FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

-- Checking specific companies to see if my query above was precise enough
-- Added stage, country, funds_raised_millions as duplicates ended up as unique ones
SELECT *
FROM layoffs_staging
WHERE company = 'Casper';

-- Delete duplicates query (not to use yet)
WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, 
industry, total_laid_off, percentage_laid_off, `date`, stage, 
country, funds_raised_millions) AS row_num
FROM layoffs_staging
)
DELETE
FROM duplicate_cte
WHERE row_num > 1;

-- Right click layoffs_staging > Copy to CLipboard > Create Statement
-- Paste
-- Adding `row_num` INT after funds_raised_millions
-- Rename it to layoffs_staging2
-- Run the query

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Returns empty table with row_num added as column
-- Return all duplicates
SELECT *
FROM layoffs_staging2
WHERE row_num > 1;

INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY company, location, 
industry, total_laid_off, percentage_laid_off, `date`, stage, 
country, funds_raised_millions) AS row_num
FROM layoffs_staging;

-- Deletes the duplicates (check so safe updates is unchecked in preferencies) 
DELETE
FROM layoffs_staging2
WHERE row_num > 1;

-- Check so the table is empty = success
SELECT *
FROM layoffs_staging2
WHERE row_num > 1;

-- view new updated table with no duplicates
SELECT *
FROM layoffs_staging2;

-- 2. Standardize the Data

-- company had space in front of first letter so I'm trimming it
SELECT company, TRIM(company)
FROM layoffs_staging2;

-- Replacing company rows with the trimmed version which corrected 22 rows
UPDATE layoffs_staging2
SET company = TRIM(company);

-- Resulted with 1 NUll and 1 blank cell and 3 different industries involving crypto
SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY 1;

-- Showing all alternatives starting with Crypto
-- Run this query again after updating industry name to see result
SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';

-- Updating the industry name for Crypto, affecting 6 rows
UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT DISTINCT industry
FROM layoffs_staging2;

-- checking with no issues
SELECT DISTINCT location
FROM layoffs_staging2
ORDER BY 1;

-- Issues with multiple ways of writing United States
SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY 1;

SELECT *
FROM layoffs_staging2
WHERE country LIKE 'United States%'
ORDER BY 1;

-- Trimming with trailing where I define to get rid of '.' from country
-- Run this again after using Update from below to see if the update went through
SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM layoffs_staging2
ORDER BY 1;

UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

-- Next issue is that date is in text format
-- COnverting it date format in wanted order
SELECT `date`,
STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoffs_staging2;

-- update corrected 4712 rows
UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

-- some nulls do still exist which I'm taking a note of
-- data set is still in text format
SELECT `date`
FROM layoffs_staging2;

-- Modifying column into date (make sure it's on stage!)
-- 4712 rows affected again, aka same amount got modified!
-- Checking layoffs_staging2 object info and date is now in date format!
ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

-- Looking in what to correct next
SELECT *
FROM layoffs_staging2;

-- 3. Null Values or Blank Values

-- Double NULL is a little big weird. Will come back to this later!
SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- Airbnb resulted with empty row for industry so will dig further for that company
SELECT *
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = '';

-- Other rows for Airbnb showed that the industry is Travel whcih we want to populate all Airbnb with
SELECT *
FROM layoffs_staging2
WHERE company = 'Airbnb';

-- SHowing all companies where first industry is either blank or NULL
-- We also check where second industry is not null nor blank
SELECT *
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;

-- first update version changed 0 rows
UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;

-- 6 rows affected with method 2
UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = '';

UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

-- Airbnb is now populated with Travel!
SELECT *
FROM layoffs_staging2
WHERE company = 'Airbnb';

-- Bally's Interactive is the last one where Industry is NULL 
SELECT *
FROM layoffs_staging2
WHERE company LIKE 'Bally%';

-- Seeing companies where total_laid_off and percentage_laid_off both being NULL, we can't work with that = solution to delete those
DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- Checking so the update went through. 722 rows affected
SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

-- New updated data set
SELECT *
FROM layoffs_staging2;

-- 4. Remove Any Columns (Blank ones)

-- Let's drop the row_num now as we no longer need it
ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

-- The data is now clean!
-- Thank you for going through this process with me.
-- If curious to get in contact with me, you can find me on LinkedIn here: https://www.linkedin.com/in/christopher-wijk-karlsson/