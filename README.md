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








📌 Project Overview
Purpose:
This service processes JSON input messages to extract metadata and analyze structured data (e.g., XLSX, CSV, TXT). The system identifies differences between a source and target dataset and uses a Machine Learning (ML) model to:

Generate a similarity index

Predict the reasons for mismatches using pre-trained logic

Provide actionable insights to address discrepancies

Problem Statement:
Manual comparison of datasets is time-consuming, error-prone, and lacks context. This service introduces automation and intelligence, helping users understand why data differences occur — not just where.

End Users:
Citi employees across multiple functions rely on the system to interpret and act upon discrepancies in their operational and reporting pipelines.

🧩 Project Components
🔹 Core System Components
Component	Role
Kafka	Acts as the messaging backbone, enabling real-time communication between producer and consumer services.
Oracle Database	Stores processed data and intermediate outputs for future audit and analysis.
ML Model	Applies classification and similarity scoring to help diagnose dataset differences.

🔄 Data Flow
🟢 Producer
Sends JSON messages into Kafka.

Messages include metadata and file paths for the input files (Excel, CSV, TXT).

🟠 Consumer
Listens to Kafka topics, reads incoming messages.

Downloads the source and target datasets.

Performs preprocessing and sends relevant features to the ML model.

🧠 Machine Learning
Compares the datasets using engineered features.

Calculates a similarity index to reflect closeness.

Predicts reasons for mismatches using labeled training data.

Supports multi-class predictions (up to 3 predictions per input for user insights).

🔵 Downstream
Outputs are sent back to Kafka in the same format as the input message, allowing downstream systems to consume enriched results.

📤 Output & Evaluation
Output Format:
JSON containing similarity scores and predicted reasons for discrepancies (aligned to input schema for consistency).

Success Metrics:

Accuracy of predictions

Interpretability of mismatch reasons

Usability of the similarity score in business pipelines

⚙️ Technical Details
🔧 Configurations
Kafka properties (SSL, serializers, deserializers) are defined in kafka_props.properties.

Oracle database is integrated for persistent storage of enriched data.

🛠 Tools and Libraries
Python libraries: kafka-python, configparser, json, logging

ML stack: [details not shown, likely scikit-learn, pandas, Spark ML]

⚠️ Known Limitations
Currently supports a limited number of prediction categories due to scope of training data.

Broader prediction coverage requires retraining with diverse datasets.

🚀 Deployment & Execution
Current State:
Both Producer and Consumer are triggered via command-line Spark scripts (spark-submit) on a dev server.

Planned Enhancements:
Migrate to a fully automated CI/CD pipeline using Apache Oozie or Lightspeed (for scheduling and deployment).

Containerize the solution using Docker + Helm for OpenShift deployments.

🌟 Future Roadmap
Enhancement	Purpose
Expand training data coverage	Improve model generalization across varied use cases
Implement CI/CD & Helm	Automate deployment and versioned release to OpenShift
Add testing & SonarQube to build pipeline	Improve maintainability, traceability, and security
Improve dashboard visualizations	Empower users with interpretable ML insights






