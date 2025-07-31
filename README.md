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

 RAG-Driven Jira Workflow Recommendation System
📌 Overview
This project introduces a Retrieval-Augmented Generation (RAG) based intelligent system that automates workflow recommendations for newly created Jira tickets. By leveraging past ticket descriptions and their corresponding resolution workflows, the system intelligently determines whether a similar Jira issue has occurred before and, if so, retrieves the appropriate workflow. In the absence of an exact match, it intelligently proposes a new workflow suggestion using a Large Language Model (LLM), enhanced with historical context.

This system bridges the gap between tribal knowledge, repeated engineering effort, and automated knowledge reuse in enterprise environments.

🧠 Core Problem
Organizations often maintain large volumes of operational workflows tied to Jira tickets. However, engineers and analysts routinely:

Recreate existing logic,

Miss prior resolutions to similar problems, or

Lack an organized way to retrieve and reuse previous efforts.

This leads to:

Inconsistent implementations,

Redundant work, and

Loss of valuable engineering knowledge over time.

💡 Solution: RAG for Intelligent Workflow Resolution
This system applies the Retrieval-Augmented Generation (RAG) paradigm to intelligently map new Jira issues to existing knowledge. It does so by:

Indexing historical Jira descriptions and their associated resolution workflows using vector embeddings.

Retrieving semantically similar tickets for any new Jira request.

Generating a contextual recommendation using an LLM when prior matches are weak or unavailable.

🔁 System Architecture
The solution is split into two major workflows: Preprocessing (offline knowledge curation) and Query-time Retrieval & Generation (real-time workflow suggestions).

🔨 1. Preprocessing Phase (Offline)
| Step | Component            | Description                                                                                                                                    |
| ---- | -------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------- |
| 1    | **Knowledge Source** | Ingest a curated table of historical Jira tickets containing `description`, `workflow`, and `Jira ID`.                                         |
| 2    | **Embedding Model**  | Convert each Jira description into semantic vector representations using models like `all-MiniLM`, `BGE`, or `OpenAI Ada`.                     |
| 3    | **Vector Indexing**  | Store the vectorized tickets in a **Vector Database** (e.g., FAISS, Pinecone, ChromaDB), tagged with metadata (Jira ID, workflow steps, etc.). |
| 4    | **Metadata Linking** | Maintain linkage between each embedding and its corresponding workflow action for quick retrieval.                                             |


⚙️ 2. Query-Time Workflow (Real-Time)
| Step | Component                   | Description                                                                                                    |
| ---- | --------------------------- | -------------------------------------------------------------------------------------------------------------- |
| 1    | **User Input**              | A new Jira ticket is raised and its `description` is submitted to the system.                                  |
| 2    | **Embedding Lookup**        | The description is embedded using the same model used in the preprocessing step.                               |
| 3    | **Semantic Search**         | Top-k nearest neighbors (most semantically similar Jira descriptions) are fetched from the vector DB.          |
| 4    | **Confidence Thresholding** | If similarity score is above a defined threshold (e.g., cosine > 0.9), a prior Jira is **considered a match**. |
| 5    | **Match Found → Reuse**     | Retrieve and display the **existing workflow** with optional modifications.                                    |
| 6    | **No Match → Generate**     | If no strong match is found, a **LLM (e.g., GPT-4)** is prompted with:                                         |


The new Jira description

Top k similar workflows (even if weak matches)

→ It returns a context-aware workflow recommendation |
| 7 | User Validation | The recommended workflow is accepted, edited, or overridden. |
| 8 | Knowledge Update | Approved Jira + Workflow is added to the vector DB for future reuse. |

📦 Components
| Module                | Description                                                                              |
| --------------------- | ---------------------------------------------------------------------------------------- |
| `jira_ingest.py`      | Parses and prepares Jira tickets from structured sources (CSV/Excel/API)                 |
| `embedder.py`         | Converts textual descriptions into embeddings using Sentence Transformers or OpenAI APIs |
| `vector_store.py`     | Interfaces with FAISS or Chroma for storage, retrieval, and similarity search            |
| `rag_orchestrator.py` | Coordinates between user input, retrieval, thresholding, and generation logic            |
| `llm_generator.py`    | Prompts the LLM with enriched context and fetches suggested workflows                    |
| `ui_gradio.py`        | (Optional) Gradio UI for testing query inputs and displaying outputs                     |
| `pipeline_update.py`  | Handles post-approval insertion of new Jira-workflow pairs into the knowledge base       |


✨ Key Innovations
✅ Semantic Similarity Retrieval instead of keyword search.

🤖 LLM-Augmented Workflow Generation with domain-aware prompting.

🔄 Self-Learning Loop where accepted Jira-workflows enhance future suggestions.

🧠 Zero-Code Retrieval for operations teams via UI or API.

⚙️ Pluggable Architecture supporting different embedding models, vector DBs, and LLM backends.

📈 Example Use Cases
| New Jira                                              | Outcome                                                                                        |
| ----------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| `"Validate OM_TRADE_FACT passthroughs"`               | Finds a prior match → Suggests previously used parsing workflow.                               |
| `"Add XML ingestion rules for payment detail errors"` | No close match → LLM proposes a new XML parsing and logging workflow using historical context. |
| `"Compare count from source vs topic for COE"`        | Partial match found → Suggests adapted Kafka verification steps.                               |


🔐 Future Enhancements
Fine-tune confidence thresholds using feedback loop

Store user corrections and edits to train a custom workflow suggestion model

Add version control and audit tracking for every suggested and accepted workflow

Enable domain-specific finetuning (e.g., Healthcare, Finance, Manufacturing Jira workflows)

🧠 Conceptual Diagram
Refer to the diagram below to understand the complete flow:


(Replace with your own version — the one you uploaded is well-suited.)

🏁 Conclusion
This system acts as an intelligent assistant for Jira resolution, enabling teams to reuse, adapt, or generate resolution workflows with minimal manual effort. By embedding prior knowledge and tapping into generative AI capabilities, it empowers technical teams with consistent, fast, and context-aware decision-making — saving hours of analysis and reducing workflow duplication.
