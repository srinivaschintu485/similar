import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# Generate clustered points on one side
np.random.seed(42)
cluster_x = np.random.normal(loc=2, scale=0.5, size=50)
cluster_y = np.random.normal(loc=2, scale=0.5, size=50)
cluster_z = np.random.normal(loc=2, scale=0.5, size=50)

# Generate scattered points on other sides
scatter_x = np.random.uniform(-3, 3, 50)
scatter_y = np.random.uniform(-3, 3, 50)
scatter_z = np.random.uniform(-3, 3, 50)

# Combine the points
x = np.concatenate([cluster_x, scatter_x])
y = np.concatenate([cluster_y, scatter_y])
z = np.concatenate([cluster_z, scatter_z])

# Create a figure for 3D plotting
fig = plt.figure(figsize=(10, 7))
ax = fig.add_subplot(111, projection='3d')

# Scatter plot the points
ax.scatter(cluster_x, cluster_y, cluster_z, color='blue', label="Clustered Points")
ax.scatter(scatter_x, scatter_y, scatter_z, color='red', label="Scattered Points")

# Define an inclined line (separating boundary)
angle = np.radians(135)  # Angle of inclination
line_x = np.linspace(-3, 5, 100)
line_y = np.linspace(-3, 5, 100)
line_z = np.tan(angle) * line_x  # Equation of inclined plane/line

# Plot the inclined line
ax.plot(line_x, line_y, line_z, color='black', linewidth=2, label="Inclined Line (Boundary)")

# Labels and title
ax.set_xlabel("X Axis")
ax.set_ylabel("Y Axis")
ax.set_zlabel("Z Axis")
ax.set_title("3D Data Points with Inclined Line")

ax.legend()
plt.show()

from pyspark.sql import SparkSession
from pyspark.sql.functions import col, udf, when, lit
from pyspark.sql.types import StringType, DoubleType, IntegerType
from Levenshtein import distance as levenshtein_distance
import re

# Initialize Spark Session
spark = SparkSession.builder.appName("LevenshteinOnly").getOrCreate()

# Load CSV File
csv_file_path = "/content/name_matching.csv"
df = spark.read.option("header", "true").csv(csv_file_path)

# Function to Normalize Text
def normalize_text(value):
    if value is None:
        return None  # Handle null values safely
    value = value.lower().strip()  # Convert to lowercase & remove extra spaces
    value = re.sub(r'\s+', ' ', value)  # Replace multiple spaces with a single space
    value = re.sub(r'[^a-zA-Z0-9\s]', '', value)  # Remove special characters (optional)
    return value

# Register UDF for Text Normalization
normalize_udf = udf(normalize_text, StringType())

# Apply Normalization to Both Columns
df = df.withColumn("Name_normalized", normalize_udf(col("Name"))) \
       .withColumn("Name_Variant_normalized", normalize_udf(col("Name_Variant")))

# Function to check if both values are applicable for similarity comparison
def is_applicable(value1, value2):
    if value1 is None or value2 is None or value1.strip() == "" or value2.strip() == "":
        return False  # Ensuring non-empty strings
    return (any(c.isalpha() for c in value1) or any(c.isdigit() for c in value1)) and \
           (any(c.isalpha() for c in value2) or any(c.isdigit() for c in value2))

# UDF to check format applicability (returns 1 for applicable, 0 otherwise)
def check_format(value1, value2):
    return 1 if is_applicable(value1, value2) else 0

format_udf = udf(check_format, IntegerType())

# Apply Format Check
df = df.withColumn("format_applicable", format_udf(col("Name_normalized"), col("Name_Variant_normalized")))

# UDF for Levenshtein Distance Calculation (Only if applicable)
def levenshtein_score(value1, value2):
    if not is_applicable(value1, value2):
        return 0  # Ensuring that invalid inputs return 0
    return float(levenshtein_distance(value1, value2))  # Explicitly converting to float for PySpark compatibility

levenshtein_udf = udf(levenshtein_score, DoubleType())

# Apply Levenshtein Distance Calculation (Only if format is applicable)
df = df.withColumn("levenshtein_score", 
                   when(col("format_applicable") == 1, levenshtein_udf(col("Name_normalized"), col("Name_Variant_normalized")))
                   .otherwise(lit(0)))

# Display Results (Ensuring full view of data)
df.show(truncate=False)

# Save Output to CSV
df.write.option("header", "true").csv("/content/levenshtein_output8.csv")


General Matching Labels
Exact Match
Partial Match
No Match
Near Match
Duplicate Entry
Text-Based Discrepancies
Typo Error
Spelling Variation
Phonetic Similarity (e.g., "Jon" vs. "John")
Abbreviation vs. Full Form (e.g., "Corp." vs. "Corporation")
Case Sensitivity Issue (e.g., "abc" vs. "ABC")
Special Character Difference (e.g., "AT&T" vs. "ATT")
Extra Space Issue (e.g., "XYZ Ltd." vs. "XYZ Ltd")
Reversed Word Order (e.g., "Bank National" vs. "National Bank")
Transposed Characters (e.g., "13579" vs. "13759")
Missing Prefix/Suffix (e.g., "LLC" missing in one column)
Encoding Issue (e.g., special symbols replaced with "�")
Multi-word vs. Single-word (e.g., "PayPal" vs. "Pay Pal")
Number-Based Discrepancies
Rounded Off Numbers (e.g., "999.99" vs. "1000")
Decimal Precision Difference (e.g., "100.1" vs. "100.10")
Leading Zero Issue (e.g., "001234" vs. "1234")
Thousands Separator Difference (e.g., "1,000" vs. "1000")
Different Currency Conversions (e.g., "USD 100" vs. "EUR 92")
Negative vs. Positive (e.g., "-500" vs. "500")
Missing or Extra Decimal Point (e.g., "1000" vs. "10.00")
Scientific Notation Difference (e.g., "1.0E3" vs. "1000")
Currency Symbol Difference (e.g., "$100" vs. "100 USD")
Interest Rate Calculation Difference (e.g., "5%" vs. "0.05")
Date & Time Discrepancies
Date Format Mismatch (e.g., "MM/DD/YYYY" vs. "DD-MM-YYYY")
Time Zone Difference (e.g., "10:00 AM EST" vs. "7:00 AM PST")
Missing Time Component (e.g., "2025-02-28" vs. "2025-02-28 12:00:00")
Date Shifted by One Day (e.g., "2025-03-01" vs. "2025-02-28")
Fiscal Year Mismatch (e.g., "Q1 2025" vs. "Q4 2024")
Leap Year Handling Issue (e.g., "Feb 29, 2024" missing)
Different Calendar Systems (e.g., "Julian" vs. "Gregorian")
AM/PM Swapped (e.g., "12:30 PM" vs. "12:30 AM")
Financial & Accounting Discrepancies
Tax Calculation Difference
Different Accounting Methods (e.g., FIFO vs. LIFO)
Rounding Adjustment
Invoice Number Mismatch
Transaction Fee Inclusion (e.g., "500" vs. "495 after fees")
Account Code Misclassification
Interest Rate Calculation Variation
Different Exchange Rate Applied
Data Entry Truncation (e.g., "1000000.00" vs. "1000000")
VAT/GST Included vs. Excluded
Payment Processing Delay (Pending vs. Completed)
Bank Reconciliation Issue
Double Entry vs. Single Entry Accounting
Identifiers & Code-Based Discrepancies
Different Account Numbers
Different Invoice Numbers
Different Transaction IDs
Vendor Name Variation
Customer Name Variation
Address Format Difference (e.g., "123 Main St." vs. "123 Main Street")
Missing/Extra Leading Zeros in Account Number
System & Data Processing Issues
Data Synchronization Delay
API Data Formatting Issue
Missing Records in One System
Manual Entry vs. Automated System Entry
Field Truncation in Database
Human-Related Entry Issues
Copy-Paste Error
Extra or Missing Digit (e.g., "1000" vs. "10000")
Input Formatting Issue (e.g., "$100.00" entered as "100,00")
Wrong Category Assigned
Misplaced Decimal (e.g., "1000.0" vs. "100.00")
Legal & Compliance Discrepancies
Regulation-Based Classification Differences
Different Financial Reporting Standards (e.g., IFRS vs. GAAP)
Fraudulent Data Manipulation Indicators
Unrecorded Transactions (Shadow Accounting)
Technical Encoding Issues
UTF-8 Encoding Issue
Different Character Encoding Used (e.g., ANSI vs. Unicode)
Multi-Language & Localization Issues
Different Currency Naming Conventions
Language-Specific Formatting Differences (e.g., "1.000,00" vs. "1,000.00")
Banking & Transaction-Specific Issues
Wire Transfer vs. ACH Transfer Differences
Processing Fee Deduction Discrepancy
Delay in Settlement Date
Budgeting & Forecasting Issues
Budgeted vs. Actual Amount Differences
Forecasted vs. Reported Values
Interest & Loan Differences
Fixed vs. Variable Interest Rates
Amortization Schedule Mismatch
Principal vs. Interest Components Misallocated
Stock & Investment-Specific Issues
Different Valuation Methods (e.g., Market Value vs. Book Value)
Stock Split Adjustments Not Applied
Dividends Included vs. Excluded in Calculation
Taxation-Specific Issues
Different Tax Rates Applied (e.g., state vs. federal)
Withholding Tax Not Accounted For
Audit & Compliance Issues
Missing Supporting Documents
Audit Trail Inconsistencies
Payroll & Salary-Specific Issues
Payroll Tax Deduction Mismatch
Bonus Calculation Error
Different Salary Structure Considerations
E-commerce & Payment Processing Issues
Chargeback Transactions Recorded Differently
Refunds Processed Differently Across Systems
Miscellaneous Issues
Data Corruption in One Column
Mismatched Interest Accrual Periods
Non-reconciled Suspense Account Entries
Incorrect Rounding Method (e.g., up vs. down rounding)
System Version Differences Affecting Calculations
User Role-Based Data Access Differences
Unverified Third-Party Data Source Discrepancy

