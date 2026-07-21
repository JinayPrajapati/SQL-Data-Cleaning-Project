-- Data Cleaning

SELECT * 
FROM layoffs;

-- We are creating another table so we do not lose our original data

CREATE TABLE layoffs_staging
LIKE layoffs;

SELECT * 
FROM layoffs_staging;

INSERT layoffs_staging
SELECT *
FROM layoffs;

-- 1. Remove Duplicates

SELECT *,
ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off,
 percentage_laid_off, `date`, stage, country, funds_raised_millions) AS rn
FROM layoffs_staging; 

WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off,
 percentage_laid_off, `date`, stage, country, funds_raised_millions) AS rn
FROM layoffs_staging 
)
SELECT * 
FROM duplicate_cte
WHERE rn > 1;

-- WITH duplicate_cte AS
-- (
-- SELECT *,
-- ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off,
--  percentage_laid_off, `date`, stage, country, funds_raised_millions) AS rn
-- FROM layoffs_staging 
-- )
-- DELETE 
-- FROM duplicate_cte
-- WHERE rn > 1;
-- NOT WORK IN MYSQL BECAUSE CTE IS NOT UPDATABLE

-- We are creating a new table from layoffs_staging1 to add a row number column (rn) for removing duplicates
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
  `rn` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT * 
FROM layoffs_staging2;

INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off,
 percentage_laid_off, `date`, stage, country, funds_raised_millions) AS rn
FROM layoffs_staging;

SELECT * 
FROM layoffs_staging2
WHERE rn > 1;

DELETE 
FROM layoffs_staging2
WHERE rn > 1;

-- 2. Standardizing Data

SELECT company 
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company);

SELECT DISTINCT industry 
FROM layoffs_staging2
ORDER BY 1;

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT DISTINCT location 
FROM layoffs_staging2
ORDER BY 1layoffs;

SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY 1;

UPDATE layoffs_staging2
SET country = 'United States'
WHERE country LIKE 'United States%';

SELECT `date`, STR_TO_DATE(`date`,'%m/%d/%Y') 
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`,'%m/%d/%Y');

-- Change the data type of the date column from text to date

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

-- 3. Handle NULL or BLANK values

SELECT * 
FROM layoffs_staging2
WHERE percentage_laid_off IS NULL
AND total_laid_off IS NULL;

SELECT *
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = '';

-- Converting blank values in the industry column to NULL
UPDATE layoffs_staging2
SET industry = NULL 
WHERE industry = ''; 

SELECT * 
FROM layoffs_staging2
WHERE company = 'Airbnb';

SELECT t1.industry,t2.industry
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;
    
UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL;

-- There is still one NULL value in the industry row
SELECT * 
FROM layoffs_staging2
WHERE company LIKE 'Bally%';
-- We only have one column for this company, so we have nothing to copy from

-- Now we have some rows where both total_laid_off and percentage_laid_off are NULL
DELETE
FROM layoffs_staging2
WHERE percentage_laid_off IS NULL
AND total_laid_off IS NULL;

-- We cannot calculate the remaining NULL values for total_laid_off and percentage_laid_off 
-- because we do not have enough information

-- 4. Remove Unnecesarry column

ALTER TABLE layoffs_staging2
DROP COLUMN rn;

-- The data cleaning process is complete.

SELECT * 
FROM layoffs_staging2;