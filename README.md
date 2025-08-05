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

 Reject Inference
Is it applicable to your model? → No.

Answer:

Reject inference is not applicable to this model, as it is not an acquisition risk model or fraud detection model where such inference is typically required. The dataset used in this model is synthetically generated and fully labeled based on predefined mismatch categories (e.g., rounding, formatting, currency symbol, scientific notation, etc.).

All instances used in training and testing represent known reconciliation outcomes, and there are no “rejected” or “unlabeled” observations requiring inference or sampling strategies.

Therefore, no reject inference approaches were considered or implemented.

🔹 Dependent Variable
What is the dependent variable in your model?
→ It is a multi-class categorical label representing Mismatch Type

Answer:

The dependent variable in this model is a categorical variable named Mismatch_Type, which classifies the nature of the reconciliation difference between the source and target records.

This is not a binary good/bad classification, but rather a multi-class target representing structured mismatch reasons. The classes include:

Rounding

Leading Zero

Negative Sign Misplacement

Currency Symbol

Scientific Notation

Thousand Separator

No Mismatch (i.e., clean match)

These labels were applied directly to synthetic data through rule-based labeling logic. There were no indeterminate values since every row was explicitly tagged during data generation.

A performance window does not apply in the traditional sense (e.g., credit performance over 12 months) because the labels are immediate and deterministic based on rule violation. However, the model was validated across DEV and OOT sets, ensuring consistency of class distribution and performance.
📊 Example: Table 5 – Summary Statistics of the Dependent Variable

| Performance        | Performance Definition                       | DEV Sample (#/%) | OOT Sample (#/%) |
| ------------------ | -------------------------------------------- | ---------------- | ---------------- |
| Good               | No mismatch identified                       | 600 (50%)        | 300 (50%)        |
| Indeterminate      | N/A (All rows are clearly labeled)           | 0 (0%)           | 0 (0%)           |
| Bad                | Mismatch detected (any of the 6 types above) | 600 (50%)        | 300 (50%)        |
| Performance Window | Not applicable – labels determined at ingest | —                | —                |








