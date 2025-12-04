
# Data and Code for "Pivoting as an Adaptive Strategy to Geopolitical Tensions in U.S. Science
## Overview

This repository provides the code and  metadata necessary to replicate  analyses reported in the paper:
“Pivoting as an Adaptive Strategy to Geopolitical Tensions in U.S. Science”
- Moxin Li(XJTU), Yifang Ma(SUSTC), Yang Wang(XJTU), and Dashun Wang(NU)

## Data Availability
To ensure transparency and reproducibility, all datasets used in this study are archived on the Harvard Dataverse.

Because GitHub imposes file size limits, the datasets are not stored directly in this repository.
You can access the full dataset here: https://doi.org/

## Dataset Descriptions:
The following datasets are available for download via the Harvard Dataverse:

### data.csv
- The core dataset used for the main regression analyses and for generating the survival analysis in Figure 2.

### Fig3_event_study_data.csv
- Dataset used to produce Figure 3, containing the event-study coefficient estimates and their corresponding 95% confidence intervals.

### Fig4_did_pivot_data.csv
- Dataset used for Figure 4, providing difference-in-differences (DID) estimates and moderation effects (by field, race/ethnicity, and age), along with their confidence intervals.

## Code Structure
This repository contains Python and Stata scripts organized by analysis module, as follows:

### code.ipynb
- Python notebook used to generate Figure 2 (based on data.csv), Figure 3 (based on Fig3_event_study_data.csv), Figure 4 (based on Fig4_did_pivot_data.csv), and Table 1 (based on data.csv).

### regression.do
- Stata script that performs regression analyses using data.csv. It produces the source data for Fig3_event_study_data.csv and Fig4_did_pivot_data.csv.

Acknowledgement:
This paper was written using data from the APl for DigitalScience's Dimensions platform, available at https://app.dimensions.ai.
