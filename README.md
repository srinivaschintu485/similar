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


Overview.
The final feature set for the mismatch‐classification model was selected using a combined statistical + business interpretability approach. We retained engineered variables that (i) measurably contributed signal to the dependent variable (Label) during EDA and (ii) map directly to explainable reconciliation root causes (e.g., thousand separator, rounding, case sensitivity, special characters, spacing, leading zeros, scientific notation). Because the model is deployed in a regulated environment, explainability and root-cause traceability were prioritized over aggressive statistical pruning.

A. Evidence-Based Feature Assessment

During EDA we evaluated each engineered feature against the target using correlation/association analyses and class-wise diagnostics. The Pearson correlation with the target (absolute values shown where helpful) indicated the following strength of association:

Thousand_Separator r ≈ +0.529

Rounded_Off r ≈ +0.209

Scientific_Notation r ≈ +0.192

Special_Character_Diff r ≈ +0.188

numeric_check r ≈ +0.156

Perfect_match r ≈ +0.101

Special_Character_Score r ≈ +0.082

Case_Sensitive_Score r ≈ +0.066

space_score r ≈ +0.057

Negative_Check r ≈ −0.085

source_len r ≈ −0.065; destination_len r ≈ −0.104

Case_Insensitive_Score r ≈ −0.203

Leading_Zero r ≈ −0.274

Space_diff r ≈ −0.278

Case_Sensitivity_Diff r ≈ −0.416

Interpretation: positive correlations align with “mismatch” evidence (e.g., Thousand_Separator, Rounded_Off), while negative correlations indicate “non-mismatch” evidence or complementary signals that help the classifier distinguish borderline cases (e.g., Case_Sensitivity_Diff, Space_diff).

We also reviewed an association matrix (uncertainty coefficient / correlation ratio) to capture non-linear relations and co-occurrence between features (e.g., special characters often co-occur with spacing issues; case features are partially orthogonal to numeric-format features). This supported keeping features with modest univariate correlations that add combinatorial signal in the multivariate model.

B. Inclusion / Exclusion Rationale

Included (all engineered variables).
No features were dropped. Rationale:

Root-cause traceability: Each feature corresponds to a real, auditable discrepancy type (thousand separator, rounding, scientific notation, case, special characters, spaces, leading zeros, numeric validity, length context). Retaining them enables clear reason codes in outputs.

Complementarity: Features with lower standalone correlation (e.g., space_score, Case_Sensitive_Score) improved separation when combined with similarity/formatting indicators; SHAP/feature importance confirmed additive value.

Governance/Explainability: In AML/CVM contexts, interpretability is required; sparse or opaque feature sets would reduce reviewability and hinder issue remediation by operations.

Not included.
No additional derived interactions or latent embeddings were introduced to avoid reducing transparency. Feature space remains schema-agnostic yet interpretable.


C. Final Feature Set by Role (examples)

| Category              | Representative Variables (non-exhaustive)                                                                                      | Purpose                                                           |
| --------------------- | ------------------------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------- |
| **Numeric Format**    | Thousand\_Separator, Rounded\_Off, Scientific\_Notation, numeric\_check                                                        | Detects formatting mismatches and numeric coercion/precision loss |
| **Text / Similarity** | Perfect\_match, space\_score, Space\_diff                                                                                      | Captures token similarity and whitespace anomalies                |
| **Case & Symbols**    | Case\_Sensitive\_Score, Case\_Insensitive\_Score, Case\_Sensitivity\_Diff, Special\_Character\_Score, Special\_Character\_Diff | Identifies case and symbol deviations                             |
| **Length / Context**  | source\_len, destination\_len                                                                                                  | Provides structural context for unexpected truncation/padding     |
| **Sanity / Polarity** | Negative\_Check                                                                                                                | Catches sign inversions                                           |

D. Model Choice & Hyperparameter Selection

We benchmarked linear (Logistic Regression), margin-based (SVM-OVR), and ensemble methods. The Random Forest ensemble was selected for the final specification due to its balanced F1, robustness to feature scale, non-linear capture, and transparent feature importance.

Tuning methodology.

Search: stratified 5-fold cross-validation grid over n_estimators, max_depth, min_samples_split, min_samples_leaf, and class_weight.

Objective: maximize macro-F1 and balanced accuracy to mitigate class imbalance.

Controls: early stopping by OOB/per-fold plateau; shallow to medium max_depth to prevent overfit to dominant classes (e.g., No Match).

Weights: class_weight=balanced (or calibrated custom weights) to improve recall for minority types (Leading Zero, Scientific Notation).

Resulting model characteristics (illustrative):

n_estimators = 300–500; max_depth = 8–14; min_samples_leaf = 2–5; class_weight = balanced.

Top global importances consistently included Thousand_Separator, Similarity/Spacing features, Rounded_Off, and Scientific_Notation, with case/special-character features providing secondary but explainable lift.

E. Judgment & Governance Justification

Why keep lower-correlation features? They map to distinct operational causes and improve reason code fidelity; their interactions with high-signal variables increased macro-F1 in CV.

Why not add/retain only statistically strongest variables? A purely statistical subset reduced transparency and under-performed on minority mismatch categories; the full interpretable set achieved better balanced performance and auditability.

Regulatory alignment: Choices favor interpretability, reproducibility, and stability (no fragile feature engineering or opaque embeddings), consistent with MRM expectations.
