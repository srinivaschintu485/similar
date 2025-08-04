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

Descriptive Statistics of Derived Variables
This section provides summary statistics of the key derived variables used in the AIML model training dataset. These variables were engineered to capture differences between source and target fields in terms of formatting, structure, and content. Each variable plays a role in helping the model distinguish between Match and various Mismatch types.

1. Scientific_Notation, Thousand_Separator, Rounded_Off
Scientific_Notation: Binary indicator showing if scientific notation was present. All values have 0 mean, indicating this was rare or controlled.

Thousand_Separator: Mean of ~9.78 suggests that thousands separators were moderately injected in the mismatches. High standard deviation (29.72) confirms variable presence.

Rounded_Off: Mean ~0.25 implies ~25% of values were affected by rounding issues (e.g., 5.677 vs. 5.68).

2. Leading_Zero, Negative_Check, numeric_check
Leading_Zero: Present in ~8% of values; useful for detecting padding discrepancies (e.g., 001 vs. 1).

Negative_Check: Present in ~10% of records, indicating negative sign mismatches (e.g., -50 vs. 50).

numeric_check: Mean of ~0.4 shows almost 40% of the values were flagged with numeric inconsistencies beyond rounding or sign change.

3. source_len, destination_len
Measures string lengths for source and destination. Very close mean (~0.2), suggesting structure is generally consistent but with minor padding or trimming variations.

String and Symbol Differences
4. Case_Insensitive_Score, Case_Sensitive_Score
Case_Insensitive_Score: Average ~78.38 out of 100. This indicates most values matched in content but not necessarily in format.

Case_Sensitive_Score: Slightly lower (~73.79 mean), suggesting minor case mismatches in ~26% of data.

5. Case_Sensitivity_Diff
Measures the drop in score due to case sensitivity. Mean ~4.59 shows minimal but consistent impact from capitalization differences.

6. Special_Character_Score, Special_Character_Diff
Special_Character_Score: Mean ~73.60 shows most special characters matched well.

Special_Character_Diff: Mean ~2.99 out of 100 indicates moderate differences due to missing or extra symbols.

7. Space_diff, space_score
Space_diff: Measures absolute white space differences. Mean ~0.21 shows it's a minor but present issue.

space_score: High average score of 74 shows most strings retained similar spacing with occasional misalignments (e.g., "ABC DEF" vs. "ABCDEF").

Conclusion
This statistical summary confirms that the dataset has a diverse but controlled distribution of feature mismatches. Each derived variable captures a specific inconsistency type and contributes to the interpretability and performance of the AIML model by offering signals for mismatch classification.

Derived Variable Impact Summary
The table below summarizes the relative influence or correlation of each derived variable with the target label (i.e., whether the source and target values matched or had a specific mismatch type). Positive values suggest a direct relationship (presence of feature → likely mismatch), while negative values suggest an inverse relationship (presence of feature → likely match or less mismatch probability).

| **Feature**               | **Impact** | **Interpretation**                                                                                                           |
| ------------------------- | ---------- | ---------------------------------------------------------------------------------------------------------------------------- |
| Thousand\_Separator       | 0.5286     | Strong positive signal. The presence of thousands separators (e.g., 1,000 vs. 1000) contributes significantly to mismatches. |
| Rounded\_Off              | 0.2093     | Moderate positive impact. Rounding differences (e.g., 12.34 vs. 12.3) are a noticeable cause of mismatch.                    |
| Special\_Character\_Diff  | 0.1876     | Symbols or punctuation mismatches (e.g., "\$200" vs. "200") affect predictions.                                              |
| numeric\_check            | 0.1556     | Detects general numeric formatting issues; positively associated with mismatch.                                              |
| Special\_Character\_Score | 0.0824     | Indicates similarity in special characters. Higher score slightly leans toward mismatches when low.                          |
| Case\_Sensitive\_Score    | 0.0663     | Very weak positive signal; lower case-match leads to slight mismatch increase.                                               |
| space\_score              | 0.0566     | Minor influence; whitespace similarity helps reduce mismatch detection.                                                      |
| Scientific\_Notation      | 0.0044     | Very limited impact; may be rare in dataset.                                                                                 |
| Negative\_Check           | -0.0654    | Mild inverse relationship. Indicates mismatches are **less** likely when negative signs are consistent.                      |
| source\_len               | -0.0882    | Slight inverse correlation; more consistent source string length aligns with matches.                                        |
| destination\_len          | -0.1042    | Similar interpretation to source\_len.                                                                                       |
| Case\_Insensitive\_Score  | -0.2034    | Moderate inverse correlation. High similarity ignoring case is a strong signal of a match.                                   |
| Leading\_Zero             | -0.2745    | Good inverse signal; suggests values are matching if leading zeros are handled properly.                                     |
| Space\_diff               | -0.2783    | As expected, higher space difference correlates with mismatches.                                                             |
| Case\_Sensitivity\_Diff   | -0.4161    | **Strongest negative indicator**. Lower case sensitivity differences are a good sign of matches.                             |


Correlation Matrix Overview
The correlation matrix summarizes the linear relationships between each pair of derived features. Key observations:

Strong Positive Correlations:

Rounded_Off and Leading_Zero (r = 0.72) – These often co-occur, possibly due to formatting logic (e.g., rounded values that drop leading zeros).

Special_Character_Score and Special_Character_Diff (r ≈ 0.99) – As expected, these are essentially inverses or tightly related aspects of character formatting.

Case_Insensitive_Score and Case_Sensitive_Score (r = 0.80) – High consistency, indicating that these two features move together and could be redundant.

Negative Correlations:

Negative_Check and Case_Sensitive_Score (r = -0.43) – Suggests when negative signs are inconsistent, case similarity may drop.

Space_diff shows weak-to-moderate negative correlation with many features, indicating it’s relatively independent.

Low/No Correlation (Near 0):

Scientific_Notation and most features – This feature behaves independently, and may have minimal influence or frequency in the dataset.

Insights for Feature Selection
Highly correlated features (e.g., Special_Character_Score & Special_Character_Diff) may need dimensionality reduction to avoid multicollinearity.

Independent or orthogonal features like Scientific_Notation or Negative_Check may still be valuable if they help capture unique error types.

Some correlations suggest potential for feature engineering consolidation, such as merging or transforming similar features.



                                                              |


