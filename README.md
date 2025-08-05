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


**Model Objective**
The primary objective of the model is to automate the identification and classification of mismatches between structured source and target data files using machine learning. This model is part of a broader data quality framework, aimed at reducing manual reconciliation efforts, improving audit traceability, and enabling faster root cause analysis across financial and operational datasets.

The model is trained on a synthetically generated dataset that simulates realistic data mismatches encountered during reconciliation processes (e.g., formatting differences, rounding discrepancies, case sensitivity issues, spacing variations, and numeric inconsistencies). For each source-target record pair, a set of handcrafted features is extracted to capture these variations and generate a "reason score" that feeds into the classifier.

Using ensemble classification techniques (e.g., Random Forest, SVM, Logistic Regression), the model predicts whether the pair is a match or a mismatch, and if mismatched, assigns a likely mismatch reason. The predictions are supported by structured reasoning scores and feature importance metrics, making the model's decisions interpretable and traceable.

The model’s output is intended to serve two key use cases:

Automated Labeling for reconciliation platforms and audit pipelines.

Pre-Screening of records to prioritize review efforts by flagging high-confidence mismatches with suggested root causes.

Flowchart – AIML Model Dataset Preparation (Column-wise Controlled Mismatch Approach)
pgsql
Copy
Edit
[Single Base Table with Original Data]
           │
           ├──► [Column A] → *Kept constant across records*
           │
           └──► [Column B] → *Introduce Controlled Variations* (e.g., format, precision, special characters, leading zeros)
                        ↓
         [Combine Both Columns into Pairwise Records]
                        ↓
         [Inject Known Mismatch Types into Column B]
                        ↓
         [Join or Compare Column A vs. Column B Row-wise]
                        ↓
         [Extract Features (e.g., length diff, pattern, numeric diff)]
                        ↓
         [Tag Reason for Mismatch or Label as Match]
                        ↓
         [Assign Label: "Match" / "Mismatch – Reason"]
                        ↓
     [Final AIML Dataset with Features + Labels Ready for Training]
How This Fits the Citi MRM Documentation Template
Modeling Data Assumptions:

Assumes mismatches are synthetically injected in a controlled and labeled manner.
Assumes that one column is the correct value (anchor), and the other represents real-world noise/errors.

Sampling Method:

Not applicable. Entire population is synthetically generated. However, class balance was ensured across match vs mismatch labels (evident from bar graph distribution).

Descriptive Statistics:

Summary statistics (mean, std, min/max, missing %, etc.) can be shown for numeric features such as:
length_diff, leading_zero_flag, num_diff, type_mismatch_flag, etc.
You may paste histograms or boxplots for key features.

Dependent Variable:

Binary variable: Match (0) vs. Mismatch (1)
Further subclassified by reason codes (Mismatch: LeadingZero, Mismatch: Rounding, etc.)

Model Objective:

Automate structured data comparison between source and target by classifying mismatches and identifying reasons for discrepancies using machine learning.

Modeling Soundness Assumptions:

Assumes independent mismatch categories. Features are engineered to be interpretable and support explainability.
Models used (e.g., Random Forest, Logistic Regression) satisfy statistical assumptions and are evaluated using cross-validation.

Potential Data Weaknesses:

Synthetic nature of data may not capture all real-world corner cases.
May require re-tuning if new formats or mismatches emerge in production.

