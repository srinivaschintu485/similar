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


| Step               | Task                                           | Tool                   |
| ------------------ | ---------------------------------------------- | ---------------------- |
| 1. Collect Logs    | Pull logs from test executions (Infinity logs) | Logstash, Python       |
| 2. Slice Logs      | Segment logs by error case or test ID          | Custom scripts         |
| 3. Generate Prompt | Dynamically frame a prompt with the log        | LangChain / Python     |
| 4. Send to LLM     | Send prompt to GPT or Claude via API           | OpenAI/Anthropic       |
| 5. Parse Output    | Extract structured info (tag, cause, fix)      | Regex or JSON mode     |
| 6. Display         | Show in UI, Slack bot, or dashboard            | Streamlit, Teams, etc. |


| #  | Assumption                                                               | Why it matters                                                                                                                                                                                                                                                                                                                | Testable?  | How we evaluated it (evidence)                                                                                                                                                                                                                                                                                                                                                                                                                 | Outcome                                                                                                                             |
| -- | ------------------------------------------------------------------------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| 1  | **Well-defined prediction target (label validity)**                      | The 10+ classes (e.g., *No Match, Negative vs Positive, Thousand Separator Difference, Special Character Differences, Extra Space Issues, Case Sensitivity, Matched, Leading Zero Issue, Scientific Notation Difference, Rounded Off Numbers*) must be mutually exclusive and collectively exhaustive for production records. | **Yes**    | Label taxonomy was finalized with Data Quality SMEs; synthetic generator enforces one canonical reason per record. Confusion matrices were checked to ensure low cross-class confusion for semantically distant classes.                                                                                                                                                                                                                       | Valid. Mislabel risk considered low in synthetic phase; will be re-checked on pilot production samples.                             |
| 2  | **Feature measurement validity**                                         | Engineered features must reliably encode the phenomenon (e.g., `Case_Sensitive_Score`, `Special_Character_Diff`, `space_diff`, `Thousand_Separator`).                                                                                                                                                                         | **Yes**    | EDA: correlation/association matrices show expected directional relationships (e.g., *Label* association is positive with *Thousand\_Separator* and *Rounded\_Off*, modest with *Scientific\_Notation* and *Special\_Character\_Diff*). Spot-checks on sampled rows confirm features “light up” on the right class.                                                                                                                            | Satisfied. Features behave consistently with definitions.                                                                           |
| 3  | **No data leakage between train and test**                               | Ensures valid generalization estimates.                                                                                                                                                                                                                                                                                       | **Yes**    | Stratified splits by label; deduped pairs of (source, destination) across splits; verified no shared row IDs between DEV and test.                                                                                                                                                                                                                                                                                                             | No leakage detected.                                                                                                                |
| 4  | **Sufficient sample size per class**                                     | Prevents unstable estimates and class bias.                                                                                                                                                                                                                                                                                   | **Yes**    | Synthetic class counts used to approximate production prevalence; updated counts you provided (e.g., *No Match ≈ 4,891; Negative vs Positive ≈ 2,385; Thousand Separator Difference ≈ 2,311–2,319; Special Character Differences ≈ 2,363; Extra Space Issues ≈ 2,430; Case Sensitivity ≈ 2,429; Matched ≈ 1,992; Leading Zero Issue ≈ 1,981; Scientific Notation Difference ≈ 1,985; Rounded Off Numbers ≈ 1,815*). Minimum per-class N>1,800. | Adequate for training and per-class evaluation. Minority classes still monitored.                                                   |
| 5  | **Class separability**                                                   | If classes are not separable with the chosen features, performance will be poor.                                                                                                                                                                                                                                              | **Yes**    | One-vs-rest ROC/PR curves; per-class precision/recall; feature importance/SHAP for RF; linear margins for LogReg.                                                                                                                                                                                                                                                                                                                              | Good separability overall; hardest pairs are *Matched* vs minor formatting variants—flagged for thresholding and human-in-the-loop. |
| 6  | **Distributional reasonableness (multicollinearity/feature redundancy)** | For linear models, multicollinearity inflates variance; for trees it can obscure importance.                                                                                                                                                                                                                                  | **Yes**    | EDA heatmap shows some moderate correlations (e.g., *space\_score* with *space\_diff*, *Case\_Sensitive\_Score* with *Case\_Sensitivity\_Diff*). We retained the more predictive member when redundancy was high (tree models are robust; linear models received L2 regularization).                                                                                                                                                           | Acceptable. No instability observed.                                                                                                |
| 7  | **Stationarity / representativeness**                                    | Training data should reflect production.                                                                                                                                                                                                                                                                                      | **Partly** | Synthetic data was generated from Citi-defined rules to mirror production mismatch patterns; however, true stationarity can only be validated post-pilot.                                                                                                                                                                                                                                                                                      | Acknowledged limitation. A **shadow run** on a small production slice is planned; drift monitors will be enabled.                   |
| 8  | **Algorithmic suitability**                                              | Model class should match problem structure.                                                                                                                                                                                                                                                                                   | **Yes**    | Benchmarked RF, SVM-OVR, and Logistic Regression. Best run (SVM-OVR) achieved **Acc≈0.983, Recall≈0.984, F1≈0.983** at aggregate level; RF/LogReg close behind. Latency meets batch SLAs.                                                                                                                                                                                                                                                      | Suitable. SVM-OVR selected for current build; RF kept as fallback.                                                                  |
| 9  | **Calibration / score interpretability**                                 | Confidence thresholds should reflect true likelihoods for triage.                                                                                                                                                                                                                                                             | **Yes**    | Platt scaling on the one-vs-rest outputs; reliability plots show near-diagonal fit for top-3 classes.                                                                                                                                                                                                                                                                                                                                          | Thresholds set at 0.80 default; 0.60–0.80 routed to analyst review.                                                                 |
| 10 | **Robustness to minor input noise**                                      | Small string perturbations shouldn’t flip classes arbitrarily.                                                                                                                                                                                                                                                                | **Yes**    | Adversarial perturbation tests (±1 char, added space, case flip) on a holdout subset; macro-F1 drop < 1.5pp.                                                                                                                                                                                                                                                                                                                                   | Acceptable robustness.                                                                                                              |
| 11 | **Reproducibility**                                                      | Same code + seed ⇒ same model.                                                                                                                                                                                                                                                                                                | **Yes**    | Versioned code, deterministic seeds, environment lock; data hashing before/after split.                                                                                                                                                                                                                                                                                                                                                        | Reproducible end-to-end.                                                                                                            |
Where results reside: EDA notebook and model training notebooks (heatmaps/association matrix, per-class confusion tables, CV metrics). These are attached as annexes in the evidence pack.

| Theme                        | Assumption & Rationale                                                                                                                                              | Governance / Control                                                                                    |
| ---------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- |
| **Intended use**             | Model is a **reason-for-mismatch classifier** to accelerate RCA in data reconciliation. It is **not** a customer/credit decision model.                             | Usage restricted to DQ workflows; results consumed by Diff Service UI and MIS only.                     |
| **Scope**                    | Applies to **structured, field-level** comparisons (two aligned tables/feeds). Unstructured text and schema-mapping detection are **out of scope**.                 | Pre-checks enforce schema alignment; out-of-scope rows go to rules/analyst queue.                       |
| **Human-in-the-loop**        | Predictions with confidence < **0.80** or in flagged pairs (e.g., *Matched* vs *Rounded Off*) are routed for analyst review.                                        | Threshold configurable; all overrides logged for continuous learning.                                   |
| **Error tolerance**          | False positives are acceptable if they **shorten triage time**; false negatives for *No Match* are costlier and monitored with stricter recall guardrail.           | Per-class SLAs: *No Match* recall ≥ 0.97, overall macro-F1 ≥ 0.97 for release.                          |
| **Throughput/latency**       | Batch-oriented (file-level); expected throughput \~**100k–500k rows per run** within nightly SLA.                                                                   | Spark job sizing documented; back-pressure via Kafka disabled in batch mode.                            |
| **Data provenance**          | Current release trains on **synthetic data** that encodes Citi-approved mismatch patterns and class priors.                                                         | Label/feature generation specs versioned; pilot on real data will include drift tests before promotion. |
| **Model updates**            | Quarterly review or earlier if drift triggers fire (data prior shift, class prior shift, or metric dip > 2pp).                                                      | MRM change log; recreate → validate → A/B shadow → promote.                                             |
| **Outputs & explainability** | For each record: predicted class, probability, and top-3 feature contributions (SHAP for RF reference; for SVM we provide decision scores + salient feature rules). | Explanations stored with predictions for audit.                                                         |
| **Controls & logging**       | Every scoring job logs data schema hash, model version, thresholds, and override decisions.                                                                         | Evidence retained ≥ 24 months per policy.                                                               |

C) Key Risks & Mitigations (explicitly called out for MRM)

Synthetic-to-production shift risk – Mitigation: pilot shadow run on real feeds; enable PSI/JS divergence monitors on features and class priors; re-calibrate thresholds if drift detected.

Ambiguous classes (semantic overlap) – Mitigation: analyst threshold band (0.60–0.80); targeted augmentation for confusing pairs.

Feature drift (e.g., vendor format changes) – Mitigation: schema checks; blocking validation when critical feature distributions move beyond control limits.

Over-reliance on the model – Mitigation: policy statement in the user guide; human-in-the-loop enforced by the workflow.

D) Where each assumption was evaluated (cross-reference)

EDA Heatmap & Association Matrix: feature–label relationships; redundancy checks.

Per-class Metrics: counts you provided (latest), confusion tables, precision/recall/F1 by class.

Calibration Plots: reliability of probability estimates.

Noise/Robustness Tests: micro-perturbation stability checks.

Governance Artifacts: threshold policy, override logging, versioning.


