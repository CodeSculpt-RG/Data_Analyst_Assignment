Data Analyst Assignment: Round 1 Submission 🚀This repository contains the complete solution for the Data Analyst Assignment, covering SQL Proficiency, Python Proficiency, and Spreadsheet Proficiency.📁 1. Project StructureThe project files are logically organized into the following directories:Data_Analyst_Assignment/
├── SQL/                   # Database schema definitions and analytical queries.
├── Python/                # Python scripts for programming challenges.
└── Spreadsheets/          # Analysis workbook (Ticket_Analysis) or documentation of link.
2. SQL Proficiency (Queries & Setup)This section includes the SQL code necessary for setting up the required database schemas and executing the analytical queries.Files & PurposeFilenamePurposeContents01_Hotel_Schema_Setup.sqlSchema & Data InsertionCreates users, bookings, and booking_commercials tables.02_Hotel_Queries.sqlAnalytical QueriesContains the five required analysis queries for the Hotel Management System (e.g., last booked room, total billing, item ordering analysis).03_Clinic_Schema_Setup.sqlSchema & Data InsertionCreates doctors, clinic_sales, and expenses tables.04_Clinic_Queries.sqlAnalytical QueriesContains the five required analysis queries for the Clinic System (e.g., top-performing doctors, monthly sales analysis).Execution Guide for ReviewerThe queries are designed to be run sequentially using a MySQL/MariaDB client:Bash# Set up the database (run once)
mysql -u [user] -p -e "CREATE DATABASE assignment_db; USE assignment_db;"

# Run Hotel setup and queries
mysql -u [user] -p assignment_db < SQL/01_Hotel_Schema_Setup.sql
mysql -u [user] -p assignment_db < SQL/02_Hotel_Queries.sql

# Run Clinic setup and queries
mysql -u [user] -p assignment_db < SQL/03_Clinic_Schema_Setup.sql
mysql -u [user] -p assignment_db < SQL/04_Clinic_Queries.sql
3. Python Proficiency (Scripting)This section contains the Python solutions for the two programming challenges.Files & LogicFilenameChallengeKey Logic01_Time_Converter.pyConvert total minutes to X hrs Y minutes.Uses integer division (//) and the modulo operator (%) to accurately calculate hours and remaining minutes.02_Remove_Duplicates.pyRemove duplicate characters from a string.Uses a loop to iterate through the input string, building a new string only with characters not yet seen.4. Spreadsheet Proficiency (Analysis)The required ticket analysis was completed in a dedicated spreadsheet workbook.DeliverableThe completed analysis is available in the Ticket_Analysis workbook.Solution SummaryQuestionSolution MethodKey Formula1. Populate ticket_created_atData LookupVLOOKUP (or XLOOKUP) linking cms_id in feedbacks to created_at in the ticket sheet.2. Count Created AND ClosedConditional CountingEmploys Helper Columns (INT(), HOUR()) for time comparison, followed by the COUNTIFS function for outlet-wise filtering and aggregation.
