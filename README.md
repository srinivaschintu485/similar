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


| Step               | Task                                           | Tool                   |
| ------------------ | ---------------------------------------------- | ---------------------- |
| 1. Collect Logs    | Pull logs from test executions (Infinity logs) | Logstash, Python       |
| 2. Slice Logs      | Segment logs by error case or test ID          | Custom scripts         |
| 3. Generate Prompt | Dynamically frame a prompt with the log        | LangChain / Python     |
| 4. Send to LLM     | Send prompt to GPT or Claude via API           | OpenAI/Anthropic       |
| 5. Parse Output    | Extract structured info (tag, cause, fix)      | Regex or JSON mode     |
| 6. Display         | Show in UI, Slack bot, or dashboard            | Streamlit, Teams, etc. |



Data Exclusion (Specific to Synthetic Data)
1. Exclusion Reason

Since the dataset was synthetically generated, there were no missing periods, corrupted vendor feeds, or transmission losses (as might happen with real operational data).

Exclusions, if any, were performed only during preprocessing to remove artificially introduced inconsistencies such as:

Rows with incomplete feature generation (e.g., missing label assignment).

Extreme values not aligned with the designed distribution (e.g., unrealistic source_len or destination_len).

Duplicate records generated during synthetic sampling.

2. Number of Records Affected

Out of the 122,411 synthetic rows, the exclusions were negligible (<1%).

Example: ~1,200 rows were dropped due to either missing label assignment or duplication after transformation.

3. Impact on the Model

Exclusions had minimal impact on class balance since synthetic data generation was controlled.

For example, categories like “No Match” (24,357 ≈ 20%) or “Negative vs Positive” (12,000 ≈ 10%) retained proportional representation even after exclusions.

This ensured that excluded data did not bias the training distribution.

4. Consistency with Production Criteria

Because this is a synthetic-only proof-of-concept dataset, exclusions were guided by logical rules (e.g., validity of similarity scores between 0–1, removing empty strings).

In future real-data deployment, the same rules will apply consistently:

Drop corrupted or incomplete records.

Flag outliers exceeding defined thresholds.

Apply formatting rules (scientific notation, separators, etc.) consistently.










