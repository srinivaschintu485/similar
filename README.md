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



Model Performance – Explanation of Metrics
The model performance was evaluated using four key metrics:

Accuracy – The percentage of total predictions that were correct across all classes. An accuracy of 100% means every record was classified into the correct discrepancy category without error.

Precision – The ratio of correctly predicted positive observations to the total predicted positives. In this context, it measures how often the model’s predicted category was actually correct. A 100% precision means there were no false positives for any category.

Recall – The ratio of correctly predicted positives to all actual positives. Here, it measures how many of the actual discrepancies in a category were successfully identified by the model. 100% recall means no category instances were missed.

F1-Score – The harmonic mean of precision and recall. It balances the trade-off between precision and recall, especially important when class distributions are imbalanced. 100% F1-score indicates perfect balance — every category was captured without false positives or false negatives.

Why Random Forest Was Chosen
During the model selection phase, three algorithms were evaluated: Random Forest, Logistic Regression, and Linear SVM. While both Random Forest and Logistic Regression achieved perfect scores across all metrics, Random Forest was selected for production due to the following advantages:

Robustness to Feature Interactions – Random Forest naturally captures non-linear relationships and complex feature interactions without requiring extensive manual feature engineering. This is especially valuable for discrepancy detection, where subtle data format differences may not follow linear patterns.

Resistance to Overfitting – By averaging results from multiple decision trees, Random Forest reduces the likelihood of overfitting to the training data, ensuring stable performance across varied input datasets.

Explainability – The model provides feature importance scores, making it easier to understand which engineered features (e.g., extra space indicators, thousand separator checks) contributed most to the prediction. This aligns with the requirement for explainable AI in regulated environments like Citi.

Consistent High Performance Across Categories – Random Forest maintained perfect accuracy, precision, recall, and F1-scores across all 11 discrepancy categories, whereas Linear SVM showed slightly lower results (98.3% accuracy).

Scalability in Spark Environment – Random Forest integrates efficiently with Apache Spark ML, enabling large-scale, distributed training and inference, which is critical for enterprise-wide data reconciliation processes.
