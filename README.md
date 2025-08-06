**PySpark Multi-Dataset Discrepancy Categorization**

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

These discrepancies are systematically identified and resolved, ensuring your data remains pristine and reflective of its true value.

**Innovative Features**

**Comprehensive Discrepancy Detection:** Utilizes advanced algorithms to detect and resolve a wide spectrum of data discrepancies.

**Scalable Data Transformation:** Employs PySpark’s robust processing capabilities to manage vast datasets efficiently.

**Multi-format and Multi-sheet Compatibility:** Seamlessly integrates with both CSV and Excel formats, processing multiple sheets within Excel files to ensure comprehensive coverage.

**Advanced Currency Handling:** Supports an array of global currency symbols, enhancing the tool's utility for international financial data operations.

**Dual Processing Capabilities:** Equally adept at handling both numeric and textual data discrepancies, providing a versatile solution for diverse data challenges.

Final Model Specification (Detailed — including Independent Variables)
The final model chosen was an ensemble classifier combining Random Forest, Logistic Regression, and SVM, developed in PySpark. The primary objective of the model was to predict the root cause category of mismatches between source and target data entries — such as formatting issues, case sensitivity, rounding, currency discrepancies, and others — using a structured set of engineered features.

✅ Model Output:
The model produces a classification label (e.g., Leading Zero, Rounding, Case Sensitivity, Scientific Notation, etc.) which represents the most probable reason for the data mismatch. The output is categorical and interpretable for downstream business and quality teams.
Independent Variables Used:
Below is the full list of independent variables included in the model along with a brief description of each:
| Variable Name             | Description                                                                |
| ------------------------- | -------------------------------------------------------------------------- |
| `Perfect_match`           | Binary flag indicating exact match between source and target fields.       |
| `Leading_Zero`            | Binary indicator if mismatch is due to a leading zero in source/target.    |
| `Rounded_Off`             | Binary flag capturing mismatches due to numeric rounding.                  |
| `Currency_Diff`           | Binary flag for currency symbol or code mismatch (e.g., "\$" vs "USD").    |
| `Case_Sensitive_Score`    | Numeric score measuring case-sensitive similarity.                         |
| `Case_Insensitive_Score`  | Similarity score ignoring letter casing.                                   |
| `Case_Sensitivity_Diff`   | Derived difference between sensitive and insensitive scores.               |
| `Scientific_Notation`     | Flag for mismatch due to scientific notation format (e.g., 1.0E+03).       |
| `Space_diff`              | Flag for presence of leading/trailing/in-between space mismatches.         |
| `space_score`             | Numeric measure of string similarity after stripping spaces.               |
| `Special_Character_Diff`  | Indicator if mismatch is due to special characters (e.g., `@`, `-`, etc.). |
| `Similarity_Percentage`   | Normalized similarity score using fuzzy string logic.                      |
| `source_len`              | Length of source string (used for normalization and profiling).            |
| `destination_len`         | Length of destination string.                                              |
| `Negative_Sign_Diff`      | Flag for mismatches due to presence or absence of minus sign.              |
| `Thousand_Separator_Diff` | Flag for formatting mismatch due to commas or separators.                  |
| `Numeric_Only_Match`      | Flag that checks if numeric values match regardless of formatting.         |
| `Mismatch_Type_Encoded`   | Encoded value representing category of mismatch (used during training).    |

Total independent variables used in the final model: 18

Each of these variables was selected through a combination of domain knowledge, feature importance analysis, and model performance tests. 

Variable Transformation / Treatment
This section outlines the transformations applied to raw source and destination data to derive model features. These transformations capture formatting mismatches, representation issues, and semantic differences using a mix of rule-based and statistical techniques. Below is a detailed breakdown of each feature and how it was implemented.
| Feature                      | Description                                                            | Implementation                                                                     |   |                     |
| ---------------------------- | ---------------------------------------------------------------------- | ---------------------------------------------------------------------------------- | - | ------------------- |
| **Perfect\_match**           | 1 if source and destination are exactly equal                          | `source == destination` (string comparison after stripping spaces)                 |   |                     |
| **numeric\_check**           | 1 if both values can be parsed as numeric                              | Use `str.isdigit()` or try `float(source)`, `float(destination)` inside try/except |   |                     |
| **Scientific\_Notation**     | 1 if either value contains exponential notation like `1e3`             | Regex check for `[eE][+-]?\d+` pattern                                             |   |                     |
| **Thousand\_Separator**      | 1 if one value uses commas or dots as separators and the other doesn't | Check presence of `,` or `.` using regex or string match                           |   |                     |
| **Rounded\_Off**             | 1 if one value is a rounded version of the other (e.g., 2.99 → 3.00)   | Use `round(float(val1), 2) == round(float(val2), 2)`                               |   |                     |
| **Leading\_Zero**            | 1 if one value has a leading zero (e.g., `007` vs `7`)                 | Compare stripped integer values and detect if original has prefix `0`              |   |                     |
| **Currency\_Diff**           | 1 if one value includes currency symbol and the other doesn't          | Regex pattern like \`\$                                                            | ₹ | €\` or string match |
| **Negative\_Check**          | 1 if one value is negative and the other is not                        | Check for `'-'` presence or `float(val) < 0` mismatch                              |   |                     |
| **Case\_Sensitivity\_Diff**  | 1 if strings differ only by case                                       | `source.lower() == destination.lower()` but `source != destination`                |   |                     |
| **Special\_Character\_Diff** | 1 if mismatch caused by symbols like `@`, `#`, `-` etc.                | Clean both with regex `[^a-zA-Z0-9]`, compare result                               |   |                     |
| **Space\_diff**              | 1 if strings differ due to extra/missing spaces                        | `source.replace(" ", "") == destination.replace(" ", "")`                          |   |                     |
| Feature                                                              | Description                                      | Implementation                                                                       |
| -------------------------------------------------------------------- | ------------------------------------------------ | ------------------------------------------------------------------------------------ |
| **Similarity\_Percentage**                                           | Fuzzy match score between source and destination | Use `fuzz.ratio(source, destination)` from `fuzzywuzzy` or `difflib.SequenceMatcher` |
| **source\_len / destination\_len**                                   | Character count of raw fields                    | `len(source)` and `len(destination)`                                                 |
| **Case\_Sensitive\_Score**                                           | Match score while respecting casing              | `fuzz.ratio(source, destination)` or Levenshtein distance                            |
| **Case\_Insensitive\_Score**                                         | Match score ignoring case                        | Convert both to `.lower()` before computing similarity                               |
| **Special\_Character\_Score**                                        | Similarity after removing all symbols            | Clean using regex: `re.sub(r'[^a-zA-Z0-9]', '', val)` before matching                |
| **space\_score**                                                     | Score after removing or normalizing whitespace   | `val.strip()` or `val.replace(' ', '')` before match                                 |
| **Special\_Character\_Diff / Space\_diff / Case\_Sensitivity\_Diff** | Binary versions of the above score differences   | Derived by thresholding score difference or pattern detection                        |
 Technical Steps Applied (How It Was Achieved)
Initial Parsing & Cleaning

Strings were cleaned using standard Python methods: .strip(), .lower(), .replace().

Regex was heavily used to detect patterns: re.search() and re.sub() for scientific notation, special characters, etc.

Feature Engineering Pipeline

All features were calculated row-wise for each source-destination pair in a pandas or Spark DataFrame.

Custom Python functions were defined for each transformation, then applied using df.apply() or UDFs.

Vector Assembly

The list feature_columns was passed to VectorAssembler from PySpark:

python
Copy
Edit
assembler = VectorAssembler(inputCols=feature_columns, outputCol="features")
This created a single feature vector per row used for model training.

Missing Value Handling

Where data was invalid or missing, fallback logic was implemented:

Default to 0 for binary indicators

Use -1 or median for numeric scores

Model Input

Only features listed in the final feature_columns list were passed to the ML model.

Raw fields like source_data and destination_data were excluded from training to prevent leakage.


