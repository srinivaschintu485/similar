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


1. Does the object/tool/system use techniques that emulate human intelligence via computer programs to make estimates, predictions, recommendations, or decisions (Static AI, Dynamic AI, Auto AI or Cognitive AI)?

Answer: Yes

Rationale:
The system uses machine learning algorithms implemented through the PySpark ML library to perform classification of data records. From the code, models such as RandomForestClassifier, Logistic Regression, and SVM (LinearSVC with OneVsRest) are used to generate predictions based on engineered features derived from the input data. These algorithms learn patterns from historical data and apply them to new observations to produce predictions such as identifying whether values match or detecting specific types of differences (for example currency differences, scientific notation differences, or separator differences). Since the system uses machine learning models to automatically infer patterns and generate predictions, it falls under Static AI / Machine Learning techniques as defined by the Model Risk Management framework.

2. Does the object/tool/system developer influence selection of inputs (vs prescribed inputs)?

Answer: Yes

Rationale:
The developer determines and engineers the input features used by the models. In the code, several features are generated through custom logic and user-defined functions, such as fuzzy matching scores, n-gram similarity, currency detection, scientific notation checks, thousand separator differences, negative number checks, and string similarity measures. These features are assembled into a feature vector using VectorAssembler before being passed to the machine learning models. Since these input variables are designed and selected by the developer rather than being fixed by a predefined regulatory or mathematical specification, the developer clearly influences the selection and transformation of model inputs.

3. Does the object/tool/system developer influence selection of methodology (vs prescribed specifications)?

Answer: Yes

Rationale:
The methodology used by the system is determined by the developer during the model design process. The code shows that multiple machine learning algorithms are used, including Random Forest, Logistic Regression, and Support Vector Machines, and the predictions are executed sequentially for stability. Additionally, the developer configures the modeling pipeline, performs feature engineering, prepares the dataset, and defines how predictions are mapped into business labels such as “Material change” or “No material change”. These modeling choices, including the selection of algorithms and feature engineering strategy, are not dictated by a prescribed formula but are part of the model development and optimization process. Therefore, the developer influences the model methodology and architecture.

4. Is the output an estimate of something about which there is uncertainty? The ultimate output can be either quantitative or qualitative but is based upon quantitative methods.

Answer: Yes

Rationale:
The system produces predictions based on probabilistic outputs generated by machine learning models. For example, the Random Forest model generates prediction probabilities, and the code processes these probabilities to determine the most likely classification outcome. Since these predictions are derived from statistical learning on historical data, the output inherently contains uncertainty and probabilistic interpretation. The model estimates whether records match or whether differences exist (such as rounding differences, special character differences, or currency differences) based on learned patterns rather than deterministic rules. Therefore, the output represents an estimate derived from quantitative statistical methods, which satisfies the Model Risk Management definition of model output with uncertainty.




