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

File contents to drop in
1) .env.sample (root)
APP_MODE=recon
PYSPARK_PYTHON=python3

DATA_PATH=/app/data
OUTPUT_PATH=/app/output
LOG_PATH=/app/logs

DB_URL=jdbc:oracle:thin:@GENSIDA.orass.dyn.nsroot.net:8889:GENSIDA
DB_TABLE=FLOW_AUDIT_LOG
DB_USER=DVSM_SANDOBX06
DB_PASSWORD=REPLACE_ME
DB_DRIVER=oracle.jdbc.OracleDriver

KAFKA_BOOTSTRAP=host:9093
KAFKA_SECURITY_PROTOCOL=SSL
KAFKA_PEM=/data1/gfrssn/bin/RRTS_BO_BATCH/DATA_OPS_SERVICE/certs/Citi_DEVELOPMENT_chain.pem
KAFKA_KEYSTORE=/app/kafkas/DEV_cacerts.jks
KAFKA_KEYSTORE_PWD=changeit
KAFKA_GROUP_ID=jedi-ml-test


Update .gitignore (root — add these lines if missing):

.env
*.env
models/*.pkl
models/*.joblib
models/*.bin

2) pytest.ini (root)
[pytest]
minversion = 7.0
python_files = test_*.py
testpaths = tests
addopts = -q

3) tests/__init__.py
# empty – marks tests as a package

4) tests/test_ml_utils.py
import os, sys

# make imports work like in ml_predictions.py
ROOT = os.path.dirname(os.path.dirname(__file__))
UTILS = os.path.join(ROOT, "ml_utils")
for p in (ROOT, UTILS):
    (p not in sys.path) and sys.path.append(p)

from ml_utils.alpha_check import numeric_check
from ml_utils.thousand_separator import thousand_separator_difference
from ml_utils.get_fuzzy_scores import get_fuzzy_scores

def test_numeric_check_basic():
    assert numeric_check("12", "34") == 22222
    assert numeric_check("x", "34") == 0

def test_thousand_separator_difference():
    assert thousand_separator_difference("1,234", "1234") is True

def test_get_fuzzy_scores_shape():
    scores = get_fuzzy_scores("apple", "appl e")
    assert isinstance(scores, tuple) and len(scores) >= 8

5) .github/workflows/smoke.yml (optional but useful)
name: Smoke (entry.sh dry-run)

on:
  workflow_dispatch:
  pull_request:
    paths:
      - 'entry.sh'
      - 'Dockerfile'
      - 'requirements.txt'
      - 'recon_main.py'

jobs:
  smoke:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: docker/setup-buildx-action@v3
      - name: Build image
        uses: docker/build-push-action@v6
        with:
          context: .
          file: ./Dockerfile
          push: false
          tags: ml-smoke:pr
      - name: Run entry.sh help
        run: |
          docker run --rm ml-smoke:pr /app/entry.sh || true

6) config/app_runtime.json
{
  "spark": { "appName": "JediML", "master": "local[*]" },
  "data": {
    "hdfs_path": "hdfs:///grndev/data/gfrrssng/app/d1/jediaiml/",
    "hdfs_data_path": "hdfs:///grndev/data/gfrrssng/app/d1/jediaiml/data/"
  },
  "logPath": { "windows": "/app/logs", "linux": "/app/logs" },
  "db": {
    "url": "${DB_URL}",
    "table": "${DB_TABLE}",
    "user": "${DB_USER}",
    "password": "${DB_PASSWORD}",
    "driver": "${DB_DRIVER}"
  }
}


(You can keep using the explicit db_config in recon_main.py; this JSON is for centralizing config if/when you switch.)

7) models/.gitkeep

(empty file – just commit it)

8) scripts/get_models.sh (optional)
#!/usr/bin/env bash
set -euo pipefail
DEST="${1:-/app/models}"
mkdir -p "$DEST"

# Example pulls (uncomment + adapt)
# aws s3 cp s3://your-bucket/jedi-ml/Random_forest.pkl "$DEST/Random_forest.pkl"
# aws s3 cp s3://your-bucket/jedi-ml/Logistic_Regression.pkl "$DEST/Logistic_Regression.pkl"
# aws s3 cp s3://your-bucket/jedi-ml/SVM.pkl "$DEST/SVM.pkl"

echo "Models downloaded to $DEST"


Make it executable:

git update-index --chmod=+x scripts/get_models.sh

🛠️ Quick create commands

From repo root:

mkdir -p .github/workflows config models scripts tests
touch models/.gitkeep tests/__init__.py .env.sample pytest.ini
# then paste the file contents above into each file
