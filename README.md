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







Awesome — here’s a **single, end-to-end master prompt** you can paste into your favorite code agent to scaffold and implement a **Text-to-SQL RAG** service. It includes the **project skeleton, files to create, module responsibilities, prompt templates, guardrails, hybrid retrieval, schema parsing, tests, Docker, and acceptance criteria**.

---

# MASTER BUILD PROMPT (copy/paste below)

You are an expert ML + backend engineer. Build a production-grade **Text-to-SQL RAG** service that converts natural language questions to **safe, read-only SQL** using schema-aware retrieval.

## 0) High-level Goal

Create a Python 3.11 project that:

1. Ingests DB schemas (DDL or JSON) → normalizes into **schema cards**
2. Indexes cards in **hybrid retrieval** (BM25 + FAISS dense)
3. Generates SQL using an LLM (local HF model) **constrained by the retrieved context**
4. Applies **guardrails** (SELECT-only, LIMIT injection, allowlist tables/cols)
5. Optionally executes SQL on DuckDB (dev) and returns preview rows
6. Exposes a **FastAPI** endpoint `/sql`
7. Ships with tests, an eval harness, Dockerfile, Makefile, and README.

## 1) Tech Stack

* Python 3.11, FastAPI, Uvicorn
* Retrieval: `sentence-transformers` (e.g., `bge-small-en-v1.5`), `faiss-cpu`, BM25 via `rank_bm25`
* Generation: HF `Salesforce/codet5p-770m-sql` (Seq2Seq) (pluggable), or `defog/sqlcoder` variant (CausalLM)
* SQL tooling: `sqlglot` (parse/normalize), `sqlparse` (simple splitting), `duckdb` (dev execute)
* Utility: `pydantic`, `python-dotenv`, `pyyaml`, `tqdm`
* Testing: `pytest`, `httpx`
* Lint/format: `ruff`, `black`

## 2) Project Structure (create exactly)

```
text2sql-rag/
  app/
    main.py
    api_models.py
  rag/
    __init__.py
    schema_parser.py      # DDL/JSON → canonical dicts
    cards.py              # build compact "schema cards" from parsed schema
    index.py              # FAISS + BM25 build/load logic
    retriever.py          # hybrid retrieve + fusion
    rerank.py             # optional cross-encoder (stub with TODO)
    prompts.py            # system & user prompt templates
    generator.py          # wraps HF model(s)
    guardrails.py         # SELECT-only, LIMIT, allowlists
    executor.py           # duckdb execute (dev)
    confidence.py         # simple confidence estimator
  scripts/
    export_schema.py      # (optional) live DB → DDL
    build_index.py        # from schema_docs.jsonl → faiss + bm25 cache
  data/
    schema_docs.jsonl     # generated cards (source of truth)
    faiss.index           # generated
    bm25.pkl              # generated
    meta.json             # generated metadata per item
  configs/
    config.example.yaml
  tests/
    test_guardrails.py
    test_retrieval.py
    test_api.py
    fixtures/
      tiny_schema.sql
      tiny_schema.json
      eval_qas.jsonl
  .env.example
  requirements.txt
  Dockerfile
  Makefile
  README.md
  .gitignore
```

## 3) Functional Requirements

* **Input** to `/sql`: `{ question: str, dialect?: "postgres"|"mysql"|"duckdb", execute?: bool, limit?: int, db_id?: str }`
* **Output**:

  ```
  {
    "sql": str,
    "used_context": [<rendered_cards>],
    "confidence": float,  // 0..1
    "explanation": str,   // how/why
    "result": { "ok": bool, "rows"?: [[...]], "error"?: str }
  }
  ```
* **Read-only only**: block DDL/DML (`INSERT|UPDATE|DELETE|DROP|ALTER|TRUNCATE|CREATE`).
* **Auto LIMIT** if no aggregation.
* **Allowlist**: final SQL must reference only tables/columns present in retrieved cards.
* **Hybrid retrieval**: BM25 + FAISS dense with **reciprocal rank fusion** (RRF).
* **Schema inputs**: DDL (SQL CREATE TABLE …) or JSON.
* **Index build**: `python scripts/build_index.py --in data/schema_docs.jsonl`.

## 4) Non-Functional Requirements

* P95 latency target ≤ 3.0s (CPU acceptable).
* Clear logs: retrieval hits, chosen tables/columns, blocked tokens if any.
* Config via `configs/config.example.yaml` + `.env`.
* 90%+ unit test coverage on guardrails and retrieval logic (small scope ok).
* README with quickstart + API examples.

## 5) Implementation Details

### 5.1 Schema Parsing (`rag/schema_parser.py`)

Implement:

* `parse_ddl(ddl_str: str, dialect: str="ansi") -> dict`

  * Use `sqlglot` to parse `CREATE TABLE` statements → extract:

    * tables: list of { name, columns: [{name, type, is_pk, is_fk, ref?}], constraints }
* `parse_json(obj: dict) -> dict`

  * Accepts `{"tables":[{"name":"t","columns":[...]}]}`; include optional `relations`.
* `to_canonical(schema_dict) -> dict`

  * Canonical shape:

    ```
    { "db": "default",
      "tables": [
        { "name": "orders",
          "columns": [{"name":"order_id","type":"int","pk":true,"fk":null}, ...],
          "aliases": [],
          "notes": "short human description (optional)"
        }, ...
      ],
      "relations": [
        {"left":"orders.customer_id", "right":"customers.customer_id", "type":"many_to_one"}
      ]
    }
    ```

### 5.2 Cards (`rag/cards.py`)

* Build compact **schema cards** (300–800 chars each) to index:

  * 1 table-card per table (include PKs, FKs, common group-bys, synonyms/aliases).
  * Optional column-cards for very large schemas.
  * 1 relation-card per FK.
* `render_card(card_dict) -> str` (plain text bullets for prompts).
* Save to `data/schema_docs.jsonl` (one JSON object per line with `{text, meta}`).

### 5.3 Indexing (`rag/index.py`)

* Dense:

  * `bge-small-en-v1.5` embeddings (normalize).
  * `faiss.IndexFlatIP` (CPU). Save as `data/faiss.index`.
* BM25:

  * Use `rank_bm25` over `text` fields; pickle to `data/bm25.pkl`.
* Maintain `data/meta.json` aligned with card order.

### 5.4 Retrieval (`rag/retriever.py`)

* `retrieve(question:str, k_dense:int=12, k_bm25:int=12, top_r:int=8) -> list[dict]`

  * Get top lists from FAISS and BM25, fuse with **RRF**:

    * `score = 1/(k + rank)` with `k=60` default.
  * Return top_r merged unique items keeping highest fused score.
* Extract **allowlists**: `allowed_tables`, `allowed_columns` from returned metas.

### 5.5 Prompting (`rag/prompts.py`)

Provide two prompt templates:

**SYSTEM (do not change)**

```
You translate questions into SQL for the {DIALECT} database.
Use ONLY the tables/columns shown in SCHEMA CONTEXT.
Never invent identifiers. Prefer explicit JOINs and table aliases.
Return ONLY SQL. If aggregation, do not add LIMIT. Otherwise add LIMIT {LIMIT}.
```

**USER**

```
SCHEMA CONTEXT:
{RENDERED_CARDS}

QUESTION:
{QUESTION}

CONSTRAINTS:
- Only SELECT/WITH/EXPLAIN are allowed.
- Use only identifiers present in SCHEMA CONTEXT.
- Dialect: {DIALECT}
```

Also include a **self-repair template** (used once if execution errors):

```
The following SQL caused an error:
{SQL}
Error:
{ERROR}

Revise the SQL strictly using the same SCHEMA CONTEXT and constraints.
Return ONLY corrected SQL.
```

### 5.6 Generator (`rag/generator.py`)

* Implement class supporting **Seq2Seq** (CodeT5p) and **Causal** (SQLCoder) with a uniform `.generate(prompt:str) -> str`.
* Keep max_new_tokens=256; temperature low (0.1–0.2).

### 5.7 Guardrails (`rag/guardrails.py`)

Implement:

* `sanitize(sql:str, dialect:str, preview_limit:int, allowed_tables:set[str], allowed_columns:set[str]) -> str`

  1. Parse with `sqlglot.parse_one`; raise on parse error.
  2. **Reject** if any token in `{INSERT, UPDATE, DELETE, DROP, ALTER, TRUNCATE, CREATE}`.
  3. Ensure top-level statement is SELECT/WITH/EXPLAIN only.
  4. If not aggregate and no LIMIT → add `LIMIT preview_limit`.
  5. Collect referenced tables/columns from AST; ensure ⊆ allowlists.
  6. Return normalized SQL for target dialect via `sqlglot`.

### 5.8 Executor (`rag/executor.py`)

* Dev-only: DuckDB execution with `fetchmany(25)`; return rows or error string.
* Disable by default in prod via config.

### 5.9 Confidence (`rag/confidence.py`)

* Heuristic: Jaccard overlap of (tables/cols in SQL) vs (allowed sets) + max fused retrieval score; output 0..1.

## 6) API Layer (FastAPI)

`app/api_models.py`:

```python
from pydantic import BaseModel
from typing import Optional

class SQLRequest(BaseModel):
    question: str
    dialect: str = "duckdb"
    execute: bool = False
    limit: int = 200
    db_id: Optional[str] = "default"

class SQLResponse(BaseModel):
    sql: str
    used_context: list[str]
    confidence: float
    explanation: str
    result: dict | None
```

`app/main.py`:

* Load config & models on startup.
* `/healthz` returns ok.
* `/sql`:

  1. Retrieve → render cards
  2. Build prompt → generate SQL
  3. Guardrails sanitize (SELECT-only, LIMIT, allowlist)
  4. If `execute=True`: try execute; on error, one **self-repair** attempt using repair prompt; guard again; execute again.
  5. Return `SQLResponse`.

## 7) Scripts

* `scripts/build_index.py`

  * Args: `--ddl`, `--json`, `--out data/`
  * If DDL provided: parse with `schema_parser.parse_ddl`; else `parse_json`.
  * Build cards → save `schema_docs.jsonl` → build FAISS & BM25 → write `meta.json`.
* `scripts/export_schema.py` (optional stub): show how you’d dump live DB DDL.

## 8) Config (`configs/config.example.yaml`)

```yaml
models:
  embed: sentence-transformers/bge-small-en-v1.5
  generator: Salesforce/codet5p-770m-sql
retrieval:
  k_dense: 12
  k_bm25: 12
  top_r: 8
  rrf_k: 60
guardrails:
  preview_limit: 200
  blocked: [INSERT, UPDATE, DELETE, DROP, ALTER, TRUNCATE, CREATE]
server:
  host: 0.0.0.0
  port: 8080
```

`.env.example`:

```
HF_HOME=.cache/hf
```

## 9) Tests

* `tests/test_guardrails.py`

  * Blocks DML/DDL
  * Adds LIMIT when needed
  * Enforces allowlists
* `tests/test_retrieval.py`

  * Given tiny schema & question, top_r includes expected tables/columns
* `tests/test_api.py`

  * Spin up test client, post a query, assert fields present

`tests/fixtures/tiny_schema.sql`:

```sql
CREATE TABLE customers(
  customer_id INT PRIMARY KEY,
  name TEXT, city TEXT, segment TEXT
);
CREATE TABLE orders(
  order_id INT PRIMARY KEY,
  customer_id INT,
  order_date DATE,
  amount DECIMAL(12,2),
  FOREIGN KEY(customer_id) REFERENCES customers(customer_id)
);
```

`tests/fixtures/eval_qas.jsonl`: 10–20 Q→SQL gold pairs.

## 10) Prompt Templates (inline constants in `rag/prompts.py`)

Provide **exact strings** as in §5.5.

## 11) Requirements (`requirements.txt`)

```
fastapi
uvicorn[standard]
pydantic
python-dotenv
pyyaml
faiss-cpu
rank-bm25
sentence-transformers
transformers
sqlglot
sqlparse
duckdb
tqdm
pytest
httpx
ruff
black
```

## 12) Docker & Make

**Dockerfile**

```dockerfile
FROM python:3.11-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY . .
ENV HF_HOME=/app/.cache/hf
EXPOSE 8080
CMD ["uvicorn","app.main:app","--host","0.0.0.0","--port","8080"]
```

**Makefile**

```
.PHONY: setup run test format lint build docker

setup:
\tpython -m venv .venv && . .venv/bin/activate && pip install -r requirements.txt

run:
\tuvicorn app.main:app --host 0.0.0.0 --port 8080 --reload

index:
\tpython scripts/build_index.py --json tests/fixtures/tiny_schema.json --out data/

test:
\tpytest -q

format:
\tblack .
\truff check --fix .

docker:
\tdocker build -t text2sql-rag:latest .
\tdocker run -p 8080:8080 text2sql-rag:latest
```

## 13) README (key content)

* Quickstart:

  1. `make setup`
  2. Convert your schema (DDL/JSON) → `data/schema_docs.jsonl`
  3. `make index`
  4. `make run`
  5. `curl -X POST localhost:8080/sql -H "content-type: application/json" -d '{"question":"total revenue by month in 2024","execute":true}'`
* How to swap generator model
* How hybrid retrieval works (BM25 + FAISS + RRF)
* Safety & guardrails
* Eval harness basics

## 14) Acceptance Criteria

* `/healthz` returns 200.
* `/sql` returns valid JSON with `sql`, `used_context`, `confidence`, and either `result.rows` or `result.error`.
* Guardrails demonstrably block DML/DDL and inject LIMIT when needed.
* Retrieval explains which cards were used; generated SQL references only allowed identifiers.
* Tests pass locally (`pytest -q`).
* Docker image runs and serves the API.

## 15) Nice-to-Have (leave TODOs)

* Cross-encoder reranker (`bge-reranker-base`)
* Grammar-constrained decoding (e.g., `outlines` or `lark`)
* Per-role scopes (mask columns by role)
* Caching (question+schema hash → SQL)

**End of prompt. Build everything exactly as specified.**

---

## How to use this

1. Copy the **MASTER BUILD PROMPT** into your code agent.
2. Drop your schema (DDL or JSON) into `tests/fixtures/`, then run `make index`.
3. Start the API with `make run` and hit `/sql`.

If you want, I can also supply ready-made code stubs for a few key files (e.g., `guardrails.py`, `retriever.py`) to speed you up.

