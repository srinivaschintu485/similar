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




The final set of variables was chosen to balance both domain interpretability and predictive performance. Variables were engineered to directly capture known sources of reconciliation mismatches such as:

textual differences (e.g., extra spaces, case sensitivity, special characters),

numeric formatting discrepancies (e.g., leading zero, rounding, scientific notation),

and semantic differences (e.g., negative vs. positive sign mismatches, thousand separator inconsistencies).

During feature evaluation, three model families were benchmarked: Random Forest, Support Vector Machines (SVM-OVR), and Logistic Regression. Each algorithm was tested under a wide range of hyperparameter settings (iterations, depth, criterion, learning rates, etc.), with metrics recorded for every configuration.

Random Forest: Delivered the strongest performance with peak accuracy 1.000 at configuration (nTrees=50, depth=15, criterion=gini). Across multiple runs, accuracy consistently remained above 0.995, demonstrating robustness to parameter variation. Confusion matrices indicated near-perfect classification of all mismatch categories, with precision, recall, and F1 all equal to 1.0 at best configuration.

SVM-OVR: Achieved competitive results with best accuracy 0.983, precision 0.984, recall 0.983, and F1 score 0.983 at (C=200, gamma=0.0001, kernel=rbf). While slightly weaker than Random Forest, SVM maintained interpretability for margin-based separation across mismatch types.

Logistic Regression: Also performed strongly, reaching 1.000 accuracy, precision, recall, and F1 at (maxIter=200, regParam=0.0001, elasticNet=1.0). This highlighted the linear separability of many engineered features, although it risked overfitting without regularization.

Model selection rationale:
While all three models performed exceptionally well on synthetic data, the Random Forest model was chosen as the final specification due to:

Consistency across hyperparameter settings, showing less sensitivity to tuning.

Better generalization to nonlinear feature interactions (e.g., multiple mismatch causes in a single record).

Interpretability at the categorical level, as feature importance rankings align with known mismatch drivers (leading zeros, rounding, etc.).

Thus, the final Random Forest specification was adopted with parameters (50 trees, depth=15, criterion=gini). Logistic Regression and SVM results are preserved as benchmarks and serve as secondary validation that model outputs remain stable across different algorithmic classes.
