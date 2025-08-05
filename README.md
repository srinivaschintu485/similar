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

Sampling Methodology and Results
Sampling Method
Sampling was not applicable, as the development dataset was fully synthetically generated rather than sampled from a real-world population. For each record, one side (e.g., source_column) remained unaltered, while controlled modifications were injected into the target_column to simulate various mismatch scenarios (e.g., rounding differences, case sensitivity, spacing issues, special characters, etc.).

This method was guided by domain logic and targeted the most frequently observed reconciliation anomalies in production environments. Each mismatch type was intentionally included, ensuring that the dataset aligns with the downstream modeling requirements.

To ensure fair representation across different classes (e.g., “Match”, “Mismatch - Rounding”, “Mismatch - Case”, etc.), we implemented proportional balancing during data generation — as visualized in the mismatch distribution bar chart included in the EDA section.

Sampling Verification
As no traditional sampling was performed, sampling verification in the classical sense was not required. However, we verified that the final dataset was representative by construction through the following checks:

Ensured balanced class distribution across match/mismatch categories, preventing bias toward any single mismatch reason.

Used descriptive statistics (mean, standard deviation, min, max, quartiles) to confirm feature integrity.

Performed correlation analysis and feature importance ranking to validate the predictive relevance of engineered features.

Thus, while traditional sampling was not used, design-driven balance and verification ensured that the synthetic dataset closely mirrors real-world reconciliation challenges while remaining suitable for AIML model training.



Modeling Data Assumptions
Several assumptions were embedded during the design of the synthetic dataset and feature engineering process for the AIML-based structured data reconciliation model:

Synthetic mismatches reflect real-world scenarios
Assumption: The injected mismatches (e.g., rounding errors, case differences, extra spaces) represent the most common reconciliation failures observed in production.
Justification: Mismatch types were curated based on actual data quality logs and stakeholder feedback from past reconciliation workflows.

Feature extraction is comprehensive and domain-relevant
Assumption: The engineered features (e.g., case-sensitive score, numeric check, space diff, etc.) are sufficient to distinguish match vs. mismatch cases.
Justification: Feature importance scores and correlation matrices (see Section 3.5) indicate distinct patterns across label categories.

No data leakage exists between training and labels
Assumption: All features used for model training are computed from the inputs only (source/target pairs), without referencing the label.
Justification: Labels were assigned after all feature engineering steps based on deterministic mismatch logic, ensuring a clean separation.

Balanced class distribution improves generalizability
Assumption: Artificially balancing the dataset prevents class imbalance bias during training.
Justification: The class distribution bar graph (see EDA section) confirms equal representation across mismatch types, ensuring fair training behavior.

These assumptions are testable and have been evaluated through exploratory data analysis, feature correlation studies, and distribution visualizations (refer to Section 3.3 and 3.5 for supporting visuals and metrics).

Potential Data Weaknesses
Despite the controlled design of the synthetic dataset, the following potential weaknesses were identified:

Lack of real-world noise
Since the data is artificially generated, certain unpredictable human or system behaviors (e.g., typos, encoding issues, multi-language noise) may not be fully captured.
Mitigation: Consider hybridizing future versions of the dataset with small samples of production data (anonymized) to validate edge cases.

Over-simplified mismatch logic
The classification logic assumes a clear and isolated reason for each mismatch, whereas in reality, multiple issues may co-occur.
Mitigation: Extend the data generator to support compound mismatch scenarios, and train multi-label models if needed.

Label confidence is 100% synthetic
All labels are derived from deterministic rules; no human-in-the-loop validation was done.
Mitigation: Include a manual validation sample or SMEs (Subject Matter Experts) to review a subset of labeled data for ground truth alignment.

Feature collinearity
Correlation matrix (see Section 3.6) shows strong correlation between some features (e.g., case-insensitive and case-sensitive scores), which may lead to redundancy or overfitting.
Mitigation: Use dimensionality reduction or regularization techniques during model development to prevent over-dependence.


