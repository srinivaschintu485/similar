**Overview**

Welcome to the cutting-edge PySpark Multi-Dataset Discrepancy Categorization tool, a pinnacle of data integrity and discrepancy resolution technology. This innovative project leverages the power of Apache Spark to sift through complex, multi-format datasets, pinpointing and classifying a diverse array of discrepancies that can undermine data reliability and accuracy. Our tool explores beyond the surface to address deep-rooted data inconsistencies originating from diverse sources and formats, including CSV and Excel, through a meticulously designed analytical engine.


**Discrepancy Types Addressed:**

**Leading Zero Issues:** Safeguarding numeral integrity by preserving significant zeroes.

**Decimal Precision Differences**: Aligning decimal accuracy across data points.

**Thousands Separator Differences:** Standardizing numerical formatting across locales.

**Scientific Notation Differences:** Ensuring uniform expression of scientific figures.

**Currency Symbol Differences:** Facilitating accurate financial data analysis with threshold validation.

**Rounded Off Numbers:** Addressing variations in rounding practices that impact data interpretation.

**Abbreviation vs. Full Form Differences:** Harmonizing terminological inconsistencies.

**Case Sensitivity Issues:** Rectifying discrepancies arising from text case variations.

**Extra Space Issues:** Cleansing data of superfluous spacing for precision.

**Special Character Differences:** Unifying textual data that includes diverse character sets.

import pandas as pd
import oracledb
import numpy as np
import re
from datetime import datetime

# ------------------------------------------------------------------
# Target Database Connection Details
# ------------------------------------------------------------------
db_username_tgt = "DSVAL_OLYMPUS_PRECERT"
db_password_tgt = "YOUR_PASSWORD"

db_host_tgt = "oraasmwp162-scan.nam.nsroot.net"
db_port_tgt = 8889
db_service_name_tgt = "GENUADA"

dsn_tgt = f"{db_host_tgt}:{db_port_tgt}/{db_service_name_tgt}"

# ------------------------------------------------------------------
# Configuration
# ------------------------------------------------------------------
CSV_FILE_PATH = r"C:\Users\SP58868\dq-analyzer\178144.jedi.dq-exception-analyzer\OM_ARRANGEMENT_CAT_FACT.csv"

TARGET_TABLE_NAME = "OM_ARRANGEMENT_CAT_FACT_AGENT1"

print("=" * 80)
print(f"CSV File      : {CSV_FILE_PATH}")
print(f"Target Table  : {TARGET_TABLE_NAME}")
print("=" * 80)

# ------------------------------------------------------------------
# Read CSV
# ------------------------------------------------------------------
print("\nReading CSV...")

df = pd.read_csv(
    CSV_FILE_PATH,
    keep_default_na=False,
    dtype=str
)

print(f"Rows    : {len(df)}")
print(f"Columns : {len(df.columns)}")

# ------------------------------------------------------------------
# Clean Column Names
# ------------------------------------------------------------------
def clean_column(col):
    col = col.upper().strip()
    col = re.sub(r'[^A-Z0-9_]', '_', col)
    return col[:30]

df.columns = [clean_column(c) for c in df.columns]

# ------------------------------------------------------------------
# Infer Oracle Datatypes
# ------------------------------------------------------------------
def infer_oracle_type(series):

    # Remove blanks
    values = series.replace("", np.nan).dropna()

    if len(values) == 0:
        return "VARCHAR2(4000)"

    # Integer?
    try:
        values.astype(int)
        return "NUMBER"
    except:
        pass

    # Float?
    try:
        values.astype(float)
        return "NUMBER"
    except:
        pass

    # Date?
    try:
        pd.to_datetime(values, errors="raise")
        return "DATE"
    except:
        pass

    max_len = max(values.astype(str).str.len())

    if max_len < 1:
        max_len = 1

    if max_len > 4000:
        return "CLOB"

    return f"VARCHAR2({max_len})"

column_types = {}

for col in df.columns:
    column_types[col] = infer_oracle_type(df[col])

print("\nDetected Schema")
for k, v in column_types.items():
    print(f"{k:30} {v}")

# ------------------------------------------------------------------
# Create Table SQL
# ------------------------------------------------------------------
column_sql = []

for col, dtype in column_types.items():
    column_sql.append(f'"{col}" {dtype}')

create_sql = f"""
CREATE TABLE {TARGET_TABLE_NAME}
(
    {', '.join(column_sql)}
)
"""

print("\nCreate SQL")
print(create_sql)

# ------------------------------------------------------------------
# Connect Oracle
# ------------------------------------------------------------------
print("\nConnecting to Oracle...")

conn = oracledb.connect(
    user=db_username_tgt,
    password=db_password_tgt,
    dsn=dsn_tgt
)

cursor = conn.cursor()

print("Connected.")

# ------------------------------------------------------------------
# Drop Table if Exists
# ------------------------------------------------------------------
try:
    cursor.execute(f"DROP TABLE {TARGET_TABLE_NAME}")
    conn.commit()
    print("Existing table dropped.")
except:
    print("Table does not exist. Creating new table.")

# ------------------------------------------------------------------
# Create Table
# ------------------------------------------------------------------
cursor.execute(create_sql)
conn.commit()

print("Table created successfully.")

# ------------------------------------------------------------------
# Prepare Insert
# ------------------------------------------------------------------
placeholders = ", ".join([f":{i+1}" for i in range(len(df.columns))])

column_list = ", ".join([f'"{c}"' for c in df.columns])

insert_sql = f"""
INSERT INTO {TARGET_TABLE_NAME}
(
{column_list}
)
VALUES
(
{placeholders}
)
"""

print("\nInsert SQL")
print(insert_sql)

# ------------------------------------------------------------------
# Convert Data for Oracle
# ------------------------------------------------------------------
rows = []

for _, row in df.iterrows():

    values = []

    for col in df.columns:

        val = row[col]

        if val == "":
            values.append(None)

        elif column_types[col] == "NUMBER":
            try:
                if "." in str(val):
                    values.append(float(val))
                else:
                    values.append(int(val))
            except:
                values.append(None)

        elif column_types[col] == "DATE":
            try:
                values.append(pd.to_datetime(val).to_pydatetime())
            except:
                values.append(None)

        else:
            values.append(str(val))

    rows.append(tuple(values))

# ------------------------------------------------------------------
# Bulk Insert
# ------------------------------------------------------------------
print(f"\nLoading {len(rows)} rows...")

cursor.executemany(insert_sql, rows)

conn.commit()

print(f"\nSUCCESS!!")
print(f"{len(rows)} rows inserted into {TARGET_TABLE_NAME}")

# ------------------------------------------------------------------
# Verify
# ------------------------------------------------------------------
cursor.execute(f"SELECT COUNT(*) FROM {TARGET_TABLE_NAME}")

count = cursor.fetchone()[0]

print(f"Total rows in table : {count}")

cursor.close()
conn.close()

print("\nCompleted Successfully.")
