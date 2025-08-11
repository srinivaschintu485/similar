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



Model Framework (Enhanced)
The Precert–AIML system is an automated pipeline that compares structured data from source and target systems to identify and classify discrepancies. It uses Apache Kafka for metadata ingestion, Apache Spark for processing and feature engineering, and a Random Forest classifier for prediction. The framework is designed for scalability, traceability, and explainability.

Step 1 – Parsing and Processing
The system ingests data from source and target files in formats such as .xlsx, .csv, and .txt. File metadata is captured, and data is normalized for further processing.

Step 2 – Preprocessing and Feature Engineering
The pipeline applies preprocessing logic to transform raw data into engineered features relevant for classification. This includes:

Removing extra spaces

Standardizing number formats

Handling thousand separators and currency symbols

Case normalization

Extracting indicators for specific known mismatch patterns

Step 3 – Classification
While several machine learning models (e.g., Linear SVC, Logistic Regression, XGBoost) were evaluated during development, Random Forest was selected for production based on superior accuracy, stability, and interpretability.
The model predicts one of over 11 predefined discrepancy categories, such as:

Leading Zero Issue: 00755275 vs 755275

Rounded-off Numbers: 5501.01 vs 5501

Scientific Notation Difference: 1.2e3 vs 1200

Currency Symbol Difference: $1,000 vs 1,000.00 USD

Negative vs Positive: -123 vs 123

Case Sensitivity Issue: Savings Account vs SAVINGS ACCOUNT

Extra Space Issue: Routing Number:123456789 vs Routing Number: 123456789

Special Character Difference: Password@123 vs Password 123

Matched / No Match for complete agreement or entirely unmatched records

Step 4 – Probability Threshold Check
If the model outputs a prediction probability lower than a set threshold, the case is flagged as an "Untrained / Unknown Classification". A message is attached stating that the discrepancy type was not part of the training dataset, prompting analysts to review it and potentially include it in future training cycles.

Step 5 – Output and Downstream Integration
Final predictions (including confidence scores and unknown classification flags) are exported in Excel format. The output layout matches the original input structure, enabling easy traceability. Results integrate with reconciliation workflows, allowing business users and data stewards to:

Quickly address common discrepancies

Prioritize manual review for low-confidence predictions

Feed new discrepancy types back into the model lifecycle
