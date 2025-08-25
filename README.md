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



# one_plot_per_model.py
# Creates exactly ONE plot per model:
#   - random_forest_accuracy.png
#   - svm_ovr_accuracy.png
#   - logistic_regression_accuracy.png

import os
import pandas as pd
import matplotlib.pyplot as plt

OUT_DIR = "one_plot_per_model_outputs"
os.makedirs(OUT_DIR, exist_ok=True)

# ==== 1) REPLACE THESE LISTS WITH YOUR REAL RUNS ====

# Random Forest runs
rf_runs = [
    {"numTrees": 50,  "maxDepth": 5,  "criterion": "gini",    "extra": 1, "accuracy": 0.9830},
    {"numTrees": 50,  "maxDepth": 10, "criterion": "gini",    "extra": 1, "accuracy": 0.9998},
    {"numTrees": 50,  "maxDepth": 15, "criterion": "gini",    "extra": 1, "accuracy": 1.0000},
    {"numTrees": 50,  "maxDepth": 15, "criterion": "entropy", "extra": 1, "accuracy": 0.9999},
    {"numTrees": 100, "maxDepth": 15, "criterion": "gini",    "extra": 1, "accuracy": 1.0000},
]

# SVM (One-vs-Rest) runs
svm_runs = [
    {"maxIter": 50,  "C": 0.001,  "gamma": 0.0001, "accuracy": 0.9512},
    {"maxIter": 100, "C": 0.01,   "gamma": 0.0001, "accuracy": 0.9720},
    {"maxIter": 150, "C": 0.1,    "gamma": 0.001,  "accuracy": 0.9785},
    {"maxIter": 200, "C": 0.0001, "gamma": 0.0001, "accuracy": 0.9830},
]

# Logistic Regression runs
lr_runs = [
    {"maxIter": 50,  "regParam": 0.01,   "elasticNetParam": 0.0, "accuracy": 0.8850},
    {"maxIter": 100, "regParam": 0.001,  "elasticNetParam": 0.5, "accuracy": 0.9725},
    {"maxIter": 200, "regParam": 0.0001, "elasticNetParam": 1.0, "accuracy": 1.0000},
]

# ==== 2) Helper to build combo label and plot a single figure per model ====

def to_df(runs, order_cols):
    df = pd.DataFrame(runs)
    df["combo"] = df[order_cols].astype(str).agg(" | ".join, axis=1)
    # order by accuracy (desc) for readability
    return df.sort_values("accuracy", ascending=False).reset_index(drop=True)

def plot_one(df, title, outfile):
    if df.empty:
        return
    plt.figure(figsize=(12, 6))
    plt.plot(range(len(df)), df["accuracy"], marker="o")
    plt.xticks(range(len(df)), df["combo"], rotation=75, ha="right", fontsize=8)
    plt.ylabel("Accuracy")
    plt.xlabel("Hyperparameter Combination")
    plt.title(title)
    plt.tight_layout()
    plt.savefig(outfile, dpi=200)
    plt.close()

# ==== 3) Make exactly ONE plot per model ====

# Random Forest
rf_df = to_df(rf_runs, ["numTrees", "maxDepth", "criterion", "extra"])
plot_one(rf_df, "Random Forest: Accuracy vs Hyperparameter Combination",
         os.path.join(OUT_DIR, "random_forest_accuracy.png"))

# SVM OVR
svm_df = to_df(svm_runs, ["maxIter", "C", "gamma"])
plot_one(svm_df, "SVM (OVR): Accuracy vs Hyperparameter Combination",
         os.path.join(OUT_DIR, "svm_ovr_accuracy.png"))

# Logistic Regression
lr_df = to_df(lr_runs, ["maxIter", "regParam", "elasticNetParam"])
plot_one(lr_df, "Logistic Regression: Accuracy vs Hyperparameter Combination",
         os.path.join(OUT_DIR, "logistic_regression_accuracy.png"))

print("Done. Wrote three plots to:", os.path.abspath(OUT_DIR))
