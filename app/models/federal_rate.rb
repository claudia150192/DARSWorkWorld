class FederalRate < ActiveRecord::Base
  
  # Some explanantions to the acronyms 
  # 
  # FBR (Federal Benefit Rate) : 
  # is the maximum dollar amount that you can receive in Federal Supplemental Security Income (SSI) cash benefits on a monthly basis,
  # http://www.workworld.org/wwwebhelp/basic.htm#workers_compensation_acronyms.htm
  # 
  # 
  # PMV (Presumed Maximum Value) : 
  # If you contribute your share of either the household food or rent expenses, then SSA will use the Presumed Maximum Value (PMV) Rule to determine the In-Kind Support that you are receiving. 
  # http://www.workworld.org/wwwebhelp/basic.htm#workers_compensation_acronyms.htm  
  # 
  # 
  # TWP (Trial Work Period) : 
  # If you receive SSDI (Title II) benefits, you are entitled to a Trial Work Period (TWP) which allows you to test your work skills while continuing to receive your full cash benefit. There is no limit to the amount of money you may earn during the TWP and still get your cash benefit.  
  # http://www.workworld.org/wwwebhelp/basic.htm#twp.htm   
  # 
  # 
  # Services (TWP amount) : 
  # The TWP continues until you accumulate 9 months in which you performed "services" within a rolling 60-consecutive-month period. The Services amount changes every year. 
  # http://www.workworld.org/wwwebhelp/basic.htm#twp.htm
  # 
  # 
  # SGA (Substantial Gainful Activity) : 
  # Generally, if you are employed and have "countable earnings" over $1,000 per month in 2010 (was $980 in 2009), you are considered to be engaging in Substantial Gainful Activity (SGA). If you are blind, the SGA level is $1,640 in 2010 (unchanged from 2009).  The effects of engaging in SGA are very different in the two programs. See SGA - SSI for more information on how SGA affects SSI (Title XVI) recipients; and see SGA - SSDI (Title II) for information on how engaging in SGA affects SSDI (Title II) beneficiaries and their dependents.
  # http://www.workworld.org/wwwebhelp/sga.htm
  # 
  # 
  # SEIE (Student Earned Income Exclusion): 
  # if you are: Under 22 years of age; and  Receiving Supplemental Security Income (SSI); and Regularly attending school; then during calendar year 2010, you can have up to $1,640 per month of earnings (up to $6,600 per year) without having those earnings decrease your SSI cash benefits. These amounts are unchanged from 2009. This exclusion is to encourage you either to work during the summer months or to participate in work programs during the school year.
  # http://www.workworld.org/wwwebhelp/seie.htm
  # 
  # 
  # FPL (Federal Poverty Level) : 
  # The U.S. Department of Health and Human Services (HHS) issues new Federal Poverty Guidelines every year, usually in January or February. These guidelines are commonly (yet ambiguously) referred to as the "Federal Poverty Level" (FPL), and serve as one of the indicators for determining eligibility in a wide variety of Federal and State programs.
  # http://www.workworld.org/wwwebhelp/poverty_guidelines_federal.htm
  # 
  # 
  # Medicare Pat B premium : http://www.workworld.org/wwwebhelp/medicare_coverage.htm#Medicare_Part_B_smi
  # 
  # 
  # Medicaid Thresholds :
  # To be eligible under section 1619(b), you cannot have earnings sufficient to replace SSI cash benefits, Medicaid benefits, and publicly-funded personal or attendant care that would be lost due to earnings. SSA has constructed the "threshold" concept to measure whether you have sufficient earnings to replace these benefits. SSA looks only at income from earnings in making this determination; unearned income is not considered.  
  # http://www.workworld.org/wwwebhelp/state_1619b_thresholds_overview_.htm
  # 
  # 
  # SSI Work Incentive 1619b Continued Medicaid Coverage : 
  # The 1619(b) incentive provides continued Medicaid coverage for SSI recipients when their earnings become too high to allow an SSI cash payment. To qualify for this incentive, a person must: Have been eligible for an SSI cash payment for at least one month; Still meet the disability and non-disability requirements; Need Medicaid in order to work (see Medicaid Need Test, below); and Have gross earned income which is either below a predetermined state threshold level or below an individualized threshold.
  # http://www.workworld.org/wwwebhelp/ssi_work_incentive_1619b.htm
  # 
  
end
