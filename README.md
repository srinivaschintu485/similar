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




External Vendor Data (Sufficiency, Accuracy, Reliability)

Applicability statement.
For this project there is no external vendor data used for model development or validation. All data are generated/curated in-house from controlled sources and deterministic transformation scripts. Because the MDDT template requires this section, we document (i) how “external-like” risks are mitigated for our internal feeds and synthetic augmentations, and (ii) what controls are in place should a true vendor feed be onboarded later.

**Source & Transport (what we actually use)**

Origins: structured files (CSV/Excel) produced inside the bank; synthetic augmentations created by Python utilities to introduce specific, labeled discrepancies (e.g., add thousands separator, toggle sign, pad spaces, change case, scientific notation, rounding).

Transport: secure internal share and Kafka topics (Kerberos-enabled). Ingestion jobs log record counts, schema hashes and load status.

Data Sufficiency (volume, coverage, balance)

Training/analysis corpus size ≈ 122,411 labeled records across the 10 discrepancy classes:


| Label                          |      Count |
| ------------------------------ | ---------: |
| No Match                       | **24,357** |
| Negative vs Positive           | **12,000** |
| Thousand Separator Difference  | **11,984** |
| Special Character Differences  | **11,704** |
| Extra Space Issues             | **11,692** |
| Case Sensitivity               | **11,604** |
| Matched                        | **10,083** |
| Leading Zero Issue             | **10,000** |
| Scientific Notation Difference | **10,000** |
| Rounded Off Numbers            |  **8,987** |

Coverage: Classes span numeric formatting, string formatting and true mismatch (“No Match”).

Balance: Largest/smallest class ratio ≈ 2.7:1 (24,357 vs. 8,987), acceptable for multi-class training with standard class-weighting.

Feature adequacy: Engineered features align with targets (e.g., Thousand_Separator shows the strongest association with the Thousand Separator Difference cases; Case_Sensitive_Score/Diff with Case Sensitivity, etc.), as evidenced by your correlation/association analyses.

Conclusion: Volume and class distribution are sufficient for supervised learning and robust evaluation.

Deterministic labeling and post-generation integrity checks ensure accuracy; EDA correlation/association results further confirm that engineered features align with their respective discrepancy classes. Robust lineage, reproducibility, and quarantine controls are in place. If a vendor feed is onboarded in future, we will impose formal SLAs, acceptance thresholds, provenance attestations, and continuous quality monitoring.


Detailed Data Quality Checks
1. Duplicate Records

What was done: We checked for exact and near-duplicate records across the dataset.

Findings: No large-scale duplication was observed, but isolated duplicates were flagged and removed to avoid bias in frequency-based features (e.g., Similarity_Percentage).

Impact if ignored: Duplicates can over-represent certain mismatch patterns and distort the model’s learning.

2. Missing / Default / Zero Values

What was done: Columns were scanned for missing (NaN) or default placeholders (e.g., 0, 999, "NA").

Findings (EDA evidence):

Case Sensitivity: 11,604 rows

Extra Space Issues: 11,692 rows

Leading Zero Issue: 10,000 rows

Rounded Off Numbers: 8,987 rows

Scientific Notation Difference: 10,000 rows

Special Character Differences: 11,704 rows

Thousand Separator Difference: 11,984 rows

No Match Cases: 24,357 rows (≈20% of total)

These indicate structured categories rather than random missingness.

Resolution: All “missing or default categories” were explicitly tagged and carried forward for the model as categorical signals rather than imputed, since they hold semantic meaning (e.g., No Match).

3. Outlier Detection

What was done: Distributional analysis and correlation checks were performed (heatmaps, boxplots, and correlation with label).

Findings:

Outliers were less frequent in engineered scores (e.g., Case_Sensitivity_Score, Special_Character_Score) due to bounded ranges (0–1).

Some extreme differences in source_len vs destination_len (long text vs short text mismatch) were preserved since they are meaningful.

Resolution: Outliers were not removed, but capped in feature scaling where necessary (e.g., log transformation for very long length differences).

4. Data Format Conformity

What was done: Schema validation (checking float64, int64, object) to ensure type correctness.

Findings:

Most engineered features stored as float64.

Label was categorical but initially stored as object. It was recoded into integer categories for consistency.

Resolution: Explicit conversions were done to maintain consistency across pipeline stages.

5. Record Mapping & Business Logic

What was done: Each row maps a Source field against a Destination field, with mismatch features (Negative_Check, Case_Sensitivity, Special_Character_Diff, etc.).

Checks performed:

Ensured each mapping has exactly one Source and one Destination.

Cross-verified that engineered features (e.g., Thousand_Separator_Diff) align with raw field mismatch logs.

Findings: No mismapping detected.


Objective

Apply deterministic, reversible cleaning so the engineered features faithfully represent the real-world mismatch patterns (spaces, case, separators, rounding, scientific notation, polarity, leading zeros, special characters). No row drops unless a comparison is invalid (e.g., one side missing after trim). No class rebalancing, no winsorization, no imputations that would distort the target signal.


| #  | Cleaning action                          | Formal rule (what the code enforces)                                                                              | Why it’s needed                                               | Output field(s) affected                                                                      |
| -- | ---------------------------------------- | ----------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------- | --------------------------------------------------------------------------------------------- |
| 1  | **Whitespace normalization**             | `strip()` both sides; collapse internal multi-spaces to single space for *feature computation only*               | Prevents spurious mismatches from padding                     | `Space_diff`, `space_score`, `Similarity_Percentage`                                          |
| 2  | **Case normalization (derivation only)** | Derive both **case-sensitive** and **case-insensitive** similarities; compute `Case_Sensitivity_Diff = CIS − CSS` | Separates true case issues from content issues                | `Case_Sensitive_Score`, `Case_Insensitive_Score`, `Case_Sensitivity_Diff`                     |
| 3  | **Numeric parsing & canonicalization**   | Robust parse tolerant to `+/-`, decimals, grouping; normalize to canonical numeric for comparison                 | Detects numeric-only reasons accurately                       | `numeric_check`, `Rounded_Off`, `Thousand_Separator`, `Scientific_Notation`, `Negative_Check` |
| 4  | **Thousands separator standardization**  | Remove locale separators (`,`, non-breaking space, `.` where locale dictates) **for feature derivation**          | Avoids false “No Match” when numbers differ only by grouping  | `Thousand_Separator` (+ internal helpers)                                                     |
| 5  | **Scientific notation normalization**    | Convert `1.23E+05` ↔ `123000` to a common numeric form                                                            | Ensures consistent magnitude checks                           | `Scientific_Notation`                                                                         |
| 6  | **Rounding tolerance**                   | Compare to *n* decimal places (configurable), flag if equality holds at tolerance                                 | Captures “Rounded Off Numbers” systematically                 | `Rounded_Off`                                                                                 |
| 7  | **Leading zero handling**                | Preserve left-padding when type is **string ID**; detect equality after stripping leading zeros                   | Distinguishes ID formatting from true value change            | `Leading_Zero`                                                                                |
| 8  | **Special-character normalization**      | Derive scores with/without punctuation; Unicode-aware symbol strip during derivation                              | Isolates punctuation/symbol-only differences                  | `Special_Character_Score`, `Special_Character_Diff`                                           |
| 9  | **Length checks**                        | Compute `source_len`, `destination_len` post basic trims                                                          | Aids diagnostics; long/short asymmetry is explanatory         | `source_len`, `destination_len`                                                               |
| 10 | **Type casting for modeling**            | Cast all feature columns to `float` before `VectorAssembler`                                                      | Prevents schema drift/runtime errors; keeps pipeline stable   | all numeric feature columns                                                                   |
| 11 | **Invalid comparison filter**            | Drop row **only if** (a) either side empty after trim, or (b) any engineered feature is `NULL/NaN/Inf`            | Invalid pairs cannot be interpreted; protect target integrity | dataset rows (rare)                                                                           |


Evidence (what to hand to reviewers)
| Check                            | Statistic / Threshold                      |                              Observed result | Artifact                                |
| -------------------------------- | ------------------------------------------ | -------------------------------------------: | --------------------------------------- |
| Schema + dtype post-cast         | all modeled cols numeric (`float/double`)  |                    ✅ Passed for 100% columns | Spark `printSchema()` snapshot          |
| Null / NaN / Inf scan (features) | 0 allowable                                |                      ✅ 0 across all features | DQ summary CSV (per-column null counts) |
| Bounds (scores/percents)         | `[0,1]` or `[0,100]` as defined            |                              ✅ No violations | Range-violation report                  |
| Key duplication                  | composite key duplicates = 0               |                                          ✅ 0 | Duplicate query result                  |
| Invalid comparisons removed      | < 1% of total rows                         | ✅ Within limit; flagged to “quarantine” file | Quarantine CSV                          |
| Class mix pre vs post clean      | absolute move ≤ ±0.5 pp per major class    |                           ✅ Within tolerance | Class count table (pre/post)            |
| Cross-feature logic              | e.g., `Perfect_match=1 ⇒ all diff-flags=0` |                     ✅ Holds (exceptions = 0) | Rule-check log                          |




Impact Statement (on portfolio & downstream use)

Representativeness: Cleaning is signal-preserving; we do not “smooth away” the very anomalies we aim to classify.

Bias control: No class rebalancing or selective row culls; class proportions stay essentially the same.

Auditability: Every transformation is deterministic and logged (input hash, schema version, generator version, parameters, rule outcomes).

Explainability: For any prediction, we can show the raw pair, the engineered features that fired (e.g., Thousand_Separator=1, Rounded_Off=0), and the final reason label.

4.6 Production Guardrails (what runs every batch)

Gate checks: schema contract, dtype, hash, row-count parity, key duplication = 0, feature null scan = 0.

Bounds & logic: score bounds, Perfect_match consistency, numeric parsing success rate ≥ 99.9%.

Drift watch: class distribution delta alert if any class moves >3 pp from baseline; PSI ≥ 0.2 on top features triggers review.

Quarantine lane: any violating rows/files are held, summarized, and ticketed; model run proceeds on clean slice only.

Lineage: persist run ID, code hash, config, and DQ report alongside outputs.

























