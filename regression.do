
import delimited "/your path/data.csv"
*======================================================
* Set panel structure for author-year data
xtset author_id year

*======================================================
* （1） Fig 3 Event study Data
*======================================================

* Create a policy-time variable relative to policy year (2018)
gen policy = year - 2018

* Tabulate to check distribution
tab policy

* Cap policy variable to -4 to 5 for visualization purposes
replace policy = -4 if policy < -4
replace policy = 5 if policy > 5

* Generate interaction dummies for event study

* Pre-policy periods for treated group (-4 to -1)
forvalues i = 4(-1)1 {
    gen pre_`i' = (policy == -`i' & treat == 1)
}

* Policy year for treated group (0)
gen current = (policy == 0 & treat == 1)

* Post-policy periods for treated group (1 to 5)
forvalues j = 1(1)5 {
    gen post_`j' = (policy == `j' & treat == 1)
}

* Drop pre_1 as the baseline/reference group
drop pre_1

* Regression 1: log of federal funding amount
reghdfe log_federal_funding_amount pre_* current post_* ///
        career_age log_paper_count log_cf log_new_us_collaborators_count i.year, ///
        absorb(author_id) cluster(author_id)
est store reg1

* Regression 2: log of U.S. funding amount
reghdfe log_us_funding_amount pre_* current post_* ///
        career_age log_paper_count log_cf log_new_us_collaborators_count i.year, ///
        absorb(author_id) cluster(author_id)
est store reg2

* Regression 3: log of total funding amount
reghdfe log_total_funding_amount pre_* current post_* ///
        career_age log_paper_count log_cf log_new_us_collaborators_count i.year, ///
        absorb(author_id) cluster(author_id)
est store reg3

* Regression 4: pivot size
reghdfe pivot_size pre_* current post_* ///
        career_age log_paper_count log_cf log_new_us_collaborators_count i.year, ///
        absorb(author_id) cluster(author_id)
est store reg4

* Export event-study coefficients (pre_*, current, post_*)
esttab reg1 reg2 reg3 reg4 using ///
    "/your path/Fig3_event_study_data.csv", ///
    keep(pre_* current post_*) ///
    cells("b ci_l ci_u") ///  * coefficient, lower CI, upper CI *
    ci ///                    * request 95% confidence interval *
    stats(N, fmt(%9.0g)) ///   * number of observations *
    nogaps label replace
	
*======================================================
* （2） Table 2 Baseline regression Results
*======================================================

* Model 1: Federal funding, DID only with year and ind FE
reghdfe log_federal_funding_amount did i.year, absorb(author_id) cluster(author_id) 
est sto m1

* Model 2: Federal funding with controls
reghdfe log_federal_funding_amount did career_age log_paper_count log_cf log_new_us_collaborators_count i.year, ///
    absorb(author_id) cluster(author_id) 
est sto m2

* Model 3: U.S. funding with controls
reghdfe log_us_funding_amount did career_age log_paper_count log_cf log_new_us_collaborators_count i.year, ///
    absorb(author_id) cluster(author_id) 
est sto m3

* Model 4: Total funding with controls
reghdfe log_total_funding_amount did career_age log_paper_count log_cf log_new_us_collaborators_count i.year, ///
    absorb(author_id) cluster(author_id) 
est sto m4

* Model 5: Pivot size, DID only with year and ind FE
reghdfe pivot_size did i.year, absorb(author_id) cluster(author_id) 
est sto m5

* Model 6: Pivot size with controls
reghdfe pivot_size did career_age log_paper_count log_cf log_new_us_collaborators_count i.year, ///
    absorb(author_id) cluster(author_id) 
est sto m6

* Model 7: # of Federal grants with controls
reghdfe log_federal_grant_count did career_age log_paper_count log_cf log_new_us_collaborators_count i.year, ///
    absorb(author_id) cluster(author_id) 
est sto m7

* Model 8: # of U.S. grants with controls
reghdfe log_us_grant_count did career_age log_paper_count log_cf log_new_us_collaborators_count i.year, ///
    absorb(author_id) cluster(author_id) 
est sto m8

* Model 9: # of Total grants with controls
reghdfe log_total_grant_count did career_age log_paper_count log_cf log_new_us_collaborators_count i.year, ///
    absorb(author_id) cluster(author_id) 
est sto m9

* Model 10: Reference overlap with controls
reghdfe reference_overlap did career_age log_paper_count log_cf log_new_us_collaborators_count i.year, ///
    absorb(author_id) cluster(author_id) 
est sto m10

* Export to HTML
esttab m1 m2 m3 m4 m5 m6 m7 m8 m9 m10 using "/your path/table 2.html", ///
    replace b(%9.3f) se(%7.3f) scalars(N r2_a) star(* 0.1 ** 0.05 *** 0.001) ///
    title("Table 2") keep(did career_age log_paper_count log_cf log_new_us_collaborators_count _cons) ///
    html
	
*======================================================
* （3） Table 3 Moderating Effects
*======================================================

gen did_pivot=did*pivot_size

reghdfe  log_federal_funding_amount did_pivot did  pivot_size   career_age   log_paper_count   log_cf  log_new_us_collaborators_count  i.year      , absorb(author_id) cluster(author_id )    
est sto m1

reghdfe  log_us_funding_amount did_pivot did  pivot_size   career_age   log_paper_count   log_cf  log_new_us_collaborators_count  i.year      , absorb(author_id) cluster(author_id )    
est sto m2

reghdfe  log_total_funding_amount did_pivot did  pivot_size   career_age   log_paper_count   log_cf  log_new_us_collaborators_count  i.year      , absorb(author_id) cluster(author_id )    
est sto m3

reghdfe  log_federal_grant_count did_pivot did  pivot_size   career_age   log_paper_count   log_cf  log_new_us_collaborators_count  i.year      , absorb(author_id) cluster(author_id )    
est sto m4

reghdfe  log_us_grant_count did_pivot did  pivot_size   career_age   log_paper_count   log_cf  log_new_us_collaborators_count  i.year      , absorb(author_id) cluster(author_id )    
est sto m5

reghdfe  log_total_grant_count did_pivot did  pivot_size   career_age   log_paper_count   log_cf  log_new_us_collaborators_count  i.year      , absorb(author_id) cluster(author_id )    
est sto m6

esttab m1 m2 m3 m4 m5 m6 using "/your path/table 4.html", ///
    replace b(%9.3f) se(%7.3f) scalars(N r2_a) star(* 0.1 ** 0.05 *** 0.001) ///
    title("Table 3") keep(did_pivot did  pivot_size career_age log_paper_count log_cf log_new_us_collaborators_count _cons) ///
	html

	
	
*======================================================
* （4） Fig 4  data
*====================================================== 
reghdfe log_federal_funding_amount did_pivot did  pivot_size career_age log_paper_count log_cf log_new_us_collaborators_count i.year if high_risk_field_l1 ==1, ///
    absorb(author_id) cluster(author_id) 
est sto m1

reghdfe log_federal_funding_amount did_pivot did  pivot_size career_age log_paper_count log_cf log_new_us_collaborators_count i.year if high_risk_field_l1 !=1, ///
    absorb(author_id) cluster(author_id) 
est sto m2


reghdfe log_federal_funding_amount did_pivot did  pivot_size career_age log_paper_count log_cf log_new_us_collaborators_count i.year if  race=="asian", ///
    absorb(author_id) cluster(author_id) 
est sto m3

reghdfe log_federal_funding_amount did_pivot did  pivot_size career_age log_paper_count log_cf log_new_us_collaborators_count i.year if  race !="asian", ///
    absorb(author_id) cluster(author_id) 
est sto m4

reghdfe log_federal_funding_amount did_pivot did  pivot_size career_age log_paper_count log_cf log_new_us_collaborators_count i.year if  junior ==1, ///
    absorb(author_id) cluster(author_id) 
est sto m5
reghdfe log_federal_funding_amount did_pivot did  pivot_size career_age log_paper_count log_cf log_new_us_collaborators_count i.year if  junior !=1, ///
    absorb(author_id) cluster(author_id) 
est sto m6

reghdfe log_us_funding_amount did_pivot did  pivot_size career_age log_paper_count log_cf log_new_us_collaborators_count i.year if high_risk_field_l1 ==1, ///
    absorb(author_id) cluster(author_id) 
est sto m7

reghdfe log_us_funding_amount did_pivot did  pivot_size career_age log_paper_count log_cf log_new_us_collaborators_count i.year if high_risk_field_l1 !=1, ///
    absorb(author_id) cluster(author_id) 
est sto m8

reghdfe log_us_funding_amount did_pivot did  pivot_size career_age log_paper_count log_cf log_new_us_collaborators_count i.year if  race=="asian", ///
    absorb(author_id) cluster(author_id) 
est sto m9

reghdfe log_us_funding_amount did_pivot did  pivot_size career_age log_paper_count log_cf log_new_us_collaborators_count i.year if  race !="asian", ///
    absorb(author_id) cluster(author_id) 
est sto m10

reghdfe log_us_funding_amount did_pivot did  pivot_size career_age log_paper_count log_cf log_new_us_collaborators_count i.year if  junior ==1, ///
    absorb(author_id) cluster(author_id) 
est sto m11

reghdfe log_us_funding_amount did_pivot did  pivot_size career_age log_paper_count log_cf log_new_us_collaborators_count i.year if  junior !=1, ///
    absorb(author_id) cluster(author_id) 
est sto m12

* Export only did_pivot coefficient with b, se, p, CI
esttab m1 m2 m3 m4 m5 m6 m7 m8 m9 m10 m11 m12 using "/your path/Fig4_did_pivot_data.csv", ///
    replace ///
    keep(did_pivot) ///
    cells("b(fmt(3))  p(fmt(3))  ci_l ci_u") ///
    compress ///
    nonumber ///
    csv
