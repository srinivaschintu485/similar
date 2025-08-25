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


SVM (One-vs-Rest)

What the plot shows: The SVM accuracy starts around 0.983 and gradually decreases as you change the hyperparameter combinations.

Reason: SVM is very sensitive to parameters like C, gamma, and kernel choices. In your log outputs, you tested multiple combinations (e.g., (C=0.001, gamma=0.0001), (C=0.01, gamma=0.001), etc.).

Interpretation: The highest accuracy (≈0.983) was obtained for certain balanced combinations. As the parameters diverge (too small/large C or gamma), the decision boundary either becomes too rigid (underfitting) or too flexible (overfitting), reducing generalization.

2. Random Forest

What the plot shows: Random Forest accuracy is very stable and close to 1.0 across almost all hyperparameter settings. Only at extreme settings (e.g., too few estimators or very shallow trees) do you see a tiny drop.

Reason: RF is inherently robust due to bagging and averaging over multiple decision trees. Parameters like number of trees (n_estimators), maximum depth, and splitting criteria (gini, entropy) only slightly affect the performance here because the dataset is synthetic and relatively clean.

Interpretation: The model generalizes extremely well. The near-perfect accuracy indicates Random Forest was the most reliable classifier across your hyperparameter grid.

3. Logistic Regression

What the plot shows: Logistic Regression starts with very high accuracy (close to 1.0), but then drops slightly as different regularization and solver hyperparameters are used.

Reason: Parameters like regularization strength (C) and penalty (L1, L2) control the flexibility of the decision boundary. With optimal tuning (e.g., C=0.0001), the model fits the data perfectly. But when regularization is too strong or too weak, performance declines (underfitting or overfitting).

Interpretation: While Logistic Regression can achieve perfect accuracy here, it’s more sensitive than Random Forest. Its linear decision boundary struggles with complex mismatch types unless tuned carefully.

Overall Comparison

Best Performing: Random Forest (accuracy = 1.0 consistently).

Stable but slightly weaker: Logistic Regression (accuracy ~0.99, but sensitive to regularization).

Most sensitive: SVM OVR (accuracy drops when parameters deviate from optimal).

✅ These plots are useful for your documentation because they clearly demonstrate:

Model robustness (RF > LR > SVM).

Hyperparameter sensitivity (SVM is most sensitive, RF least).

Justification for selecting Random Forest as the final model.
