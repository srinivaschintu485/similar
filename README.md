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
                New Exception
                     │
                     ▼
        ┌────────────────────────┐
        │ Table 2: DQ_EXCEPTION  │
        └────────────────────────┘
          │       │         │
          │       │         │
     Rule_ID   Dataset   Arrangement_SK
          │       │         │
          │       │         ▼
          │       │  ┌─────────────────────────────┐
          │       └─►│ Table 3: Business Data      │
          │          │ (OM_ARRANGEMENT_LOAN_FACT)  │
          │          └─────────────────────────────┘
          │
          ▼
 ┌───────────────────────┐
 │ Table 1: DQ_RULES     │
 └───────────────────────┘
          │
          ▼
 Compare Rule + Business Data
          │
          ▼
 Historical Analysis
 (using Exception Table)
          │
          ▼
 Root Cause Report
 
 <img width="431" height="691" alt="image" src="https://github.com/user-attachments/assets/e0f169e5-889c-409f-b2be-5dedc6c05339" />

