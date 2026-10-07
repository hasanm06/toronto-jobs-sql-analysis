# Toronto Job Market Analysis

A SQL-based analysis of job postings in the Greater Toronto Area, identifying 
where current labour demand is concentrated across occupations and industries.

## Project Overview

This project analyzes September 2026 job postings data to answer: **where is 
job demand actually concentrated in Toronto right now, and does it match 
common assumptions about the city's labour market?**

## Data Source

- Job Postings Advertised on Canada's National Job Bank Website (September 2026) 
  — Government of Canada Open Data
- National Occupational Classification (NOC) 2021 — Statistics Canada
- 52,368 total postings nationwide, filtered to the Toronto area

## Pipeline

1. **Load** (`load_data.py`) — reads the national job postings file (tab-separated, 
   UTF-16 encoded) and the NOC classification reference file, loads both into a 
   PostgreSQL database
2. **Filter and Join** — SQL queries filter postings to the Toronto area (Toronto, 
   North York, Etobicoke, Scarborough — the pre-amalgamation City of Toronto 
   boundaries) and join postings against NOC reference data to group narrow 
   job titles into broader occupational categories
3. **Analyze** — aggregates posting counts and total vacancies by occupation, 
   broad occupational category, and industry (NAICS)

## Key Findings

- **"Information systems specialists" is the single largest specific occupation** 
  by posting count (168), but when grouped into broad categories, sales, 
  service, and care work occupations collectively account for more total 
  postings than professional/technical roles
- **"Private households" is the single largest industry** by posting volume 
  (213 vacancies) — reflecting significant demand for in-home child care and 
  support work, ahead of construction and professional/technical services
- **Construction postings have a high vacancy-to-posting ratio** (203 vacancies 
  from 97 postings), suggesting each posting tends to represent multiple 
  openings, consistent with reported labour shortages in the trades

## Recommendation

Toronto's job market in September 2026 shows the highest concentrated demand 
in professional/technical roles, but when aggregated by broad category, sales, 
service, and care work occupations collectively represent a larger share of 
total postings. This is corroborated at the industry level: "Private 
households," reflecting in home child care and support work, is the single 
largest industry by posting volume. For job seekers and workforce planners 
alike, this suggests Toronto's labour market is not purely tech driven; care 
work and service roles represent a comparably large, often overlooked segment 
of current demand.

## Known Limitations

- City filtering used "Toronto," "North York," "Etobicoke," and "Scarborough" 
  to reflect the amalgamated City of Toronto; an "Economic Region" field 
  ("Toronto Region") exists in the data and could offer a simpler alternative 
  filter in future iterations
- The NOC reference table stores occupation codes at varying digit lengths by 
  hierarchy level; joining required padding/truncating codes to match format, 
  which should be verified against NOC documentation for full accuracy
- Rows with a blank NAICS (industry) field were excluded from the industry 
  analysis rather than labeled "Unknown"
- Reflects a single month (September 2026) snapshot, not a trend over time

## Tech Stack

Python (pandas, SQLAlchemy) · PostgreSQL · pgAdmin · Git/GitHub

## Repository Structure
```
├── load_data.py
├── analysis.sql
├── job-bank-open-data-all-job-postings-en-sept2026.csv
├── noc_2021_version_1.0_-_classification_structure.csv
└── README.md
```