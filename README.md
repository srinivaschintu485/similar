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

1. Model Data Collection
We started by generating a synthetic dataset using a controlled mismatch injection process, where we retained one column from the original (source) file and deliberately introduced variations in a corresponding column (target) to simulate realistic mismatches. These changes included format differences, rounding issues, leading/trailing zeros, sign mismatches, and more. The goal was to replicate the kind of inconsistencies that occur during real-world data reconciliations.

2. Define Dependent Variable (Mismatch Types)
The dependent variable in our classification model was the type of mismatch (or a "match" label if no discrepancy existed). Each row in the dataset was tagged with one of several categories such as Match, Rounding Issue, Format Difference, Leading Zero, Negative Sign, Currency Symbol Mismatch, etc. This multiclass setup allowed the model to not only detect mismatches but also classify them by type.

3. Feature Engineering
Rather than relying on raw columns alone, we engineered multiple interpretable features that captured specific mismatch behaviors. These included fuzzy string similarity scores (e.g., Levenshtein distance), numeric difference thresholds, custom flags for leading zeros, checks for currency symbols, sign mismatches, and decimal precision. These derived features formed the foundation of our input data for model training.

4. Stepwise Variable Selection
Although we did not perform dimensionality reduction or PCA, we applied logical feature selection based on technical relevance and interpretability. For example, we retained features that had clear analytical meaning and discarded any that were redundant or ambiguous. This step ensured that the model remained explainable and aligned with business logic.

5. Final Model Fitting
We trained multiple classification models including Random Forest, Support Vector Machine (SVM), and Logistic Regression using the engineered features. The objective was to identify the model that best balanced accuracy and explainability. Each model was evaluated using the same dataset split into development and holdout (OOT) sets.

6. Score Alignment
Once the models produced their predictions, we aligned the predicted mismatch labels with the actual labels assigned during data generation. This alignment helped quantify model accuracy for each class and ensured that mismatches were being correctly identified and tagged.

7. Performance Testing
We evaluated each model using standard classification metrics like accuracy, precision, recall, and F1-score. Performance was validated both on the development set and the out-of-time (OOT) holdout set to ensure generalizability.
To enhance trust and interpretability, we also used tools like SHAP (SHapley Additive exPlanations) to identify which features influenced each prediction the most — crucial for explainability in any audit or regulatory scenario.





📌 Question: List Modeling Soundness Assumptions
Answer:

Independence of observations: Each record mismatch is treated independently. This assumption was tested via data shuffling and validated by consistent model performance across random samples.

Balanced class distribution: We assumed equal representation of mismatch types. This was achieved through upsampling techniques and is visually confirmed in the bar chart in Section X.X.

Feature relevance: All selected input variables (e.g., string similarity scores, numeric deltas, sign difference flags) are assumed to contribute meaningfully to classification. This was tested using permutation importance and SHAP value analysis.

Stationarity across samples: The mismatch behavior in DEV is assumed to be similar in OOT. We validated this using KS-test and performance stability plots.

These assumptions were validated through statistical analysis and reflected in MDD sections on feature engineering and validation metrics.

📌 Question: List Business Assumptions (if any)
Answer:

This model includes the following business assumptions:

Standardized formatting issues such as commas, currency symbols, and scientific notations are assumed to be common reconciliation issues across business units.

Mapping logic from source to target systems may vary slightly, but core reconciliation patterns (e.g., sign flips, scale mismatches) are assumed to be consistent.

Risk priority is higher for mismatches involving financial values (currency, percentages) over string fields such as names or addresses.

These assumptions are based on historical reconciliation trends, business interviews with data stewards, and internal audit logs.

📌 Question: What are the Potential Data Weaknesses?
Answer:

Synthetic data generation may not capture the full variety of edge cases seen in production files.

Limited historical data: The model is trained only on past 3–6 months of reconciliation issues, which may miss rare patterns.

Overfitting risk: Due to a relatively small number of labeled mismatch samples for certain categories, the model may overfit specific formatting anomalies.

To mitigate these issues, we’ve implemented cross-validation, introduced noise-based augmentation for robustness, and continuously retrain the model with new mismatches flagged by analysts.

📌 Question: What is the Dependent Variable and its definition?
Answer:

The dependent variable is a categorical field representing the type of mismatch observed between source and target files. It is classified into the following categories:

NO_MISMATCH

LEADING_ZERO

ROUNDING_DIFF

FORMAT_DIFF

NULL_MISMATCH

NEGATIVE_SIGN_MISMATCH

SCIENTIFIC_NOTATION_DIFF

CURRENCY_SYMBOL_ISSUE

Each data point is labeled using a rule engine prior to model training. Roll rate and vintage analysis were not required as the label is deterministic based on field-level comparison rules.





















