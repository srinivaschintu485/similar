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

**Title:** Implement Parallel LLM Routing Based on Action Complexity

**Type:** Story / Technical Task

**Summary:**
Implement a routing mechanism that dynamically selects between a lightweight LLM and a large LLM based on the complexity of the action being executed by agents. The goal is to optimize performance, cost, and latency by using the lightweight model for simple routing/decision tasks while reserving the larger model for complex reasoning tasks.

**Background / Context:**
The system currently utilizes multiple agents to perform different actions. Some agents perform simple tasks such as deciding which agent to invoke or performing lightweight reasoning, while others require deeper reasoning and complex processing. Running all actions on the larger LLM is inefficient in terms of latency and cost.

To improve efficiency, we need to introduce a parallel LLM routing layer that determines which model should handle a given action.

**Objectives:**

* Route simple decision-making tasks to the lightweight LLM.
* Route complex reasoning or generation tasks to the large LLM.
* Support parallel execution where applicable.
* Maintain a flexible architecture to extend routing rules in the future.

**Scope of Work:**

1. **Action Classification**

   * Define categories for agent actions:

     * Simple routing/decision actions
     * Moderate reasoning tasks
     * Complex reasoning/generation tasks
   * Map these categories to the appropriate LLM.

2. **LLM Router Implementation**

   * Create an LLM routing layer that:

     * Receives agent action requests
     * Determines complexity level
     * Selects the appropriate LLM
   * Implement routing rules or heuristics.

3. **Parallel Routing Support**

   * Allow parallel invocation where multiple agents may require LLM calls simultaneously.
   * Ensure thread-safe or async execution.

4. **Configuration Layer**

   * Add configuration for:

     * Model selection rules
     * Action → model mapping
     * Fallback model configuration.

5. **Fallback Handling**

   * If the lightweight model fails or confidence is low, reroute the request to the larger model.

6. **Logging and Monitoring**

   * Log which model handled each request.
   * Track latency, token usage, and failure cases.

**Acceptance Criteria:**

* System routes simple decision tasks to the lightweight LLM.
* Complex reasoning tasks are executed using the large LLM.
* Routing logic supports parallel execution.
* Fallback to the larger model works correctly.
* Logs clearly indicate which model handled each action.
* No regression in existing agent functionality.

**Technical Notes:**

* Ensure routing logic is modular and extensible.
* Consider async execution for parallel agent calls.
* Maintain backward compatibility with existing agent workflows.

**Priority:** High

**Estimated Effort:** 3–5 days
