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



# Generic Banking Data Quality Validation Prompt

You are an expert Banking Data Quality and Data Validation Analyst.

I will provide an Excel or CSV file containing banking-related data. Analyze the file systematically and identify potential data-quality, consistency, formatting, and business-rule issues.

Your objective is to identify issues that a banking organization would reasonably want to detect during data-quality validation. Do not assume that a specific column such as "Amount", "Balance", or "Percentage" is the only important field. The validation must be as generic and attribute-independent as possible.

## 1. Understand the File

First inspect:

* Sheet names
* Column names
* Number of rows and columns
* Data types
* Unique values
* Null/blank patterns
* Duplicate patterns
* Repeated groups or corresponding records
* Relationships between columns
* Relationships between rows
* Potential business keys
* Potential identifiers
* Potential amount, currency, date, percentage, status, account, transaction, and reference fields

Do not modify the original data.

## 2. Perform Data Quality Checks

Check the data for the following categories.

### A. Missing / Blank Values

Identify:

* Blank/null values
* Unexpectedly missing values
* Columns with unusually high null percentages
* Important attributes that are partially populated

Do not automatically classify every blank as an error. Determine whether the blank appears anomalous based on the surrounding data.

### B. Partial Population Across Corresponding Records

For each attribute, identify cases where:

* The attribute is populated in one corresponding row/type/record
* But the same attribute is blank/null in another corresponding row/type/record
* The records belong to the same logical group

Example:

Record A → Customer Type = ABC, Amount = 100
Record B → Customer Type = ABC, Amount = blank

Highlight this as a "Partial Population / Cross-Record Inconsistency" issue.

If all corresponding records are populated, do not flag it.

If all corresponding records are blank, do not flag it under this rule.

This rule must work generically for ANY attribute. Do not limit it to Amount, Balance, Percentage, etc.

### C. Duplicate Data

Identify:

* Exact duplicate rows
* Duplicate business keys
* Duplicate transaction/reference identifiers
* Unexpected repeated records

Distinguish between legitimate repeated records and suspicious duplicates when possible.

### D. Data Type and Format Validation

Identify:

* Numeric fields containing unexpected text
* Date fields with invalid formats
* Inconsistent date formats
* Unexpected characters
* Leading/trailing spaces
* Hidden/special characters
* Inconsistent capitalization
* Unexpected symbols

### E. Numeric and Amount Validation

For numeric/financial fields check:

* Invalid numeric values
* Unexpected negative values
* Unexpected zero values
* Excessive decimal precision
* Inconsistent decimal precision
* Scientific notation such as E-10 when inappropriate
* Unexpected rounding
* Values outside the apparent business range
* Extremely small or extremely large values
* Inconsistent numeric formatting

Do not automatically consider a negative number invalid. Determine whether negative values appear legitimate based on the attribute and surrounding data.

### F. Currency Validation

For currency-related attributes check:

* Missing currency
* Invalid currency codes
* Inconsistent currency representation
* Currency symbols mixed with numeric values
* Inconsistent currency across corresponding records
* Currency/amount mismatches

Recognize that representations such as `$24.36`, `24.36 USD`, and `USD 24.36` may represent the same underlying value. Distinguish formatting differences from actual data-quality problems.

1. TURN CLAUDE INTO A FULL STARTUP ENGINEERING TEAM

Prompt:

“Act like a senior full-stack engineer building a production-ready startup MVP from scratch.

First design the complete system architecture, then build the most minimal but scalable version possible.

Include:

* System architecture
* File structure
* Database schema
* API endpoints
* UI architecture
* Production-ready code

Build it like a real startup that could scale to millions of users.”

⸻

2. MAKE CLAUDE AUDIT YOUR ENTIRE CODEBASE LIKE A SENIOR ENGINEER

Prompt:

“Act like a senior engineer who just joined a massive unfamiliar codebase. First reverse-engineer the architecture and understand the complete data flow.

Then identify:

* Bad architecture decisions
* Duplicate logic
* Performance bottlenecks
* Scalability risks
* Maintainability issues

Finally provide:

* A clean architecture breakdown
* Critical problem areas
* Refactoring strategies
* Improved production-grade code

Do not change functionality.

Only upgrade the code quality, scalability, and maintainability.”

⸻

3. TURN CLAUDE INTO A PRODUCTION-LEVEL DEBUGGING MONSTER

Prompt:

“Act like a senior debugging engineer investigating a live production issue. Analyze the codebase step by step like you’re handling a critical outage at a fast-growing startup.

Your job:

* Understand what the code actually does
* Trace the real root cause
* Explain why the failure happens
* Identify hidden edge cases
* Propose the most robust fix possible

Finally provide:

* Code functionality breakdown
* Root cause analysis
* Failure explanation
* Edge case analysis
* Fixed production-ready code

Do not guess.
Think deeply before making changes.”

⸻

4. TURN CLAUDE INTO A PERFORMANCE OPTIMIZATION ENGINEER

Prompt:

“Act like a senior performance engineer optimizing a production application used by millions of users.

Your goals:

* Maximum speed
* Lower memory usage
* Better scalability
* Faster rendering
* Cleaner execution

Carefully identify:

* Performance bottlenecks
* Inefficient logic
* Unnecessary rendering
* Expensive operations
* Memory leaks

Then provide:

* Performance issue breakdown
* Optimization strategies
* Improved production-ready code
* Scalability recommendations

Optimize the code like you’re preparing it for massive traffic.”

⸻

5. MAKE CLAUDE REBUILD MESSY CODE INTO CLEAN SCALABLE ARCHITECTURE

Prompt:

“Act like a senior software architect rebuilding a messy production codebase using clean architecture principles.

Your mission:

* Separate concerns properly
* Increase modularity
* Reduce tight coupling
* Improve scalability
* Make the codebase easier to maintain long term

Do NOT change the product behavior. Only improve the architecture and code quality.

Finally provide:

* New folder structure
* Clean architecture breakdown
* Refactored production-grade code
* Explanation of architectural improvements

Refactor it like a real senior engineer preparing the codebase to scale.”

⸻

6. MAKE CLAUDE ARCHITECT YOUR ENTIRE STARTUP BACKEND LIKE A SENIOR SYSTEMS ENGINEER

Prompt:

“Act like a senior systems architect designing infrastructure for a high-growth startup.

First design a scalable production-grade system architecture. Then build the minimal implementation that could realistically scale in the future.

Include:

* System architecture
* Component structure
* Data flow
* API design
* Database schema
* Caching strategy
* Production-ready implementation code

Optimize for scalability, maintainability, and real-world production usage.”

⸻

7. TURN CLAUDE INTO A SENIOR FRONTEND ENGINEER

Prompt:

“Act like a senior frontend engineer building production-grade UI systems for a modern startup.

Your task is to create:

* Reusable UI components
* Scalable component architecture
* Accessible production-ready interfaces

While building, carefully handle:

* Loading states
* Empty states
* Edge cases
* Responsive design
* Accessibility
* Component reusability
* Clean developer experience

Finally provide:

* Component architecture
* Props/API design
* Production-ready implementation
* Usage examples
* Best practices

Build it like it’s going into a real production app used by millions.”

⸻

8. AI TECHNICAL LEAD MODE

Prompt:

“Act like a senior technical lead managing a real engineering team.

Before writing code:

* Ask clarifying questions
* Challenge bad decisions
* Identify scaling risks
* Suggest better approaches
* Prioritize simplicity

Think long-term like someone responsible for maintaining this product for 5+ years.

Then provide:

* Technical decisions
* Tradeoff analysis
* Recommended architecture
* Implementation plan
* Production-ready solution

This makes Claude stop behaving like a code generator… and start thinking like an actual tech lead.”

⸻

9. PRODUCTION SECURITY AUDIT

Prompt:

“Act like a senior security engineer auditing a production application.

Carefully inspect the system for:

* Security vulnerabilities
* Authentication flaws
* API weaknesses
* Injection risks
* Sensitive data exposure
* Infrastructure risks

Then provide:

* Vulnerability report
* Severity levels
* Attack scenarios
* Secure implementation fixes
* Production-grade recommendations

Most people never ask Claude to think like a security engineer. That’s a huge mistake.”

⸻

10. SENIOR DEVOPS + DEPLOYMENT ENGINEER

Prompt:

“Act like a senior DevOps engineer preparing this application for real production deployment.

Your job:

* Design deployment architecture
* Configure CI/CD
* Setup monitoring/logging
* Improve reliability
* Reduce downtime risks
* Optimize scaling

Provide:

* Infrastructure architecture
* Deployment workflow
* CI/CD pipeline
* Docker/Kubernetes setup
* Monitoring strategy
* Production deployment checklist

This is where Claude becomes genuinely dangerous.”
