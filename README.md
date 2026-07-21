# 🧹 SQL Data Cleaning Project

## 📌 Project Overview

This project focuses on cleaning and preparing a real-world layoffs dataset using MySQL. The objective was to improve data quality by removing duplicate records, standardizing inconsistent values, handling missing data, converting date formats, and preparing the dataset for further analysis.

The project demonstrates practical SQL data cleaning techniques commonly used by Data Analysts before performing exploratory data analysis or building dashboards.

---

## 🛠️ Tools Used

- MySQL Workbench
- SQL

---

## 📂 Dataset

- **Dataset:** Layoffs Dataset
- **Type:** Real-world company layoff data

---

## 🎯 Project Objectives

- Create a staging table to preserve the original dataset
- Identify and remove duplicate records
- Standardize inconsistent data values
- Convert text dates into SQL date format
- Handle NULL and blank values
- Remove unnecessary columns
- Prepare a clean dataset for analysis

---

## 📚 SQL Concepts Used

- CREATE TABLE
- INSERT INTO
- Common Table Expressions (CTE)
- Window Functions (`ROW_NUMBER()`)
- DELETE
- UPDATE
- ALTER TABLE
- TRIM()
- STR_TO_DATE()
- CASE Statements
- NULL Handling
- Data Standardization

---

## 🔄 Data Cleaning Process

### 1. Created a Staging Table
- Copied the original table structure and data.
- Preserved the raw dataset before making changes.

### 2. Removed Duplicate Records
- Identified duplicate rows using `ROW_NUMBER()`.
- Deleted duplicate records while keeping the first occurrence.

### 3. Standardized Data
- Removed unwanted spaces using `TRIM()`.
- Corrected inconsistent values for better consistency.

### 4. Handled Missing Values
- Replaced blank values where possible.
- Updated missing records using existing data.

### 5. Removed Unnecessary Data
- Deleted rows with insufficient information.
- Dropped helper columns created during cleaning.

---

## 📈 Learning Outcomes

Through this project, I gained practical experience in:

- Cleaning real-world datasets using SQL
- Using Window Functions for duplicate detection
- Working with CTEs
- Data standardization techniques
- Handling NULL values
- Preparing datasets for exploratory data analysis

---

## 🚀 Future Improvements

- Perform Exploratory Data Analysis (EDA)
- Build Power BI Dashboard
- Create SQL Views for reporting
- Generate business insights from the cleaned dataset

---
