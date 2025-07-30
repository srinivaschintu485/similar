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


#PySpark Multi-Dataset Discrepancy Categorization

### An Intelligent Framework for Detecting and Resolving Data Quality Issues in Financial & Enterprise Datasets

---

## 📘 Overview

Welcome to the **PySpark Multi-Dataset Discrepancy Categorization** tool — a scalable, Spark-powered framework designed to ensure data accuracy, consistency, and trustworthiness across complex, multi-source datasets. This solution focuses on identifying and resolving common discrepancies that can compromise analytical integrity and downstream modeling efforts.

The engine is optimized for datasets originating from structured sources like **CSV** and **Excel**, and it applies a comprehensive set of rules to normalize data formats, numeric precision, and text consistency.

---

## 🧪 Discrepancy Types Addressed

The engine detects and categorizes the following types of data discrepancies:

- **Leading Zero Issues**: Safeguards numeric identifiers by preserving leading zeros (e.g., `00755275` → `755275`)
- **Decimal Precision Differences**: Aligns numerical fields to a standard decimal format
- **Thousands Separator Differences**: Normalizes regional formatting (e.g., `5,000` → `5000`)
- **Scientific Notation Differences**: Converts exponential notation to full numeric values (e.g., `1.2e3` → `1200`)
- **Currency Symbol Differences**: Standardizes currency formats across international symbols and denominations
- **Rounded Off Numbers**: Identifies discrepancies caused by rounding inconsistencies
- **Abbreviation vs. Full Form**: Harmonizes abbreviations and full-text equivalents (e.g., `DOB` vs `Date of Birth`)
- **Case Sensitivity Issues**: Resolves mismatches due to inconsistent capitalization (e.g., `Credit Card` vs `CREDIT CARD`)
- **Extra Space Issues**: Trims unnecessary leading, trailing, or embedded whitespace
- **Special Character Differences**: Unifies textual fields containing symbols, punctuation, or escape sequences

---

## ✨ Key Features

- **Comprehensive Discrepancy Detection**  
  Employs advanced algorithms to identify a broad spectrum of data integrity issues

- **Scalable Data Transformation**  
  Utilizes PySpark to efficiently handle large-scale datasets with high performance

- **Multi-Format Compatibility**  
  Supports both `.csv` and `.xlsx` files, including multi-sheet Excel parsing

- **Advanced Currency Handling**  
  Enables recognition and standardization of global currency symbols and formatting

- **Dual-Mode Processing**  
  Detects discrepancies in both **numeric** and **textual** formats with equal precision

---

## 📊 Sample Input/Output Mapping

| 🔎 **Source**                  | 🎯 **Target**              | 🏷️ **Discrepancy Category**             |
|-------------------------------|----------------------------|------------------------------------------|
| `00755275`                    | `755275`                   | Leading Zero Issue                      |
| `5501`                        | `5501`                     | Decimal Precision Difference            |
| `5,000`                       | `5000`                     | Thousands Separator Difference          |
| `1.2e3`                       | `1200`                     | Scientific Notation Difference          |
| `$1,000`                      | `1,000.00 USD`             | Currency Symbol Difference              |
| `Credit Card`                | `CREDIT CARD`              | Case Sensitivity Issue                  |
| `Savings Account`            | `SAVINGS ACCOUNT`          | Case Sensitivity Issue                  |
| `Routing Number:123456789`  | `Routing Number: 123456789`| Extra Space Issue                       |
| `Password@123`              | `Password 123`             | Special Character Difference            |

---

## ⚙️ Tech Stack

- **Apache Spark (PySpark)**
- **Python 3.9+**
- **Pandas** for local data wrangling and Excel I/O
- **Jupyter Notebooks** for exploratory testing
- **GitHub Actions** for planned CI/CD integration

---

## 🧭 Ideal Use Cases

- Financial data quality audits
- Model risk validation pipelines
- Preprocessing step in MLOps workflows
- Data migration and ETL transformation testing

---

## 🚀 Future Enhancements

- ⏱️ Airflow-based scheduled pipeline integration  
- ☁️ Deployment to distributed clusters (AWS EMR, Azure Synapse)  
- 🧪 Unit and integration testing with PySpark mocks  
- 📦 Model/data version control with MLflow or DVC  
- 📈 Visualization dashboard to monitor discrepancy trends

---

## 📩 Contact

For questions, contributions, or access to internal notebooks, please contact the Data Engineering & Risk Analytics team.

© 2025 Citi Internal – Confidential and Proprietary.

High-Level Summary of Findings
Precert – AIML is an automated solution that compares structured data from source and target files to identify and explain discrepancies. The system is designed to reduce the manual effort required to investigate data mismatches across enterprise systems. It processes input files in formats such as .xlsx, .csv, and .txt, calculates a similarity index, and predicts the root causes of differences using a machine learning ensemble.

Over 10 predefined discrepancy categories—including case sensitivity, special character variations, numerical precision mismatches, and scientific notation differences—are considered during analysis. Each record is evaluated using multiple classification models, and the final output includes the top three predicted reasons for mismatch along with confidence scores. These insights are used by Citi Bank teams to improve data quality and reduce manual reconciliation.

Model Framework
The system receives metadata and file references via Kafka, processes the data using Spark, and applies a set of engineered rules and classifiers. Each source–target record pair is passed through an ensemble of three machine learning models—Random Forest, Linear SVM, and Logistic Regression.

When all models agree on a discrepancy label, the system finalizes that prediction. If two models agree and one differs, the majority label is selected as the final disposition. In cases where all three models disagree, the result is escalated for manual review or flagged for further investigation.

Final predictions are exported in Excel format and structured to match the input layout for traceability. This ensures consistent handling across systems and improves downstream processing by business users and data stewards.

🎯 Purpose & Vision
Traditional data comparison is slow, manual, and reactive. This service transforms that process into a smart, explainable, and automated pipeline using Apache Kafka, Spark, and machine learning.

By analyzing structural and semantic differences between datasets, we generate:

A quantified similarity score

Root-cause predictions behind mismatches

Automated feedback loops for continuous learning

The goal: reduce hours of manual review to seconds of actionable insight.

📘 What Problem Are We Solving?
Data inconsistencies often appear across source and target systems — but why they occur is rarely obvious.

This system answers the “why” — not just the “what” — using ML-driven context-aware predictions.

Result: reduced firefighting, increased trust in reporting pipelines, and faster issue resolution.

🧩 Architecture at a Glance
![Include animation or chart here - e.g., input → Kafka → Spark ML → Prediction → Kafka Output]

🔁 Intelligent Workflow
| Stage              | What Happens                                                                          |
| ------------------ | ------------------------------------------------------------------------------------- |
| **Producer**       | Publishes JSON messages to Kafka with metadata + file paths (Excel, CSV, TXT)         |
| **Consumer**       | Consumes from Kafka, fetches files, and compares source vs. target datasets           |
| **Feature Engine** | Extracts structured feature vectors representing differences                          |
| **ML Model**       | Predicts similarity index + mismatch reasons using trained classifiers                |
| **Kafka Output**   | Sends structured predictions back downstream — with JSON formatted exactly like input |


🧠 Core Innovations
| Innovation                       | Impact                                                      |
| -------------------------------- | ----------------------------------------------------------- |
| **ML-Driven Mismatch Reasoning** | Understand *why* records differ, not just that they do      |
| **Quantified Similarity Index**  | Track and score trust in data at a granular level           |
| **Multi-Prediction Support**     | Offers ranked predictions for interpretability              |
| **Schema-Agnostic Design**       | Works across Excel, CSV, JSON – plug-and-play compatibility |
| **Kafka Feedback Loop**          | Enables downstream systems to act immediately on insights   |


📤 Outputs That Matter
Result Format:
JSON payload containing:

similarityIndex: 0.87

predictionReason: Schema mismatch on key fields

confidenceScore: 92%

Value for Teams:

Clear audit trail

Faster root-cause resolution

Integrated with existing Kafka-based architecture

⚙️ What Powers This System
| Layer                | Tech Stack Used                                             |
| -------------------- | ----------------------------------------------------------- |
| **Messaging**        | Apache Kafka (Producers & Consumers)                        |
| **Compute**          | Spark (pyspark-based feature processing)                    |
| **Prediction Layer** | Scikit-learn / Spark MLlib (Random Forest, SVM, etc.)       |
| **Orchestration**    | Manual (now), future: Lightspeed + Helm + Docker + Oozie    |
| **Storage**          | Oracle for processed result persistence                     |
| **Codebase**         | Python 3.10+, modular, CI/CD-ready, supports `spark-submit` |


🛠 Technical Details (with Security & Scalability in Mind)
SSL-secured Kafka config (kafka_props.properties)

Structured logging + metrics hooks for traceability

Containerizable via Docker; Helm support planned for OpenShift deployments

Pythonic, lint-checked (flake8), testable (pytest), and CI/CD-compliant structure

📊 Current Status vs. Future-Ready Roadmap
| Area               | Current State                | Planned Enhancements                   |
| ------------------ | ---------------------------- | -------------------------------------- |
| Execution          | Manual via CLI Spark scripts | CI/CD via Lightspeed, Docker, Helm     |
| Prediction Scope   | Limited to \~3 categories    | Expanded ML labels via retraining      |
| Release Management | No formal build or changelog | Versioned `.whl` or container releases |
| Data Sources       | Local files (xlsx/csv/txt)   | Expand to APIs and live databases      |
| Deployment Target  | Dev server only              | Full OpenShift deployment              |


🌟 The Vision
Imagine a future where:

Schema drifts are auto-classified within minutes

Downstream data issues are traced in near-real-time

Business teams understand why discrepancies happen — without needing a data engineer

This project is a step in that direction — transforming raw comparisons into contextual intelligence.







Chapter 3: Model Data
This chapter documents the training data used to develop the model, including its origin, preparation, quality controls, assumptions, and justification for its use. The model's objective is to classify mismatches between structured source and target fields into predefined root cause categories such as leading zero issue, rounded number, currency format difference, etc. The quality and structure of the training data directly influence the model’s accuracy, generalizability, and interpretability.

This chapter describes the dataset used to develop and train the model. It covers the source of the training data, the process used to generate and label it, the checks implemented to ensure its quality, and the rationale for using synthetically generated data to meet the modeling objectives.

This model is designed to classify mismatches between structured data values — such as numbers, names, codes — into meaningful root causes (e.g., leading zero, case sensitivity, scientific notation). These mismatch types often appear in enterprise reconciliation tasks where the same record can appear differently across systems due to formatting, locale, or transformation rules.

3.1 Data Sources
The training data for this model was synthetically generated using Python scripts built to simulate real-world discrepancies across structured fields. Each training example consists of:

A pair of values:

value_1: a clean source value

value_2: a modified version of the same, with a specific type of discrepancy

A label: the known reason for the discrepancy (e.g., "Leading Zero", "Rounded Off")

The synthetic data was generated in a controlled and labeled environment, allowing for full traceability and coverage across edge cases. Rather than depending solely on production logs — which are often skewed or unlabeled — this approach ensures that:

All mismatch categories are equally represented

The model can learn from clear, unambiguous examples

The feature engineering logic is aligned with label assignment

Mismatch categories covered include:

Leading Zero (e.g., "00123" vs "123")

Currency Format Differences (e.g., "$100" vs "100.00")

Negative vs Positive (e.g., "-50" vs "50")

Scientific Notation (e.g., "1.2e-3" vs "0.0012")

Extra Space, Case Sensitivity, Thousand Separator Differences, etc.

Matched Values (used as control)

This dataset provides a realistic foundation for learning how discrepancies typically present in structured enterprise data.

3.2 Data Preparation and Preprocessing
The synthetic dataset was created using a suite of Python functions (developed under the JEDI_ML framework) that each simulate a different type of transformation. The generation logic applies specific rules to produce:

One type of error per row

Clearly labeled discrepancy type

Randomized but realistic values

For example:

python
Copy
Edit
value_1 = "1234"
value_2 = "1,234"
label = "Thousand Separator"
These records were stored in CSV format, and all preprocessed records went through:

Whitespace and case normalization

Conversion of numeric fields to Decimal for precision

Flagging of unusable rows (e.g., nulls, invalid types)

Balancing of class labels to ensure no overrepresentation of "Matched"

The result was a clean and balanced dataset where each row is:

Valid

Labeled with high confidence

Aligned with the feature extraction logic used in the model

3.3 Input Data Checks
To ensure the quality of this training data, the following controls were applied:

| Check Type             | Description                                                                  |
| ---------------------- | ---------------------------------------------------------------------------- |
| **Schema validation**  | Ensured all required fields (`value_1`, `value_2`, `label`) were present     |
| **Type coercion**      | Applied `numeric_check`, `scientific_notation_check` etc. to validate inputs |
| **Mutual exclusivity** | Only one mismatch type per row to prevent label confusion                    |
| **Category coverage**  | All defined mismatch types were included with roughly equal counts           |
| **Manual sampling**    | Random sample of 200 records was manually verified for labeling accuracy     |


3.4 Data Weaknesses and Compensating Controls
| Identified Weakness                | Potential Impact                                       | Compensating Control                                      |
| ---------------------------------- | ------------------------------------------------------ | --------------------------------------------------------- |
| Lack of real-world noise           | May underperform on ambiguous or noisy records         | Future retraining planned with labeled production data    |
| Synthetically “perfect” mismatches | May overfit to obvious formatting differences          | Introduced slight randomness in spacing, casing, decimals |
| No multi-label examples            | Cannot detect compound errors (e.g., currency + space) | Considered out of scope for v1; handled by rule layer     |

3.5 Justification of Data Suitability
Despite being synthetic, the training data was purposefully constructed to mirror the types of issues frequently encountered during real-world system reconciliations. These include:

Data type mismatches due to system formatting

Semantic differences masked by syntax (e.g., "-0.5" vs "0.5")

False mismatches caused by cosmetic variations (spaces, commas)

The dataset is suitable for modeling because:

It is fully labeled with known ground truth

It offers controlled diversity across all key discrepancy types

It allows for clear evaluation and explainability, aligning with MRM principles

In future iterations, the synthetic data will be augmented with real mismatches labeled from production scenarios, creating a hybrid training set that captures both real-world complexity and rule-driven clarity.
