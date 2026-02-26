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



Convert alpha_check and are_numbers_equal to Spark-based Implementation

Description:
Convert existing alpha_check and are_numbers_equal Python utility functions into Spark-based implementations (UDF or native Spark functions).

Scope:

Re-implement both functions using Spark

Validate logic equivalence with existing implementation

Test against previous dataset to ensure same behaviour/output

Add unit tests for Spark version

Acceptance Criteria:

Spark implementation returns identical results as current logic

Validated with historical data

Unit tests added and passing

Estimate: 1 Day


Convert alpha_check and are_numbers_equal to Spark-based Implementation

Description:
Convert existing alpha_check and are_numbers_equal Python utility functions into Spark-based implementations (UDF or native Spark functions).

Scope:

Re-implement both functions using Spark

Validate logic equivalence with existing implementation

Test against previous dataset to ensure same behaviour/output

Add unit tests for Spark version

Acceptance Criteria:

Spark implementation returns identical results as current logic

Validated with historical data

Unit tests added and passing

Estimate: 1 Day

JIRA Story: Convert perfect_match and scientific_notation to Spark

Description:
Migrate existing perfect_match and scientific_notation logic to Spark-based implementation (UDF or native Spark functions).

Acceptance Criteria:

Spark implementation matches current Python behavior

Handles nulls and edge cases correctly

Validated against previous dataset

Unit tests added and passing

Estimate: 2 Points


JIRA Story: Convert currency_check to Spark

Description:
Migrate existing currency_check logic to Spark-based implementation (UDF or native Spark function).

Acceptance Criteria:

Spark implementation matches current Python logic

Handles nulls and edge cases

Validated against previous dataset

Unit tests added and passing

Estimate: 1 Point


JIRA Story: Convert currency_check to Spark

Description:
Migrate existing currency_check logic to Spark-based implementation (UDF or native Spark function).

Acceptance Criteria:

Spark implementation matches current Python logic

Handles nulls and edge cases

Validated against previous dataset

Unit tests added and passing

Estimate: 1 Point



JIRA Story: Convert get_fuzzy_score to Spark

Description:
Migrate existing get_fuzzy_score logic to Spark-based implementation.

Acceptance Criteria:

Spark implementation matches current behavior

Handles nulls and edge cases

Validated with historical data

Unit tests added and passing

Estimate: 1 Point
