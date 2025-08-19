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
| 6. Display         | Show in UI, Slack bot, or dashboard            | Streamlit, Teams, etc. |Absolutely—here’s a ready-to-drop “Data Quality Check & Cleansing” section written for your precert A I / M L mismatch-classification project, tied to the code and evidence you shared (Spark logs, the descriptive_statistics.xlsx sheet, and the feature list in your screenshots).

⸻
Block 1: Significant Events
Objective

To identify and document any events or anomalies in the dataset that could compromise data quality during preprocessing and feature engineering. Significant events include data loss, corruption, migration errors, or systematic differences in data capture that might bias the model.
Evidence from the Dataset

From the EDA and feature engineering outputs you shared, several issues were observed:
| **Data Quality Issue**              | **Count of Records Affected** | **% of Total Dataset (122,411 rows)** | **Description / Impact**                                                                                                                  |
| ----------------------------------- | ----------------------------- | ------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------- |
| **No Match**                        | 24,357                        | 20%                                   | Indicates records where `Source` and `Destination` strings had no similarity. This could represent missing mappings or faulty data joins. |
| **Negative vs Positive**            | 12,000                        | 10%                                   | Opposite sign values observed, potentially due to polarity reversal in data entry or extraction errors.                                   |
| **Thousand Separator Difference**   | 11,984                        | 10%                                   | Numeric values with inconsistent separators (`,` vs `.`), pointing to **data migration or localization issues**.                          |
| **Special Character Differences**   | 11,704                        | 10%                                   | Encoding issues or special character corruption (e.g., currency symbols, Unicode mismatches).                                             |
| **Extra Space Issues**              | 11,692                        | 10%                                   | Systematic padding or trimming problems during ingestion or migration.                                                                    |
| **Case Sensitivity Issues**         | 11,604                        | 9%                                    | Differences only in letter case, suggesting inconsistent source system standards.                                                         |
| **Leading Zero Issues**             | 10,000                        | 8%                                    | Numeric fields losing or gaining leading zeros during migration (e.g., ID `00123` becoming `123`).                                        |
| **Scientific Notation Differences** | 10,000                        | 8%                                    | Some numeric values stored in exponential form, introducing inconsistency in numerical fields.                                            |
| **Rounded Off Numbers**             | 8,987                         | 7%                                    | Precision loss identified, possibly due to truncation during ETL.                                                                         |
| **Matched (Clean Data)**            | 10,083                        | 8%                                    | Records where `Source` and `Destination` aligned correctly with no anomalies.                                                             |

Interpretation

Roughly 92% of the dataset shows at least one form of inconsistency.

The largest anomaly group is No Match (20%), which may indicate loss of mapping keys during integration between systems. This is a critical event and must be escalated to confirm whether these records represent genuine unmatched values or were introduced during migration.

Locale and encoding differences (thousand separators, special characters, scientific notation) are strong indicators of data transmission or format conversion issues during vendor integration.

Negative vs Positive mismatch suggests that polarity or transaction signs were mishandled (possibly due to different financial system conventions).

Supporting Proofs

Distribution plots from your EDA (screenshot of category counts) confirm that the anomalies are not outliers but systematic issues across 7–20% of records.

Correlation heatmap shows that anomalies such as Case Sensitivity, Special Characters, and Extra Space Issues are correlated with mismatches, confirming systemic data quality events.

Association matrix (final screenshot) also demonstrates dependency between Label (target) and issues like Thousand Separator and Case Sensitivity, validating that these events significantly affect model input integrity.
