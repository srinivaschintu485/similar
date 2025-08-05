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

Dependent Variable
The dependent variable in this model is the type of data mismatch identified between the source and target structured datasets. This is a multiclass classification problem, where the model is trained to predict one of several predefined mismatch categories for each record.

We defined the following mismatch types based on real-world reconciliation scenarios:

Match – No discrepancy between source and target values

Rounding Issue – Minor numerical differences within acceptable thresholds (e.g., due to decimal precision)

Format Difference – Differences due to inconsistent formats (e.g., DD-MM-YYYY vs. MM/DD/YYYY)

Leading/Trailing Zero – Mismatch caused by padded or truncated zeros

Negative Sign Mismatch – Value direction discrepancy (e.g., -150 vs. 150)

Currency Symbol Mismatch – Differences due to symbols or ISO code inclusion (e.g., $100 vs. USD 100)

Thousand Separator – Misalignment due to comma or space separators (e.g., 1,000 vs. 1000)

Scientific Notation – Format difference due to exponential representation (e.g., 1E+03)

Other – Any unclassified mismatch or unexpected pattern


Performance Definition
Unlike traditional credit models (which use Good/Bad/Indeterminate labels), our model uses labeled synthetic data with clearly defined classes. Each class in the dependent variable corresponds to a unique mismatch type, and we maintain balanced class representation to avoid modeling bias.

The classification performance window was immediate — there is no temporal lag between mismatch detection and labeling, as the labels were generated alongside synthetic data creation.

 Summary Statistics of the Dependent Variable (DEV, OOT)

| Mismatch Type            | DEV Sample (#/%) | OOT Sample (#/%) |
| ------------------------ | ---------------- | ---------------- |
| Match                    | XX / XX%         | XX / XX%         |
| Rounding Issue           | XX / XX%         | XX / XX%         |
| Format Difference        | XX / XX%         | XX / XX%         |
| Leading/Trailing Zero    | XX / XX%         | XX / XX%         |
| Negative Sign Mismatch   | XX / XX%         | XX / XX%         |
| Currency Symbol Mismatch | XX / XX%         | XX / XX%         |
| Thousand Separator       | XX / XX%         | XX / XX%         |
| Scientific Notation      | XX / XX%         | XX / XX%         |
| Other                    | XX / XX%         | XX / XX%         |








