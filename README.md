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





Model Testing
The purpose of this section is to evaluate whether the selected models perform as intended by conducting and documenting a variety of quantitative performance tests. Performance evaluation is critical to ensure the model is not only accurate but also reliable, interpretable, and aligned with its intended use.

We evaluated three different classifiers — Random Forest, Support Vector Machine (SVM_OVR), and Logistic Regression — using a confusion matrix-based analysis tailored for reconciliation class predictions. Each model was trained to classify mismatch types such as thousand separator differences, special character issues, extra spacing, case sensitivity, scientific notation differences, rounded number mismatches, and others.

Random Forest Classifier
Accuracy: 1.000

Precision: 1.000

Recall: 1.000

F1 Score: 1.000

The Random Forest model achieved perfect classification across all classes. Each mismatch category was correctly identified with no false positives or negatives. The confusion matrix indicates highly precise class separation, particularly in differentiating between subtle variations like “scientific notation” and “rounded-off numbers.” Given the ensemble nature of this model and its robustness to overfitting, it is a strong candidate for deployment.

SVM_OVR (One-vs-Rest SVM)
Accuracy: 0.983

Precision: 0.984

Recall: 0.983

F1 Score: 0.983

The SVM model shows very high accuracy with minimal misclassifications. A few cases of confusion were observed between closely related classes, such as between “rounded-off numbers” and “scientific notation differences.” Despite this, the model remains interpretable and performs well in distinguishing edge cases. This model may be preferable when explainability is important but some flexibility in performance is acceptable.

Logistic Regression
Accuracy: 1.000

Precision: 1.000

Recall: 1.000

F1 Score: 1.000

Logistic Regression also performed flawlessly in our tests, which is notable given its linear nature. The model's performance suggests that the features provided are highly separable and suitable for simple classifiers. It also offers the advantage of interpretability and low latency during inference, making it ideal for real-time scoring systems or audit-traceable environments.

Key Observations
The Random Forest and Logistic Regression models showed perfect performance on the evaluation dataset, making them ideal candidates for production deployment.

SVM provided excellent results with slight confusion in classes involving numerical formatting. This may be improved with further feature engineering or ensemble stacking.

Confusion matrices were not only used to compute metrics but also provided insights into which types of mismatches tend to be confused, helping improve model interpretability.

All models successfully identified edge cases like scientific notation and leading zero issues, which are often critical in reconciliation systems.



