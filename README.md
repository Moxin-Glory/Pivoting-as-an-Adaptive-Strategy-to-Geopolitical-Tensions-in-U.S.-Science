
# Data and Code for "Pivoting as an Adaptive Strategy to Geopolitical Tensions in U.S. Science"
## Overview

This repository provides the code and  metadata necessary to replicate  analyses reported in the paper:
- “Pivoting as an Adaptive Strategy to Geopolitical Tensions in U.S. Science”
- Moxin Li(XJTU), Yifang Ma(SUSTC), Yang Wang(XJTU) and Dashun Wang(NU)

## Data Availability
Because GitHub imposes file size limits, the datasets are not stored directly in this repository.
You can access the full dataset here: https://doi.org/10.7910/DVN/RVB41B
## Dataset Descriptions:
The following datasets are available for download via the Harvard Dataverse:

### data.csv
- The core dataset used for the main regression analyses and for generating the survival analysis in Figure 2.
- (We sincerely apologize for an error in the calculation of the control variable “number of new U.S. collaborators” in the shared dataset. However, this issue does not affect the overall conclusions of the paper: whether this control variable is included or excluded, the direction and statistical significance of the main results remain unchanged. The paper is still a work in progress, and we will provide a corrected version of the dataset in a future version of the paper, together with a corresponding explanation posted on Harvard Dataverse)

### Fig3_event_study_data.csv
- Dataset used to produce Figure 3, containing the event-study coefficient estimates and their corresponding 95% confidence intervals. The underlying data for this dataset are generated based on the output of the Stata script regression.do.
### Fig4_did_pivot_data.csv
- Dataset used for Figure 4, providing estimates and moderation effects (by field risk, race, and age), along with their confidence intervals. The underlying data for this dataset are generated based on the output of the Stata script regression.do.
## Code Structure
This repository contains Python and Stata scripts organized by analysis module, as follows:

### code.ipynb
- Python notebook used to generate Figure 2 (based on data.csv), Figure 3 (based on Fig3_event_study_data.csv), Figure 4 (based on Fig4_did_pivot_data.csv), and Table 1 (based on data.csv).

### regression.do
- Stata script that performs regression analyses using data.csv. It produces the source data for Table 2, Table 3, Fig3_event_study_data.csv and Fig4_did_pivot_data.csv.

Acknowledgement:
This paper was written using data from the APl for DigitalScience's Dimensions platform, available at https://app.dimensions.ai.
