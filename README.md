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



After evaluating multiple algorithms (Random Forest, Support Vector Machine (SVM – One vs Rest), and Logistic Regression) across different hyperparameter configurations, the following final specifications were determined:

Random Forest

Final Hyperparameters: Number of Trees = 50, Maximum Depth = 15, Criterion = Gini

Performance: Accuracy = 1.000, Precision = 1.000, Recall = 1.000, F1 Score = 1.000

Rationale: Random Forest achieved perfect classification on the synthetic dataset, consistently separating mismatch categories without overfitting. Its ensemble nature provided robustness and stability.

Support Vector Machine (OVR)

Final Hyperparameters: Iterations = 200, C = 0.0001, Gamma = 0.0001

Performance: Accuracy = 0.983, Precision = 0.984, Recall = 0.983, F1 Score = 0.983

Rationale: SVM OVR showed strong performance but slightly lower than Random Forest and Logistic Regression. It provided additional validation of data separability, though sensitivity to hyperparameter scaling was observed.

Logistic Regression

Final Hyperparameters: Iterations = 200, Regularization Strength (C) = 0.0001, Penalty = L2

Performance: Accuracy = 1.000, Precision = 1.000, Recall = 1.000, F1 Score = 1.000

Rationale: Logistic Regression also achieved perfect performance on the dataset. Its interpretability and simplicity make it useful as a benchmark alongside Random Forest.

Final Variable Set (independent variables):

No Match, Negative vs Positive, Thousand Separator Difference, Special Character Differences, Extra Space Issues, Case Sensitivity, Matched, Leading Zero Issue, Scientific Notation Difference, Rounded Off Numbers

These variables represent structured categories of mismatches, ensuring interpretability, reproducibility, and regulatory alignment.


4.6.2 Variable Transformation / Treatment

The following transformations and treatments were applied to input data before modeling:

Missing and Invalid Values: Synthetic dataset ensured no nulls; checks confirmed all inputs valid. Any invalid entries were excluded during preprocessing.

Categorical Encoding: Mismatch categories were numerically encoded for model compatibility.

Scaling and Normalization: Standard scaling was applied for SVM and Logistic Regression models to avoid bias due to feature magnitude. Random Forest, being scale-invariant, did not require normalization.

Data Consistency Treatments:

Case normalization (e.g., upper vs lower case treated consistently).

Trimming of whitespace.

Standardizing numeric formatting (e.g., thousand separators, decimal notation).

Functional Transformations: None applied in this iteration, though the framework is ready to handle log, 1/x, flooring, capping, or outlier treatments if required in future real-world deployment.

These steps ensured that all models received consistent, high-quality inputs. The transformations also supported interpretability of results and compliance with MRM expectations for transparency and auditability.
