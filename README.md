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

"Initial Variable Reduction Process" Section:
In this project, a formal variable reduction process involving statistical techniques (such as low variance filtering, IV check, multicollinearity removal, etc.) was not performed. Instead, feature selection was driven by domain expertise and interpretability considerations.

A total of 18 features were selected based on their relevance to the reconciliation logic, including structural text metrics (e.g., Similarity_Percentage, source_len, destination_len), numeric transformations (e.g., Rounded_Off, Scientific_Notation), and formatting differences (e.g., Case_Sensitive_Score, Currency_Diff, Leading_Zero).

These features were engineered to capture typical mismatch patterns observed during file comparison and were retained without automated reduction to preserve their explainability and alignment with known reconciliation failure reasons.

Since the number of features was already small and meaningful, further dimensionality reduction was deemed unnecessary.

“Variable / Model Selection” (Based on your actual work):
The final set of 18 features used in the model was selected based on domain relevance and interpretability rather than statistical filtering techniques. These features were engineered to capture the types of mismatches that typically occur in structured data reconciliation, such as case sensitivity issues, numeric formatting differences (e.g., scientific notation, rounding), and symbolic differences (e.g., currency symbols, special characters).

Each feature was manually designed and retained due to its clear linkage to known root causes of mismatches. For example:

Similarity_Percentage and space_score capture general textual similarity.

Leading_Zero, Rounded_Off, Scientific_Notation, and Currency_Diff handle numeric formatting inconsistencies.

Case_Sensitive_Score and Special_Character_Score handle case and character mismatches.

No variables were dropped, as all selected features were meaningful from a business logic standpoint. This decision was intentional to preserve model explainability, which is critical in regulated environments like AML or model risk governance.

For model training, we experimented with Random Forest and SVM. Hyperparameters were tuned using grid search on the development (DEV) set:

For Random Forest: number of trees (n_estimators), maximum depth (max_depth), and minimum samples per split were varied.

For SVM: kernel type, C, and gamma parameters were tuned.

The final model was selected based on a balance of performance (AUC, F1-score) and interpretability, with additional review for explainability and alignment with domain expectations.


