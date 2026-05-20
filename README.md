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



Jira Story 1: Automate Olympus File Movement from Inbound Path to Olympus Landing Bulk Remote

Story Title:
Automate file movement for Olympus products from inbound path to Olympus landing bulk remote path

Description:
Currently, source teams upload files into the UAT inbound path:

/var/app/inbound/GENEIS/uat2

For BAU processing, an existing CC job automatically moves files into the bulk remote path. However, Olympus-related products do not have similar automation.

Currently for Olympus products:

CAT
LNS
DEP

files are manually identified and copied to:

/var/app/precert/uat/live/olypct/landing/bulk_remote

For SFT and TCS, physical files do not exist and raw source files are expected from Olympus teams.

The process currently requires manual intervention where users identify relevant files and move them to Olympus landing locations. This creates operational overhead and increases the possibility of missed or duplicate files.

Automation should be implemented to identify only Olympus-specific files and move them automatically.

Acceptance Criteria:

AC1:
System monitors:

/var/app/inbound/GENEIS/uat2

for incoming files.

AC2:
Only Olympus product files:

CAT
LNS
DEP

are identified.

AC3:
Identified files are automatically copied into:

/var/app/precert/uat/live/olypct/landing/bulk_remote

AC4:
Existing BAU processing remains unchanged.

AC5:
Logging mechanism captures:

file name
timestamp
movement status
failures

Business Value:

Removes manual activity
Reduces operational risk
Prevents missed files
Improves scalability
Jira Story 2: Automate Attestation Requirement Updates Across Database Tables

Story Title:
Automate attestation metadata updates across dependent database tables

Description:

During feed onboarding, users select:

Attestation Required
Attestation Not Required

Business users may later request changes to attestation requirements for an existing feed/Jira ID.

Currently, changing this status requires manual updates across multiple database tables:

Tables impacted:

dsval_release_config
dsval_dataset_def
dsdiff_proc_status
genval_proc_status_ai
genval_workflow_details
genval_workflow_status

Manual updates create inconsistencies and can cause UI and workflow failures.

Automation should identify changes and update all impacted tables consistently.

Acceptance Criteria:

AC1:
System identifies Jira IDs impacted by attestation label changes.

AC2:
Related records are identified automatically.

AC3:
Updates are applied to all dependent tables.

AC4:
Both scenarios are supported:

Not Required → Required
Required → Not Required

AC5:
UI reflects correct state:

Example:

GO

changes correctly to:

Initiate Attestation

AC6:
Audit logs capture:

Jira ID
old value
new value
timestamp

Business Value:

Eliminates manual DB updates
Reduces production issues
Maintains UI consistency
Reduces operational effort
Jira Story 3: Automate SGL Certified Feed Movement to S3

Story Title:
Automate movement of SGL-certified feeds into S3

Description:

Currently SGL-certified feeds require manual movement into S3 before downstream processing can continue.

Manual handling causes:

delays
dependency on operations teams
risk of missing uploads

Automation should move certified feeds to S3 upon generation.

Acceptance Criteria:

AC1:
System identifies completed SGL-certified feeds.

AC2:
Files are automatically transferred to S3.

AC3:
Transfer failures are logged.

AC4:
Retry mechanism exists for failures.

AC5:
Processing continues after successful upload.

Business Value:

Removes repetitive manual work
Reduces delays
Improves reliability
Jira Story 4: Enhance Cleanup Scripts for Ab Initio Space Management

Story Title:
Enhance cleanup scripts to remove obsolete files and prevent storage issues

Description:

Existing cleanup scripts:

Serial Cleanup:

/abinitio/home/mp64514/serial_cleanup

MFS Cleanup:

/abinitio/home/mp64514/mfs_cleanup

Current scripts are executing but not removing all required files, causing space issues in:

/abinitio/data

Cleanup logic requires enhancement to ensure obsolete files are removed appropriately.

Acceptance Criteria:

AC1:
Cleanup scripts identify obsolete files correctly.

AC2:
Unnecessary files are removed automatically.

AC3:
Required active files remain untouched.

AC4:
Cleanup logs are generated:

files deleted
execution time
failures

AC5:
Storage utilization remains within acceptable limits.

Business Value:

Prevents storage exhaustion
Reduces manual cleanup
Improves job stability
Improves system performance

These are ready to directly create Jira stories in your backlog.
