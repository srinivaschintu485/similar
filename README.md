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


Technical Summary:
The model is designed to automate the classification of data mismatches between structured source and target files using supervised machine learning. The core logic involves reading structured data (Excel/CSV), extracting comparison features, labeling mismatch types using rule-based logic, and then training classification models to predict mismatch types with confidence scores.

Python with Apache Spark was used to scale the solution across multiple files and datasets. The classification engine integrates Random Forest, SVM, and Logistic Regression models, trained on synthetic and rule-annotated mismatch data. The model supports downstream integration by tagging mismatches with root cause and confidence score.

🔁 Flowchart: Model Development Process
pgsql
Copy
Edit
+-------------+      +---------------------------+      +---------------------+      +------------------+
|  Model Data | ---> | Define Dependent Variable | ---> | Segmentation &      | ---> | Variable         |
|  Collection |      | (Mismatch Types)          |      | Sampling             |      | Reduction        |
+-------------+      +---------------------------+      +---------------------+      +------------------+
                                                                                             |
                                                                                             v
+---------------------+      +------------------+      +-------------+      +---------------------------+
| Stepwise Variable   | ---> | Final Model      | ---> | Score       | ---> | Performance Testing       |
| Selection           |      | Fitting (RF, SVM)|      | Alignment   |      | (DEV, OOT, Explainability)|
+---------------------+      +------------------+      +-------------+      +---------------------------+
🧩 Detailed Step-by-Step Explanation
Model Data Collection

Raw source and target files (CSV/Excel) are read into Spark DataFrames.

Each record pair is compared field-by-field using a rule engine to detect mismatches.

Metadata such as datatype, length, format, and value difference are also extracted.

Define Dependent Variable

The dependent variable is the Mismatch Category (e.g., ROUNDING_DIFF, LEADING_ZERO, NO_MISMATCH, etc.).

Labels are created using rule-based logic on field comparison (e.g., regex, numerical thresholds).

Segmentation & Sampling

Ensures balanced class distribution across mismatch categories.

Used stratified sampling to maintain proportional representation during training/testing splits.

Variable Reduction

Removed highly correlated or low-variance features using correlation matrix and VIF analysis.

Retained meaningful variables like absolute_diff, format_flag, length_diff, etc.

Stepwise Variable Selection

Ranked features using tree-based importance and recursive feature elimination.

Selected top variables contributing to classification accuracy.

Final Model Fitting

Trained Random Forest, SVM, and Logistic Regression models.

Used ensemble logic or voting mechanism to enhance prediction robustness.

Score Alignment

Normalized output confidence scores for comparability across models.

Applied post-processing thresholds to tag mismatches as auto-resolvable or manual review needed.

Performance Testing

Evaluated on DEV and OOT datasets using F1-score, precision, and recall.

Conducted error analysis using confusion matrix and SHAP explainability.



