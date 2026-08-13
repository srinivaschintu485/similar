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



# Generic Banking Data Quality Validation Prompt

You are an expert Banking Data Quality and Data Validation Analyst.

I will provide an Excel or CSV file containing banking-related data. Analyze the file systematically and identify potential data-quality, consistency, formatting, and business-rule issues.

Your objective is to identify issues that a banking organization would reasonably want to detect during data-quality validation. Do not assume that a specific column such as "Amount", "Balance", or "Percentage" is the only important field. The validation must be as generic and attribute-independent as possible.

## 1. Understand the File

First inspect:

* Sheet names
* Column names
* Number of rows and columns
* Data types
* Unique values
* Null/blank patterns
* Duplicate patterns
* Repeated groups or corresponding records
* Relationships between columns
* Relationships between rows
* Potential business keys
* Potential identifiers
* Potential amount, currency, date, percentage, status, account, transaction, and reference fields

Do not modify the original data.

## 2. Perform Data Quality Checks

Check the data for the following categories.

### A. Missing / Blank Values

Identify:

* Blank/null values
* Unexpectedly missing values
* Columns with unusually high null percentages
* Important attributes that are partially populated

Do not automatically classify every blank as an error. Determine whether the blank appears anomalous based on the surrounding data.

### B. Partial Population Across Corresponding Records

For each attribute, identify cases where:

* The attribute is populated in one corresponding row/type/record
* But the same attribute is blank/null in another corresponding row/type/record
* The records belong to the same logical group

Example:

Record A → Customer Type = ABC, Amount = 100
Record B → Customer Type = ABC, Amount = blank

Highlight this as a "Partial Population / Cross-Record Inconsistency" issue.

If all corresponding records are populated, do not flag it.

If all corresponding records are blank, do not flag it under this rule.

This rule must work generically for ANY attribute. Do not limit it to Amount, Balance, Percentage, etc.

### C. Duplicate Data

Identify:

* Exact duplicate rows
* Duplicate business keys
* Duplicate transaction/reference identifiers
* Unexpected repeated records

Distinguish between legitimate repeated records and suspicious duplicates when possible.

### D. Data Type and Format Validation

Identify:

* Numeric fields containing unexpected text
* Date fields with invalid formats
* Inconsistent date formats
* Unexpected characters
* Leading/trailing spaces
* Hidden/special characters
* Inconsistent capitalization
* Unexpected symbols

### E. Numeric and Amount Validation

For numeric/financial fields check:

* Invalid numeric values
* Unexpected negative values
* Unexpected zero values
* Excessive decimal precision
* Inconsistent decimal precision
* Scientific notation such as E-10 when inappropriate
* Unexpected rounding
* Values outside the apparent business range
* Extremely small or extremely large values
* Inconsistent numeric formatting

Do not automatically consider a negative number invalid. Determine whether negative values appear legitimate based on the attribute and surrounding data.

### F. Currency Validation

For currency-related attributes check:

* Missing currency
* Invalid currency codes
* Inconsistent currency representation
* Currency symbols mixed with numeric values
* Inconsistent currency across corresponding records
* Currency/amount mismatches

Recognize that representations such as `$24.36`, `24.36 USD`, and `USD 24.36` may represent the same underlying value. Distinguish formatting differences from actual data-quality problems.

### G. Decimal Precision

Identify attributes where values contain excessive decimal places.

Report:

* Attribute name
* Actual decimal precision
* Typical precision observed
* Maximum precision observed
* Potentially problematic values

Do not assume that 2 decimal places is always correct. Determine the expected precision from the data pattern where possible, and explicitly mark the result as "Potential Issue" when the expected precision cannot be established.

### H. Cross-Row / Cross-Attribute Consistency

Look for logical inconsistencies between related records or attributes.

Examples:

* Same entity has conflicting values
* Related records have inconsistent attributes
* One record is populated while its corresponding record is blank
* Related status/value combinations don't make sense
* Related identifiers do not match

### I. Pattern and Structural Validation

Detect recurring patterns such as:

* Account/reference identifiers
* Transaction identifiers
* Customer identifiers
* Date patterns
* Code formats
* Status values
* Currency codes
* Percentage formats
* Numeric formats

Identify values that deviate from the dominant pattern.

### J. Outlier / Anomaly Detection

Identify values that are significantly different from the normal population.

Consider:

* Statistical outliers
* Unusually high/low amounts
* Unexpected frequency
* Unusual changes within a group
* Unexpected changes across periods

Do not automatically classify an outlier as an error. Label it as an anomaly requiring review when business validity cannot be established.

## 3. Color Coding

Highlight the ORIGINAL data cells containing issues.

Use different colors for different issue categories:

* RED = Critical / invalid data
* ORANGE = Cross-record or partial-population inconsistency
* YELLOW = Formatting, numeric, amount, precision, or currency issue
* PURPLE = Duplicate or unexpected repetition
* BLUE = Pattern, format, or standardization issue
* BROWN = Outlier/anomaly requiring review
* GREEN = Valid / passed validation, only if useful

Do not overwrite the original values.

If a row contains multiple issues, highlight the specific cells responsible for each issue rather than coloring the entire row whenever possible.

If one cell has multiple issue types, use the highest-severity color and document the additional issue types in the findings report.

## 4. Create a Validation Summary

Create a separate "DQ_Summary" sheet containing:

| Issue ID | Sheet | Row | Column | Attribute | Issue Category | Issue Description | Current Value | Expected/Observed Pattern | Severity | Recommendation |
| -------- | ----- | --- | ------ | --------- | -------------- | ----------------- | ------------- | ------------------------- | -------- | -------------- |

Every highlighted issue must have a corresponding entry in this summary.

## 5. Create an Issue Statistics Section

Provide:

* Total rows
* Total columns
* Total issues
* Issues by category
* Issues by severity
* Columns with the highest number of issues
* Null percentage by important attributes
* Duplicate count
* Number of partial-population inconsistencies
* Number of formatting issues
* Number of numeric/amount issues
* Number of anomalies

## 6. Important Reasoning Rules

Do not invent business rules that cannot reasonably be inferred from the data.

For every potential issue:

1. Identify the pattern.
2. Explain why it may be a data-quality problem.
3. Compare it with related records where possible.
4. Distinguish a true data problem from a presentation/formatting difference.
5. If the expected business rule cannot be determined, classify it as "Potential Issue – Business Confirmation Required."

Be conservative: do not flag legitimate banking data simply because it looks unusual.

The goal is to produce a practical banking Data Quality assessment that a data analyst can review and use for follow-up with the business/data owners.

## 7. Final Output

Return:

1. The validated Excel file with cell-level color highlighting.
2. A DQ_Summary sheet containing every identified issue.
3. A concise overall assessment.
4. The top 10 most important issues requiring business attention.
5. A list of assumptions where the expected business rule could not be determined.

