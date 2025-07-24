he model is applied to structured datasets exchanged between upstream and downstream systems within enterprise data pipelines. These datasets typically contain financial, operational, or compliance-related information shared across departments or platforms (e.g., ERP to analytics layers, reporting tools, or reconciliation modules). The primary goal is to detect and classify discrepancies at a field level across matched records in source and target datasets.

This system is designed to support Citi teams in proactively identifying mismatches caused by formatting differences, data entry inconsistencies, or transformation errors introduced during ETL or system integration. Examples of such discrepancies include scientific notation mismatches, leading/trailing space issues, special character differences, case sensitivity, or currency format variations.

The key event leading to the development of this model was the increased manual effort and inefficiency in root-cause analysis of data breaks during reconciliations and audit preparation cycles. As data volume and system complexity grew, traditional rule-based matching approaches became insufficient. Therefore, a machine learning-based system was proposed to enhance the automation of anomaly detection and explanation.

The Precert AIML model is specifically trained to operate on records involving human-entered or system-generated data at the field level, not on entire file-level patterns or bulk transformations. The focus population includes only rows with clear field-to-field mapping across two datasets and excludes unstructured inputs or ambiguous mappings.



1.2 Model Purpose and Intended Uses
1.2.1 Model Background and Purpose
Model purpose:
The ensemble will be used to identify and explain mismatches between structured data from source and target systems within enterprise workflows. The objective is to reduce the manual effort spent by operations teams in investigating and resolving data mismatches, which often arise due to formatting inconsistencies, integration errors, or system incompatibilities. By using machine learning, the system can not only flag mismatches but also provide reasons with confidence scores, improving interpretability and enabling faster resolution.

Model background:
Precert is an internal platform designed to automate structured file comparison between upstream (source) and downstream (target) data submissions. It handles diverse file formats such as Excel, CSV, and TXT, and utilizes an ML-powered service to detect and classify discrepancies. The ensemble model supports schema-agnostic file comparison and generates actionable outputs for downstream systems. Key characteristics of the model background include:

The service processes both static and batch datasets received from various upstream systems.

The model targets structured file comparisons between two file sources, focusing on record-level mismatches.

Discrepancy detection is performed using ML classifiers that analyze features such as numeric value differences, character patterns, and formatting inconsistencies.

The system supports over 11 predefined discrepancy types, including:

Leading Zero Issues

Rounded Off Numbers

Currency Symbol Differences

Case Sensitivity Mismatches

Special Character or Extra Space Differences

Prediction is done using a voting-based ensemble of Random Forest, Logistic Regression, and SVM models, implemented via scikit-learn and Spark MLlib.

This document and model currently apply to North American (NAM) use cases only. Future extensions will cover EMEA and APAC based on retraining and integration readiness.

This is an in-house built ensemble solution using standard machine learning libraries such as scikit-learn, XGBoost, and Spark MLlib, orchestrated through Kafka pipelines with Python 3.10+ and PySpark.



1.2.2 Model Usage
#	Model Scope / Population	Business Program or Process	Usage Description
1	Population: Source-to-target data comparison for structured enterprise files

- Applies to multiple domains (e.g., financial reconciliation, reference data validation)
- Includes individual record-level comparison
- Covers both matched and mismatched records	Precert Workflow for Structured Data Review (JEDI Platform)	The model will be used to identify, explain, and classify mismatches between source and target datasets submitted across various enterprise systems.

This system supports both operations and technology users in automating manual QA efforts during file comparisons. The ensemble model (Random Forest, SVM, Logistic Regression) processes engineered features from file pairs and generates predictions with confidence scores and mismatch reasons.

The system is integrated with upstream data pipelines and downstream Kafka consumers to enable smart feedback loops and explainability. The following logic is applied in production: <ul><li>If all classifiers agree on a valid match → the record is labeled as Matched, and passed downstream without manual review.</li><li>If classifiers agree on a specific mismatch type (e.g., Rounded Off Numbers) → the record is flagged as Mismatch, with a reason and confidence score.</li><li>If classifier results are inconclusive or disagree → the record is escalated for manual review and is tagged as Undecided.</li></ul>





1.2.3 Vendor Models
[This section is applicable for vendor models only. Model Sponsor must provide the rationale for use of a vendor model instead of a non-vendor model. The rationale should include at least the following factors:]
– The quality and transparency of vendor model documentation
– The stability and integrity of the implementation
– The financial stability of the vendor
– The depth and transparency of vendor model testing, version controls, and processes

Not applicable, the models are in-house built models.
The Precert AIML solution is developed internally using open-source frameworks like scikit-learn and Spark MLlib (Random Forest, Logistic Regression, SVM). It is maintained by the internal Data Engineering and Model Risk teams, ensuring transparency, full auditability, and lifecycle control without reliance on external vendors.

1.2.4 Fair Lending Requirement
[If prohibited base variables such as race, age or sex, are used in the model, the evidence of approval from the Head of Fair Lending Independent Compliance Risk Management (ICRM) is required.]

Not applicable.
The Precert AIML system does not use any personally identifiable information (PII) or prohibited variables such as age, race, or gender in its predictions. All inputs are anonymized structured data for numeric/string comparison purposes only. No Fair Lending approval is required.

1.3 Model Materiality Tier (MMT)
[Provide information required for MMT determination. Please refer to Chapter 2, Part I of the CMV Guidelines for how to assess model MMT.]

This model is considered low-to-medium risk.

Exposure: Moderate, as model output is used for pre-certification workflows that inform downstream alerting or manual QA steps — but not final decision-making.

Criticality: Low, as this model supports internal QA processes rather than customer-facing or revenue-impacting functions.

Materiality Tier: Medium, due to limited scope, high transparency, and involvement of human reviewers in edge cases.




Table 2: MMT – Data Input by Model Sponsor / Developer
MMT Element	Description
Portfolio ENR $	NA – Not Revenue Generating
ENR Date (as of)	NA – Not Revenue Generating
Adjusted ENR $	NA – Not Revenue Generating
ENR Adjustment Rationale	NA – Not Revenue Generating

Model Use
Choose from the following list that most accurately fits your model use. For your project, the best fit would be:

✅ Other Risk Management Models
The model is used to identify data mismatches and anomalies between structured source and target files, enabling automated classification and downstream decision-making. It serves as a smart QA utility for detecting root causes in data transformation pipelines and financial reconciliation systems.

Other options not selected (✓ only the most applicable one):

☐ Anti-Money Laundering (AML) / Sanctions Models

☐ ECM Credit Scoring Models

☐ Collections, Recovery & Bankruptcy

☐ Models for reporting

☐ Fraud

☐ Risk Segmentation

☐ Other DM models







