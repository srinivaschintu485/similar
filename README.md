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

Definition:
The dependent variable for this model is the classification outcome of structured data comparisons between source and target systems. Each record pair is assigned to one of several predefined categories that indicate whether the fields match exactly (Good) or differ due to a specific type of discrepancy (Bad).

Good: Records classified as Matched (i.e., no differences identified across compared fields).

Bad: Records with mismatches across predefined discrepancy categories, including No Match, Negative vs Positive, Thousand Separator Difference, Special Character Differences, Case Sensitivity, Extra Space Issues, Leading Zero Issue, Scientific Notation Difference, and Rounded Off Numbers.

Indeterminate: Not applicable for this development dataset, as all synthetic samples were labeled deterministically.

Performance Window:
The development (DEV) dataset is based on synthetically generated samples created in June 2025 to simulate reconciliation mismatches across typical operational scenarios. The out-of-time (OOT) dataset was generated separately in August 2025 to validate model stability and generalization.

Summary Statistics of the Dependent Variable

| Performance Definition        | DEV Sample (#/%)                                                       | OOT Sample (#/%)                 |
| ----------------------------- | ---------------------------------------------------------------------- | -------------------------------- |
| Good (Matched)                | 10,083 (≈8%)                                                           | \[To be filled with OOT results] |
| Bad (All mismatch categories) | 112,328 (≈92%)                                                         | \[To be filled with OOT results] |
| Indeterminate                 | 0 (0%)                                                                 | N/A                              |
| Performance Window            | DEV: Synthetic data (Jun 2025)<br>OOT: Synthetic validation (Aug 2025) | —                                |


Justification

The chosen dependent variable is directly aligned with the model’s objective: to detect and explain field-level mismatches between structured datasets. By consolidating “Good” as matched records and “Bad” as all categories of mismatches, the dependent variable provides a clear binary framework while still supporting multi-class analysis at the category level.

The distribution demonstrates that the dataset is imbalance-prone (8% Good vs. 92% Bad), which justifies the use of ensemble ML techniques and weighted evaluation metrics. This ensures the model does not become biased toward the majority (mismatch) classes and maintains interpretability across all mismatch types.
