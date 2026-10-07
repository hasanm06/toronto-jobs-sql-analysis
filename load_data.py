import pandas as pd
from sqlalchemy import create_engine

engine = create_engine("postgresql+psycopg2://postgres:%24Bufferzone06@localhost:5432/toronto_jobs")

jobs = pd.read_csv("job-bank-open-data-all-job-postings-en-sept2026.csv", encoding="utf-16", sep="\t")
noc = pd.read_csv("noc_2021_version_1.0_-_classification_structure.csv", encoding="utf-8-sig")

print(jobs.columns.tolist())
print(noc.columns.tolist())
print(jobs.shape)

jobs.to_sql("job_postings", engine, if_exists="replace", index=False)
noc.to_sql("noc_codes", engine, if_exists="replace", index=False)

print("Loaded into Postgres!")