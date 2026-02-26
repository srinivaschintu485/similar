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



Manual navigation through multiple Jira screens: Users have to click through several different Jira tabs or screens to find all the information they need, which is tedious.
	2.	Field-by-field manual verification for each feed: Every individual field has to be checked one by one manually, which takes a lot of time.
	3.	Time-consuming validation of certification statuses: Users need to manually confirm whether each field or feed is certified, which is a repetitive task.
	4.	Checking multiple tables manually for each Jira item: They have to look into different tables or data sources to verify that everything matches up, which adds extra steps.
	5.	Cross-referencing data from different screens to confirm accuracy: They need to compare information from various screens to make sure it all lines up, which can be a hassle.
	6.	Manually identifying and interpreting errors or exceptions: If there’s an error or an exception, users have to figure out what it means on their own, which can be confusing.
	7.	Repeating the process for multiple feeds or projects: They have to do all of this over and over again for each project or feed, which adds up.
	8.	Limited ability to quickly answer questions without digging through documentation: If they have a question, they have to go look through documents or multiple screens instead of just getting a quick answer.
	9.	Difficulty in tracking changes over time across different Jira items: It’s hard to see how things have changed over time because they have to piece it together manually.
	10.	Lack of a centralized or quick way to get answers: There’s no single place to quickly get the info they need, so it takes longer to find answers.

	Hi Rohit,

Earlier, I was testing and training the models on the server, but that setup is no longer available. To continue the work, I started using containers to build the logic and convert it into Spark-based implementations for testing. However, this approach was taking a considerable amount of time for making changes and validating them.

I then attempted to set up the environment locally, but encountered multiple issues with Hadoop, mainly related to version compatibility. Even after several attempts, it remained difficult to properly load and test the models in the local setup.

At that point, I realized that my immediate goal was to validate the behavior of the feature functions rather than testing the full models. So, I shifted my focus and set up a simplified environment specifically to test the feature function behavior.

Currently, I have completed the setup required to validate the base feature function behavior. The next step is to convert each function into a Spark-based implementation and compare the outputs against the base feature functions to ensure consistency.
