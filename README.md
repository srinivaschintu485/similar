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



Random Forest (Finalized)

Hyperparameters Tuned:

Number of Trees (n_estimators): 50, 100, 150, 200

Maximum Depth (maxDepth): 5, 10, 15, 20

Criterion: gini, entropy

Finalized Selection:

Best Model: Random Forest

Best Parameters: (50, 15, 'gini', 1) → meaning 50 trees, depth 15, gini criterion

Performance: Accuracy = 1.000, Precision = 1.000, Recall = 1.000, F1 Score = 1.000

🔹 SVM (One-vs-Rest)

Hyperparameters Tuned:

Regularization (C): 0.0001, 0.001, 0.01, 0.1, 1.0

Kernel coefficient (gamma): 1e-05, 0.0001, 0.001, 0.01

Maximum Iterations (max_iter): 50, 100, 200

Finalized Selection:

Best Model: SVM (OVR)

Best Parameters: (200, 0.0001, 0.0001) → meaning max_iter=200, C=0.0001, gamma=0.0001

Performance: Accuracy = 0.983, Precision = 0.984, Recall = 0.983, F1 Score = 0.983

🔹 Logistic Regression

Hyperparameters Tuned:

Regularization strength (C): 0.0001, 0.001, 0.01, 0.1, 1.0

Penalty: L2

Solver: LBFGS (default)

Maximum Iterations (max_iter): 50, 100, 150, 200

Finalized Selection:

Best Model: Logistic Regression

Best Parameters: (200, 0.0001, 1.0) → meaning max_iter=200, C=0.0001, L2 penalty

Performance: Accuracy = 1.000, Precision = 1.000, Recall = 1.000, F1 Score = 1.000

| Algorithm               | Hyperparameters Tuned                              | Finalized Parameters       | Accuracy |
| ----------------------- | -------------------------------------------------- | -------------------------- | -------- |
| **Random Forest**       | n\_estimators (50–200), depth (5–20), gini/entropy | (50 trees, depth 15, gini) | 1.000    |
| **SVM (OVR)**           | C (1e-4–1.0), gamma (1e-5–1e-2), iter (50–200)     | (200, 0.0001, 0.0001)      | 0.983    |
| **Logistic Regression** | C (1e-4–1.0), penalty L2, iter (50–200)            | (200, 0.0001, 1.0)         | 1.000    |
