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



1. Correlation Heatmap (Numerical Dependencies)

The correlation heatmap you provided (blue–red matrix) measures Pearson correlation between numerical features such as Scientific_Notation, Thousand_Separator, Rounded_Off, Case_Sensitive_Score, etc.

Key Observations

High positive correlation:

Case_Sensitive_Score ↔ Case_Insensitive_Score (~0.80): indicates these two features capture highly related transformations of string similarity.

Special_Character_Score ↔ Special_Character_Diff (~0.79): confirms strong dependency between the presence and the difference count of special characters.

Rounded_Off ↔ Thousand_Separator (~0.56): suggests systematic formatting differences are often accompanied by rounding errors — typical of migration from one number system to another.

Moderate negative correlation:

Case_Sensitivity_Diff ↔ Case_Sensitive_Score (≈ -0.43): as expected, higher differences reduce similarity scores.

Negative_Check ↔ Case_Sensitive_Score (≈ -0.41): polarity mismatches are often tied to broader formatting issues.

Interpretation

The systematic clusters in the heatmap (e.g., case-related features grouping together, special character features aligning) confirm that anomalies are not random.

This supports the hypothesis of systemic data quality events (e.g., vendor systems encoding differently, or ETL pipelines mishandling number formats).

For Block 1’s "significant events", this validates that case, spacing, special characters, and numeric formatting issues stem from consistent patterns across the dataset, not isolated errors.

2. Association Matrix (Categorical Dependencies)

The association matrix you provided (blue squares + circle overlay) goes beyond correlations to measure categorical associations (uncertainty coefficient & correlation ratio).

Key Observations

High association with Label:

Perfect_match and No_Match categories show the strongest associations (as expected).

Thousand_Separator, Rounded_Off, and Scientific_Notation show medium-level associations with Label, proving that formatting inconsistencies directly influence classification outcomes.

Cross-feature associations:

source_len ↔ destination_len shows significant dependency: mismatched string lengths often explain No_Match or formatting-related differences.

Space_diff ↔ Case_Sensitivity_Diff: whitespace issues frequently co-occur with capitalization mismatches.

Interpretation

The association matrix strengthens the causal link: anomalies like separators, case sensitivity, and spaces don’t just exist in isolation — they explain target label mismatches.

This proves that data loss/corruption events in migration directly influence the ability to classify correctly, and must be cleansed before modeling.
