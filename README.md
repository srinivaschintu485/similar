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

![image](https://github.com/user-attachments/assets/ae3c1775-0aa1-457b-92cb-7ad6960a84f8)

Overview
The goal of the Exploratory Data Analysis (EDA) phase was to understand the structure, quality, and distribution of the dataset generated for training the AIML model responsible for identifying and categorizing mismatches between source and target data values. The dataset contains a total of 122,411 rows and 16 features, including the target classification label and engineered features representing numerical, formatting, and semantic differences.
4.2 Dataset Composition
The dataset includes the following key features:

Label: The mismatch category label (e.g., "Case Sensitivity", "Leading Zero", "No Match", etc.)

Feature-based scores like:

Scientific_Notation, Thousand_Separator, Rounded_Off, Leading_Zero, Negative_Check, numeric_check

String length indicators: source_len, destination_len

Similarity or difference metrics: Case_Sensitive_Score, Special_Character_Score, Space_diff, etc.

These features are engineered using domain logic to quantify different mismatch patterns in the data reconciliation process.

Label Distribution
A bar plot of the Label column was generated to analyze the distribution of mismatch types. The categories include:

No Match: Highest occurring label (~25k records), where no alignment could be determined.

Negative vs Positive, Thousand Separator Difference, Special Character Differences, Extra Space Issues: Each has ~10k+ occurrences, indicating common formatting-based mismatches.

Rounded Off Numbers, Leading Zero Issues, Scientific Notation Differences: Slightly lower in frequency but still significant in pattern learning.

This distribution helps assess class imbalance and guides resampling or weighting strategies during model training.

4.4 Data Types and Structure
A snapshot of the dataset's data types revealed:

All score and difference features are stored as float64.

The numeric_check column is of type int64, used likely as a binary flag.

The Label column is of type object, representing categorical classes to be predicted.

This analysis confirms that the dataset is numerically well-structured for supervised learning tasks and ready for encoding and normalization steps.


