**PySpark Multi-Dataset Discrepancy curl.exe -s -X POST "https://jedi-ml-dev.apps.namoseswd22d.ecs.dyn.nsroot.net/predict" -H "Content-Type: application/json" -d "{\"rows\":[{\"f1\":1.23}]}"
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


# tests/test_smoke.py
from pathlib import Path
import importlib
import sys
import types
import pytest

# --- Resolve repo root ---
REPO_ROOT = Path(__file__).resolve().parents[1]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

CONFIG_PATH = REPO_ROOT / "spark" / "config" / "config.json"
CSV_SAMPLE  = REPO_ROOT / "spark" / "data" / "Test_12.csv"

def _safe_import(module_name: str) -> types.ModuleType:
    """Import a module and return it; fail fast with clear error."""
    try:
        return importlib.import_module(module_name)
    except Exception as exc:
        raise AssertionError(f"Failed to import {module_name}: {exc}") from exc

def test_repo_root_present():
    assert REPO_ROOT.exists()

def test_config_exists():
    assert CONFIG_PATH.exists(), f"Missing {CONFIG_PATH}"

def test_imports_ok():
    for mod in ("model_training", "Models"):
        _safe_import(mod)

def test_models_has_expected_symbols():
    models = _safe_import("Models")
    expected = ["train_main", "ml_Training"]
    missing = [name for name in expected if not hasattr(models, name)]
    assert not missing, f"Models.py missing {missing}"

@pytest.mark.skipif(not CSV_SAMPLE.exists(), reason="CSV not committed")
def test_sample_csv_present_and_nonempty():
    assert CSV_SAMPLE.stat().st_size > # ---- Base: Citi-approved Miniconda (has conda preinstalled) ----
FROM docker-enterprise-prod-local.artifactrepository.citigroup.net/developersvcs-python-ai/miniconda-rhel8/23.5-py3.12:latest

# ---- App paths & pip config (same spirit as the template) ----
ENV APP_HOME=/app \
    VIRTUALENV_HOME=/app/pyenv \
    PIP_CONFIG_FILE=/app/pip.conf \
    PIP_TRUSTED_HOST=www.artifactrepository.citigroup.net

WORKDIR ${APP_HOME}

# ---- Create a non-root user (best practice) ----
RUN groupadd -r appgroup && useradd -r -g appgroup appuser \
 && mkdir -p ${APP_HOME} ${VIRTUALENV_HOME} \
 && chown -R appuser:appgroup ${APP_HOME}

# ---- Java via conda (works on this base image) ----
# This solves the "conda: command not found" / "yum: no package" problems.
RUN conda install -y -c conda-forge openjdk=11 && conda clean -afy
ENV JAVA_HOME=/opt/conda
ENV PATH="${JAVA_HOME}/bin:${PATH}"

# ---- Python deps (layered for better cache) ----
# (Keep a pip.conf beside requirements.txt if you need internal indexes)
COPY requirements.txt ./
RUN python -m pip install --upgrade pip \
 && pip install --no-cache-dir -r requirements.txt

# ---- App code ----
COPY . ${APP_HOME}

# ---- Security posture: drop root ----
RUN chown -R appuser:appgroup ${APP_HOME}
USER appuser

# ---- Make your src importable (optional but handy) ----
ENV PYTHONPATH=${APP_HOME}/app/src

# ---- Default: run Spark job ----
# If you need args, add them after model_training.py or pass at runtime.
CMD ["spark-submit", "model_training.py"]

