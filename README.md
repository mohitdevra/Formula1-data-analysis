🏎️ Formula 1 Data Analysis — SQL Project

📌 Overview

This project analyses Formula 1 racing data using MySQL to uncover insights about drivers, constructors, races, circuits, championships, podiums, wins, points, and driver performance across seasons.

The project focuses on using SQL to answer practical analytical questions from historical Formula 1 data and storing the resulting datasets for further analysis and visualisation.

---

🎯 Project Objectives

The main objectives of this project are to:

•⁠  ⁠Analyse driver and constructor performance.
•⁠  ⁠Identify the most successful drivers and constructors.
•⁠  ⁠Analyse race wins, podiums, starts, and championship points.
•⁠  ⁠Compare driver performance across seasons.
•⁠  ⁠Analyse improvements and declines in race positions.
•⁠  ⁠Explore circuit and race-related patterns.
•⁠  ⁠Practice intermediate and advanced SQL concepts.
•⁠  ⁠Generate reusable result datasets for future visualisation.

---

🗂️ Project Structure

formula1-data-analysis/
│
├── data/
│   └── raw/
│
├── results/
│   ├── previous_race_finishing_position.csv
│   ├── race_to_race_pos_improvement.csv
│   ├── running_championship_points.csv
│   ├── top_10_circuits_most_f1_races_hosted.csv
│   ├── top_10_constructors_most_podiums.csv
│   ├── top_10_constructors_most_race_wins.csv
│   ├── top_10_drivers_most_podiums.csv
│   ├── top_10_drivers_most_race_starts.csv
│   ├── top_10_drivers_most_race_wins.csv
│   ├── total_points_scored_by_constructors.csv
│   └── ...
│
├── sql/
│   └── analysis.sql
│
└── README.md

Folder Description

"data/"
Contains the original/raw Formula 1 datasets used for the analysis.

"sql/"
Contains the SQL queries used to perform the analysis.

"results/"
Contains the output datasets generated from the SQL queries. These results can be used for reporting, visualisation, or further analysis.

---

🛠️ Tools & Technologies

•⁠  ⁠MySQL — Data analysis and querying
•⁠  ⁠SQL — Data manipulation and analysis
•⁠  ⁠DBeaver — Database management and query execution
•⁠  ⁠Git & GitHub — Version control and project sharing
•⁠  ⁠CSV — Result dataset storage

---

📊 Analysis Performed

The project covers multiple analytical questions related to Formula 1.

🏁 Driver Performance

Analysis includes:

•⁠  ⁠Top drivers by race wins
•⁠  ⁠Top drivers by podium finishes
•⁠  ⁠Drivers with the most race starts
•⁠  ⁠Driver performance across races
•⁠  ⁠Race-to-race position improvements
•⁠  ⁠Previous race finishing positions
•⁠  ⁠Best and worst season performance

🏆 Constructor Performance

Analysis includes:

•⁠  ⁠Constructors with the most race wins
•⁠  ⁠Constructors with the most podiums
•⁠  ⁠Total points scored by constructors
•⁠  ⁠Constructor performance across seasons

​￼​ Race & Circuit Analysis

Analysis includes:

•⁠  ⁠Circuits that have hosted the most F1 races
•⁠  ⁠Race results and finishing positions
•⁠  ⁠Driver performance between consecutive races
•⁠  ⁠Championship points progression

📈 Championship Analysis

The project also analyzes championship performance by tracking points and rankings throughout seasons.

---

🧠 SQL Concepts Used

This project was built to practice real-world SQL analytical techniques, including:

•⁠  ⁠"SELECT"
•⁠  ⁠"WHERE"
•⁠  ⁠"GROUP BY"
•⁠  ⁠"HAVING"
•⁠  ⁠"ORDER BY"
•⁠  ⁠Aggregate functions
•⁠  ⁠"CASE"
•⁠  ⁠"JOIN"
•⁠  ⁠Subqueries
•⁠  ⁠Common Table Expressions ("CTEs")
•⁠  ⁠Window functions
•⁠  ⁠"RANK()"
•⁠  ⁠"DENSE_RANK()"
...

---

🔍 Example Analysis

One example is identifying driver performance by combining a driver's first and last name:

CONCAT(forename, ' ', surname) AS driver_name

Window functions were also used to rank drivers, constructors, and seasonal performances without losing the underlying row-level information.

For example:

DENSE_RANK() OVER (
    PARTITION BY season
    ORDER BY points DESC
)

This allows drivers to be ranked within each Formula 1 season.

---

📁 Result Datasets

The SQL queries generate separate CSV files containing the results of individual analyses.

Examples include:

•⁠  ⁠"top_10_drivers_most_race_wins.csv"
•⁠  ⁠"top_10_drivers_most_podiums.csv"
•⁠  ⁠"top_10_drivers_most_race_starts.csv"
•⁠  ⁠"top_10_constructors_most_race_wins.csv"
•⁠  ⁠"top_10_constructors_most_podiums.csv"
•⁠  ⁠"top_10_circuits_most_f1_races_hosted.csv"
•⁠  ⁠"total_points_scored_by_constructors.csv"
•⁠  ⁠"race_to_race_pos_improvement.csv"
•⁠  ⁠"previous_race_finishing_position.csv"
•⁠  ⁠"running_championship_points.csv"

These datasets provide a clean separation between the SQL analysis layer and the analysis results.

---

💡 Key Insights

Some of the questions explored through this project include:

 1.⁠ ⁠Which drivers have achieved the most race wins?
 2.⁠ ⁠Which drivers have achieved the most podium finishes?
 3.⁠ ⁠Which drivers have started the most races?
 4.⁠ ⁠Which constructors have the most race wins?
 5.⁠ ⁠Which constructors have the most podium finishes?
 6.⁠ ⁠Which circuits have hosted the most Formula 1 races?
 7.⁠ ⁠How have championship points progressed throughout a season?
 8.⁠ ⁠How much have drivers improved their finishing positions from one race to the next?
 9.⁠ ⁠What was a driver's previous race finishing position?
10.⁠ ⁠How do driver performances vary across different seasons?
11.⁠ ⁠Which constructors have accumulated the most points?
12.⁠ ⁠Which drivers and constructors consistently perform at the top level?

The complete SQL queries and generated result datasets are available in this repository.

---

🚀 What I Learned

Through this project, I practiced applying SQL to a real-world dataset rather than solving isolated SQL exercises.

The main learning outcomes were:

•⁠  ⁠Translating business-style questions into SQL queries.
•⁠  ⁠Working with multiple related datasets.
•⁠  ⁠Using joins to combine information from different tables.
•⁠  ⁠Applying window functions for ranking and sequential analysis.
•⁠  ⁠Using CTEs and subqueries to break complex problems into manageable steps.
•⁠  ⁠Generating analysis-ready result datasets.
•⁠  ⁠Structuring and documenting a data analytics project.
•⁠  ⁠Using Git and GitHub to manage and present project work.

---

🔮 Future Improvements

This project currently focuses on SQL-based analysis.

Possible future improvements include:

•⁠  ⁠Building an Excel dashboard using selected result datasets.
•⁠  ⁠Creating a Power BI dashboard for interactive visualisation.
•⁠  ⁠Adding additional driver and constructor performance metrics.
•⁠  ⁠Creating visual comparisons across seasons.
•⁠  ⁠Adding more advanced analytical questions where useful.

---

👤 Author

Mohit Devra

Aspiring Data Analyst focused on SQL, Excel, Power BI, and Python.

---

⭐ Project Status

Completed — SQL Analysis Phase

The SQL analysis and result datasets for the current scope of the project are complete. Further visualisation work can be developed separately using the generated result datasets.
