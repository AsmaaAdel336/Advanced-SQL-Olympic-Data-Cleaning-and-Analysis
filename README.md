# Olympic Data Cleaning and Analysis in SQL
This project demonstrates data cleaning, transformation, and analysis on a dataset of Olympic athletes and events. Using SQL, I performed advanced data wrangling to prepare the data for analysis and answered several key questions to derive insights.
---
## Project Overview
This project demonstrates the process of cleaning, transforming, and analyzing a dataset of Olympic athlete events using SQL. It includes data wrangling steps to prepare the dataset for analysis and answers key questions to gain insights into Olympic events, athletes, and countries. This project highlights SQL skills in data engineering and analysis, focusing on data quality and advanced SQL operations. 

## Table of Contents
- [Dataset](#dataset)
- [Project Goals](#project-goals)
- [Data Cleaning Steps](#data-cleaning-steps)
- [Analysis Questions](#analysis-questions)
- [Technologies Used](#technologies-used)
- [How to Use](#how-to-use)
- [Insights](#insights)
- [Future Improvements](#future-improvements)

## Dataset
The dataset used in this project is sourced from [Kaggle's Olympic Athlete Dataset](https://www.kaggle.com/heesoo37/120-years-of-olympic-history-athletes-and-results). The dataset contains information on athletes, events, teams, and medals from various Olympic Games over the years.

**Dataset Attributes**:
- `ID`: Unique identifier for each athlete
- `Name`: Athlete's name
- `Sex`: Gender of the athlete (M/F)
- `Age`: Age of the athlete
- `Height`, `Weight`: Physical measurements
- `Team`: Country the athlete represents
- `NOC`: National Olympic Committee
- `Games`: Year and season of the Olympics
- `Year`, `Season`: Year and season separated for analysis
- `City`: Host city of the Olympics
- `Sport`, `Event`: Sport and event names
- `Medal`: Medal won (Gold, Silver, Bronze, or NA)

## Project Goals
The primary objectives of this project were:
1. **Data Cleaning**: Handle missing values, split and rename columns, remove duplicates, and standardize data.
2. **Data Transformation**: Structure data in a meaningful way to support analysis.
3. **Data Analysis**: Answer specific questions to generate insights into Olympic history, athlete performance, and country participation.

## Data Cleaning Steps
The following data cleaning tasks were performed:
- **Column Renaming**: Renamed columns for clarity (e.g., `Team` to `Team Country`).
- **Splitting Columns**: Split the `Event` column into `Event Type` and `Event Name`.
- **Handling NULL Values**: Removed columns with excessive NULL values (e.g., `Height`, `Weight`).
- **Deduplication**: Removed duplicate records based on athlete names, events, and years.
- **Standardization**: Converted values in the `Sex` column from `M/F` to `Male/Female`.

## Analysis Questions
The project answers the following questions:
1. **How many Olympic Games have been held?**
2. **What are all the Olympic Games held so far?**
3. **What is the total number of nations that participated in each Olympic Game?**
4. **Which year had the highest and lowest number of countries participating?**
5. **Which nation(s) participated in all Olympic Games?**
6. **What sports were played in all Summer Olympics?**
7. **Which sports were played only once in the Olympics?**
8. **How many sports were played in each Olympic Game?**
9. **What are the details of the oldest athletes to win a gold medal?**
10. **What is the ratio of male and female athletes in all Olympic Games?**
11. **Who are the top 3 athletes with the most gold medals?**
12. **Who are the top 5 athletes with the most medals overall?**
13. **Which are the top 5 most successful countries in the Olympics based on medals won?**
14. **How many medals (Gold, Silver, Bronze) were won by each country?** 

## Technologies Used
- **SQL**: For data cleaning, transformation, and analysis.
- **DBMS**: Compatible with MySQL, PostgreSQL, SQL Server, or any SQL-based database management system.

## How to Use
1. Clone the repository:
```bash
git clone https://github.com/AsmaaAdel336/Advanced-SQL-Olympic-Data-Cleaning-and-Analysis
```
2. Load the `athlete_events.csv` dataset into your SQL database.
3. Open and execute the SQL script file `olympic_data_analysis.sql` in your SQL environment.
4. Run each query in the script to perform data cleaning and analysis.

## Insights
- **Event Trends**: Certain sports have been consistently part of every Summer Olympics, highlighting their popularity and tradition.
- **Country Performance**: Specific countries have been dominant in medal counts, showcasing their long-standing success and investment in Olympic sports.
- **Athlete Performance**: Top-performing athletes across Olympics can be identified, revealing individuals with remarkable career longevity and success.

## Future Improvements
- **Data Visualization**: Integrate visualization tools like Power BI or Tableau to better illustrate trends and insights.
- **Performance Optimization**: Add indexes and refine queries for improved performance on large datasets.
- **Advanced Analysis**: Include predictive analysis to forecast future trends in Olympic participation and medal wins.
