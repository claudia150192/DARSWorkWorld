require 'wwweb_session_manager'
#Version 4:  This file is based on workbook 29 and some of 30.  There are many changes yet to be made.  Many items hardwired so progress in other areas could be made.

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

#Issues still needing attention, not in priority order.
#1) How do i access/modify a WebNumericalResult's display rule? '   Earned Income Received (Spouse)'.name does not seem to work
#2) Numeric results:  We want to display the same text in different places within numeric results so we need a name that does not conflict but has the same text [a quick fix was to add a blank space to the end, not sure if this is what we want']
#   See workbook WebNumR sheet #330 & #370
#3) Numeric outputs need formating help
# => line items need to be indented
# => totals need to be bold
# => currency values need to be in currency format, right justfied, 2 decimals and a $ for at least the top number in a group
#4) Many question answers are currency and these values are used over and over.  Can we create a currency input type?  if not what is the best way to refer to these values without continually testing for nil values
#5) How do we reference calculations in other calculations, display rules for questions and display rules for numeric results  See State question display rule   #answer = 20 # WebCalc.find_by_name('RAge')
#6) Need to get correct rate record based on sit date, not always the first record.  I'm guessing this is an aditional calc and not the current "RateSgaDisabledAmt = FederalRate.first.sga_disabled_amount"
#7) if you type goofy for the birthdate year the program blows up, does not show the proper validation message  
#8) Noticed on the deeming page when only the VA_CaidParDeemAmt question showed, tabbing off an illegal entry did not bring up the red rectangle but clicking the accept button did bring up the 
#          "there were errors that kept you from proceeding" did appear.   BOB thinks that validation rules are performed even if question is not displayed and may need to account for this.   Something is off here but i'm not always able to replicate Sometimes text can be entered and accepted  even though the validation rule would eval as false.
#9) Noticed on the PMV page if the "PMV Rule: How much In-Kind Support are you considered by SSA to receive?  (Default is the Presumed Maximum Value or PMV.)" questoin is answered incorrectly and the continue button pressed
#  all the answers on the page are changed unexpectedly
# FEATURE request Would like to be able to imbed answers to question within question text for later questions See Q91 for an example "How much of your $2000 of unearned income is infrequent or irregular?" where $2000 is the answer to the UnEarnAmt question and validation text  
#10) notice when On Unearned income screen when non-float text is entered and tab key pressed on last field on page error occurs (eval):7:in `Float': invalid value for Float(): "ArgumentError in Situations#jwoww 
#11) FEATURE  It would be good if focus could return to the data entry field after the red box illuminates it because of an error
#12)  Need to be able to calculate a default value, for example VA_AuxGrantFacilityRateAmt  


# add an admin user if one doesn't exist
@ychaker = User.find_by_email('ychaker@o19s.com')
@ychaker = User.create!(:login => 'ychaker', :email => "ychaker@o19s.com", :password => "password", :password_confirmation => "password", :admin => true) if @ychaker.blank?

@bobc = User.find_by_email('bobc@xxx.com')
@bobc = User.create!(:login => 'bobc', :email => "bobc@xxx.com", :password => "password", :password_confirmation => "password", :admin => true) if @bobc.blank?

@davetest = User.find_by_email('pdbanks@vcu.edu')
@davetest = User.create!(:login => 'davetest', :email => "pdbanks@vcu.edu", :password => "password", :password_confirmation => "password", :admin => true) if @davetest.blank?

@djradmin = User.find_by_email('djruth@comcast.net')
@djradmin = User.create!(:login => 'djradmin', :email => "djruth@comcast.net", :password => "password", :password_confirmation => "password", :admin => true) if @djradmin.blank?

@jimtroxell = User.find_by_email('xort1111@aol.com')
@jimtroxell = User.create!(:login => 'jimtroxell', :email => "xort1111@aol.com", :password => "password", :password_confirmation => "password", :admin => true) if @jimtroxell.blank?


# Create Rates
FederalRate.delete_all
FederalRate.create!(:start_date => Date.today - 365, 
                    :end_date => Date.today + 365, 
                    :fbr_amount => 674.00, 
                    :fbr_couple_amount => 1011.00, 
                    :pmv_amount => 244.67, 
                    :pmv_couple_amount => 357.00,
                    :two_thirds_fbr_amount => 450.00,
                    :two_thirds_fbr_couple_amount => 674.00,
                    :services_amount => 700.00,
                    :sga_disabled_amount => 1000.00,
                    :sga_blind_amount => 1640.00,
                    :gen_exclude_amount => 20.00,
                    :earned_inc_disregard_amount => 65.00,
                    :seie_max_monthly => 1640.00,
                    :seie_max_year => 6600.00,
                    :care_b_premium => 96.40,
                    :ssi_resource_limit => 2000.00,
                    :ssi_resource_limit_married => 3000.00
)

FederalPovertyLevel.delete_all
FederalPovertyLevel.create!(:start_date => Date.today - 365, 
                    :end_date => Date.today + 365, 
                    :family_size_1 => 10830, 
                    :family_size_2 => 14570, 
                    :family_size_3 => 18310, 
                    :family_size_4 => 22050,
                    :family_size_5 => 25790,
                    :family_size_6 => 29530,
                    :family_size_7 => 33270,
                    :family_size_8 => 37010,
                    :family_size_9 => 40750,
                    :family_size_10 => 44490,
                    :family_size_11 => 48230,
                    :family_size_12 => 51970,
                    :family_size_13 => 55710,
                    :family_size_14 => 59450,
                    :family_size_15 => 63190,
                    :additional => 3740.00
)

VaMaxAuxiliaryGrantFacilityRate.delete_all
VaMaxAuxiliaryGrantFacilityRate.create!(:start_date => Date.today - 365, 
                    :end_date => Date.today + 365, 
                    :pd_8_amount => 605, 
                    :elsewhere_amount => 438, 
                    :couple_pd_8_amount => 1279, 
                    :couple_elsewhere_amount => 22050)

MedicaidAnnualBlindThreshold.delete_all
MedicaidAnnualBlindThreshold.create!(:start_date => Date.today - 365, 
                    :end_date => Date.today + 365,
                    :alabama => 23981.00,
                    :alaska => 50054.00,
                    :arizona	=> 26638.00,
                    :arkansas	=> 28221.00,
                    :california	=> 37252.00,
                    :colorado	=> 31212.00,
                    :connecticut => 54815.00,
                    :delaware	=> 37538.00,
                    :district_of_columbia	=> 42071.00,
                    :florida	=> 28427.00,
                    :georgia	=>27295.00,
                    :hawaii	=> 34056.00,
                    :idaho	=> 38097.00,
                    :illinois	=> 26298.00,
                    :indiana	=> 32930.00,
                    :iowa	=> 31005.00,
                    :kansas	=>	33540.00,
                    :kentucky	=> 26528.00,
                    :louisiana	=> 29305.00,
                    :maine	=>	43107.00,
                    :maryland	=>	38328.00,
                    :massachusetts	=>	36982.00,
                    :michigan	=>	27858.00,
                    :minnesota	=>	49245.00,
                    :mississippi	=>	25907.00,
                    :missouri	=>	30571.00,
                    :montana	=>	28819.00,
                    :nebraska	=> 35984.00,
                    :nevada	=> 33620.00,
                    :new_hampshire => 40383.00,
                    :new_jersey	=> 34292.00,
                    :new_mexico	=> 34401.00,
                    :new_york => 43956.00,
                    :north_carolina	=>34457.00,
                    :north_dakota => 36082.00,
                    :ohio => 32004.00,
                    :oklahoma => 26422.00,
                    :oregon => 30967.00,
                    :pennsylvania	=> 29349.00,
                    :rhode_island	=> 37828.00,
                    :south_carolina	=> 27804.00,
                    :south_dakota	=> 31924.00,
                    :tennessee	=> 25484.00,
                    :texas	=> 28730.00,
                    :utah	=> 28381.00,
                    :vermont	=> 35441.00,
                    :virginia	=> 30600.00,
                    :washington	=> 28470.00,
                    :west_virginia => 27206.00,
                    :wisconsin	=>32284.00,
                    :wyoming	=> 32585.00
                 )

MedicaidAnnualThreshold.delete_all
MedicaidAnnualThreshold.create!(:start_date => Date.today - 365,
                    :end_date => Date.today + 365,
                    :alabama => 23981.00,
                    :alaska => 50054.00,
                    :arizona	=> 26638.00,
                    :arkansas	=> 28221.00,
                    :california	=> 34324.00,
                    :colorado	=> 31212.00,
                    :connecticut => 54815.00,
                    :delaware	=> 37538.00,
                    :district_of_columbia	=> 42071.00,
                    :florida	=> 28427.00,
                    :georgia	=>27295.00,
                    :hawaii	=> 34056.00,
                    :idaho	=> 38097.00,
                    :illinois	=> 26298.00,
                    :indiana	=> 32930.00,
                    :iowa	=> 30477.00,
                    :kansas	=>	33540.00,
                    :kentucky	=> 26528.00,
                    :louisiana	=> 29305.00,
                    :maine	=>	43107.00,
                    :maryland	=>	38328.00,
                    :massachusetts	=>	36133.00,
                    :michigan	=>	27858.00,
                    :minnesota	=>	49245.00,
                    :mississippi	=>	25907.00,
                    :missouri	=>	30571.00,
                    :montana	=>	28819.00,
                    :nebraska	=> 35984.00,
                    :nevada	=> 33620.00,
                    :new_hampshire => 40383.00,
                    :new_jersey	=> 34292.00,
                    :new_mexico	=> 34401.00,
                    :new_york => 43956.00,
                    :north_carolina	=>34457.00,
                    :north_dakota => 36082.00,
                    :ohio => 32004.00,
                    :oklahoma => 26422.00,
                    :oregon => 30967.00,
                    :pennsylvania	=> 29349.00,
                    :rhode_island	=> 37828.00,
                    :south_carolina	=> 27804.00,
                    :south_dakota	=> 31924.00,
                    :tennessee	=> 25484.00,
                    :texas	=> 28730.00,
                    :utah	=> 28381.00,
                    :vermont	=> 35441.00,
                    :virginia	=> 30600.00,
                    :washington	=> 28470.00,
                    :west_virginia => 27206.00,
                    :wisconsin	=>32284.00,
                    :wyoming	=> 32585.00
)
#this is a test by Bob to see if we can reference the rAge calc later on in the calcs
# Create web calcs
WebCalc.delete_all
@RAge = WebCalc.new(:name => 'RAge')
@RAge.operation = "
unless manager.get_answer_by_question_name('SitDate').blank? || manager.get_answer_by_question_name('BirthDate').blank?
  SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
  BirthDate = Date.strptime(manager.get_answer_by_question_name('BirthDate'), '%m/%d/%Y')
  answer = (SitDate.year - BirthDate.year)
  subyear = 0
  if BirthDate.month > SitDate.month then
    subyear = 1
  elsif BirthDate.month == SitDate.month then
    if Birthdate.day > SitDate.day  then
      subyear = 1
    end
  end
    answer = answer - subyear
    return answer
  else 
   return 0
end
"
@RAge.save!

@RSpouseAge = WebCalc.new(:name => 'RSpouseAge')
@RSpouseAge.operation = "
unless manager.get_answer_by_question_name('SitDate').blank? || manager.get_answer_by_question_name('SpouseBirthDate').blank?
  SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
  SpouseBirthDate = Date.strptime(manager.get_answer_by_question_name('SpouseBirthDate'), '%m/%d/%Y')
  answer = (SitDate.year - SpouseBirthDate.year)
  subyear = 0
  if SpouseBirthDate.month > SitDate.month then
    subyear = 1
  elsif SpouseBirthDate.month == SitDate.month then
    if SpouseBirthdate.day > SitDate.day  then
      subyear = 1
    end
  end
    answer = answer - subyear
    return answer
  else 
   return 0
end
"
@RSpouseAge.save!

@RSgaAmt  = WebCalc.new(:name => 'RSgaAmt')
@RSgaAmt.operation = "
Blind = manager.get_answer_by_question_name('Blind')
Disability = manager.get_answer_by_question_name('Disability')
unless manager.get_answer_by_question_name('SitDate').blank? || manager.get_answer_by_question_name('SpouseBirthDate').blank?
 SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
 #FederalRate.find(:first, conditions => ['start_date <= ? AND end_date >= ?', SitDate, SitDate])

 RateSgaBlindAmt = FederalRate.find(:first, :conditions => ['start_date <= ? AND end_date >= ?', sitDate, sitDate]).sga_blind_amount
 #RateSgaBlindAmt = FederalRate.first.sga_blind_amount
 RateSgaDisabledAmt = FederalRate.first.sga_disabled_amount
 if Blind == 'Yes'
   return RateSgaBlindAmt
 elsif Disability == 'Yes'
   return RateSgaDisabledAmt
 else
   return 0
 end
 
else
  return 99
end
"
@RSgaAmt.save!

@RSgaAmtBasedOnDate  = WebCalc.new(:name => 'RSgaAmtBasedOnDate')
@RSgaAmtBasedOnDate.operation = "
unless manager.get_answer_by_question_name('SitDate').blank? || manager.get_answer_by_question_name('SpouseBirthDate').blank?
  Blind = manager.get_answer_by_question_name('Blind')
 Disability = manager.get_answer_by_question_name('Disability')
 SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
#NOTE this is not working 'undefined method `where' for #<Class:0x10322a188>  RateSgaBlindAmt = FederalRate.where(SitDate >= start_date).sga_blind_amount
 #Mysql::Error: You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'SitDate >= start_date' at line 1   for RateSgaBlindAmt = FederalRate.find_by_sql('SitDate >= start_date').sga_blind_amount
 #RateSgaBlindAmt = FederalRate.find_by_sql('SELECT SitDate >= start_date').sga_blind_amount
  #RateSgaBlindAmt = FederalRate.find_by_sql('SELECT sga_blind_amount where '12/01/2010' >= start_date')
 #RateSgaBlindAmt = FederalRate.find_by_sql('SELECT sga_blind_amount where SitDate >= FederalRate.start_date')
 #RateSgaBlindAmt = FederalRate.find_by_sql('SELECT sga_blind_amount FROM FederalRate WHERE SitDate >= start_date')
 #RateSgaBlindAmt = FederalRate.find_by_sql('SELECT * FROM FederalRate WHERE SitDate >= start_date').sga_blind_amount
 #RateSgaBlindAmt = FederalRate.find_by_sql('SELECT * WHERE SitDate >= start_date').sga_blind_amount
 #RateSgaBlindAmt = FederalRate.find_by_sql('SitDate >= start_date').sga_blind_amount
 # Well none of these worked and i'm out of guesses
 
 RateSgaDisabledAmt = FederalRate.first.sga_disabled_amount
 RateSgaBlindAmt = FederalRate.first.sga_disabled_amount  # punt on this for now
 if Blind == 'Yes'
   return RateSgaBlindAmt
 elsif Disability == 'Yes'
   return RateSgaDisabledAmt
 else
   return 0
 end
else 
  return 0
end
"
@RSgaAmtBasedOnDate.save!

# add question groups
QuestionGroup.delete_all
@startup           =   QuestionGroup.create!(:name => 'Start-Up Information',  :order => 1)
@benefits          =   QuestionGroup.create!(:name => 'Benefits',              :order => 2)
@household         =   QuestionGroup.create!(:name => 'Household Info',        :order => 1)
@ssi               =   QuestionGroup.create!(:name => 'SSI',                   :order => 2)
@medicaid          =   QuestionGroup.create!(:name => 'Medicaid',              :order => 3)
@ssdi              =   QuestionGroup.create!(:name => 'SSDI',                  :order => 4)
@medicare          =   QuestionGroup.create!(:name => 'Medicare',              :order => 5)
@spouse_benefits   =   QuestionGroup.create!(:name => 'SPOUSE BENEFITS',        :order => 3)
@Spouse_SSI        =   QuestionGroup.create!(:name => 'Spouse SSI',              :order => 1)
@Spouse_Medicaid   =   QuestionGroup.create!(:name => 'Spouse Medicaid',         :order => 2)
@Spouse_SSDI       =   QuestionGroup.create!(:name => 'Spouse SSDI',             :order => 3)
@Spouse_Medicare   =   QuestionGroup.create!(:name => 'Spouse Medicare',         :order => 4)
@INCOME_RESOURCES  =   QuestionGroup.create!(:name => 'INCOME & RESOURCES',      :order => 4)
@Deeming           =   QuestionGroup.create!(:name => 'Deeming',               :order => 1)
@Resources         =   QuestionGroup.create!(:name => 'Resources',         :order => 2)
@In_Kind_Support   =   QuestionGroup.create!(:name => 'In-Kind Support',   :order => 3)
@Own_Unearned_Income   =   QuestionGroup.create!(:name => 'Own Unearned Income',         :order => 4)
@Spouse_Unearned_Income   =   QuestionGroup.create!(:name => 'Spouse Unearned Income',         :order => 5)
@Own_Earned_Income   =   QuestionGroup.create!(:name => 'Own Earned Income',         :order => 6)
@Spouse_Earned_Income   =   QuestionGroup.create!(:name => 'Spouse Earned Income',         :order => 7)
@EXPENSES   =   QuestionGroup.create!(:name => 'EXPENSES',         :order => 5)
@Work_Expenses   =   QuestionGroup.create!(:name => 'Work Expenses',         :order => 1)
@Other_Expenses   =   QuestionGroup.create!(:name => 'Other Expenses',         :order => 2)
@Employability_Investments   =   QuestionGroup.create!(:name => 'Employability Investments',         :order => 3)
@WORK_INCENTIVES   =   QuestionGroup.create!(:name => 'WORK INCENTIVES',         :order => 6)
@Student_Earned_Income_Exclutsion   =   QuestionGroup.create!(:name => 'Student Earned Income Exclusion (SEIE)',         :order => 1)
@Impairment_Related_Work_Expense   =   QuestionGroup.create!(:name => 'Impairment-Related Work Expense (IRWE)',         :order => 2)
@Blind_Work_Expense   =   QuestionGroup.create!(:name => 'Blind Work Expense (BWE)',         :order => 3)
@Plan_for_Achieving_Self_Support   =   QuestionGroup.create!(:name => 'Plan for Achieving Self-Support (PASS)',         :order => 4)
@Trial_Work_Period   =   QuestionGroup.create!(:name => 'Trial Work Period (TWP)',         :order => 5)
@SubTab6_6_Subsidy   =   QuestionGroup.create!(:name => 'Subsidies (SSDI)',         :order => 6)
@Tab7_BenefitAdjust   =   QuestionGroup.create!(:name => 'Benefit Amount Adjustments',         :order => 7)
@SubTab7_1_OwnDiBenefitAdjust   =   QuestionGroup.create!(:name => 'Own SSDI Benefit Adjustments',         :order => 1)
@SubTab7_2_SpouseSsdiBenefitAdjust   =   QuestionGroup.create!(:name => 'Spouse SSDI Benefit Adjustments',         :order => 2)
@SubTab7_3_SsiBenefitAdjust   =   QuestionGroup.create!(:name => 'SSI Benefit Adjustments',         :order => 3)

# setup group hierarchy and flow
@startup.parent         =   nil
@startup.next_group     =   @benefits
@startup.save!
@benefits.parent        =   nil
@benefits.next_group    =   nil
@benefits.save!
@household.parent       =   @benefits
@household.next_group   =   @ssi
@household.save!
@ssi.parent             =   @benefits
@ssi.next_group         =   @medicaid
@ssi.save!
@medicaid.parent        =   @benefits
@medicaid.next_group    =   @ssdi
@medicaid.save!
@ssdi.parent            =   @benefits
@ssdi.next_group        =   @medicare
@ssdi.save!
@medicare.parent        =   @benefits
@medicare.next_group    =   @Spouse_SSI
@medicare.save!
@spouse_benefits.parent         =   nil
@spouse_benefits.next_group     =   nil
@spouse_benefits.save!

@Spouse_SSI.parent         =   @spouse_benefits
@Spouse_SSI.next_group     =   @Spouse_Medicaid
@Spouse_SSI.save!

@Spouse_Medicaid.parent         =   @spouse_benefits
@Spouse_Medicaid.next_group     =   @Spouse_SSDI
@Spouse_Medicaid.save!
@Spouse_SSDI.parent         =   @spouse_benefits
@Spouse_SSDI.next_group     =   @Spouse_Medicare
@Spouse_SSDI.save!
@Spouse_Medicare.parent         =   @spouse_benefits
@Spouse_Medicare.next_group     =   @Deeming
#Bob is not clear where the last group in a sub group should link? to the Next Major group or the next group containing a possible question
#also not sure what happens of no questions show in a group, does it know to skip to the next group?
@Spouse_Medicare.save!
@INCOME_RESOURCES.parent         =   nil
@INCOME_RESOURCES.next_group     =   nil
@INCOME_RESOURCES.save!
@Deeming.parent         =   @INCOME_RESOURCES
@Deeming.next_group     =   @Resources
@Deeming.save!
@Resources.parent         =   @INCOME_RESOURCES
@Resources.next_group     =   @In_Kind_Support
@Resources.save!
@In_Kind_Support.parent         =   @INCOME_RESOURCES
@In_Kind_Support.next_group     =   @Own_Unearned_Income
@In_Kind_Support.save!
@Own_Unearned_Income.parent         =   @INCOME_RESOURCES
@Own_Unearned_Income.next_group     =   @Spouse_Unearned_Income
@Own_Unearned_Income.save!
@Spouse_Unearned_Income.parent         =   @INCOME_RESOURCES
@Spouse_Unearned_Income.next_group     =   @Own_Earned_Income
@Spouse_Unearned_Income.save!
@Own_Earned_Income.parent         =   @INCOME_RESOURCES
@Own_Earned_Income.next_group     =   @Spouse_Earned_Income
@Own_Earned_Income.save!
@Spouse_Earned_Income.parent         =   @INCOME_RESOURCES
@Spouse_Earned_Income.next_group     =   @Work_Expenses
@Spouse_Earned_Income.save!
@EXPENSES.parent         =   nil
@EXPENSES.next_group     =   nil
@EXPENSES.save!
@Work_Expenses.parent         =   @EXPENSES
@Work_Expenses.next_group     =   @Other_Expenses
@Work_Expenses.save!
@Other_Expenses.parent         =   @EXPENSES
@Other_Expenses.next_group     =   @Employability_Investments
@Other_Expenses.save!
@Employability_Investments.parent         =   @EXPENSES
@Employability_Investments.next_group     =   @Student_Earned_Income_Exclutsion
@Employability_Investments.save!
@WORK_INCENTIVES.parent         =   nil
@WORK_INCENTIVES.next_group     =   nil
@WORK_INCENTIVES.save!
@Student_Earned_Income_Exclutsion.parent         =   @WORK_INCENTIVES
@Student_Earned_Income_Exclutsion.next_group     =   @Impairment_Related_Work_Expense
@Student_Earned_Income_Exclutsion.save!
@Impairment_Related_Work_Expense.parent         =   @WORK_INCENTIVES
@Impairment_Related_Work_Expense.next_group     =   @Blind_Work_Expense
@Impairment_Related_Work_Expense.save!
@Blind_Work_Expense.parent         =   @WORK_INCENTIVES
@Blind_Work_Expense.next_group     =   @Plan_for_Achieving_Self_Support
@Blind_Work_Expense.save!
@Plan_for_Achieving_Self_Support.parent         =   @WORK_INCENTIVES
@Plan_for_Achieving_Self_Support.next_group     =   @Trial_Work_Period
@Plan_for_Achieving_Self_Support.save!
@Trial_Work_Period.parent         =   @WORK_INCENTIVES
@Trial_Work_Period.next_group     =   @SubTab6_6_Subsidy
@Trial_Work_Period.save!
@SubTab6_6_Subsidy.parent         =   @WORK_INCENTIVES
@SubTab6_6_Subsidy.next_group     =   @SubTab7_1_OwnDiBenefitAdjust
@SubTab6_6_Subsidy.save!
@Tab7_BenefitAdjust.parent         =   nil
@Tab7_BenefitAdjust.next_group     =   nil
@Tab7_BenefitAdjust.save!
@SubTab7_1_OwnDiBenefitAdjust.parent         =   @Tab7_BenefitAdjust
@SubTab7_1_OwnDiBenefitAdjust.next_group     =   @SubTab7_2_SpouseSsdiBenefitAdjust
@SubTab7_1_OwnDiBenefitAdjust.save!
@SubTab7_2_SpouseSsdiBenefitAdjust.parent         =   @Tab7_BenefitAdjust
@SubTab7_2_SpouseSsdiBenefitAdjust.next_group     =   @SubTab7_3_SsiBenefitAdjust
@SubTab7_2_SpouseSsdiBenefitAdjust.save!
@SubTab7_3_SsiBenefitAdjust.parent         =   @Tab7_BenefitAdjust
@SubTab7_3_SsiBenefitAdjust.next_group     =   nil
@SubTab7_3_SsiBenefitAdjust.save!


# Create questions
Question.delete_all
@CurrentDate                              = Question.new(:display_rules => 'always', :default_answer => 'Current Date',      :reference_id =>   '',    :question_type => 'not_question', :answer_choices => '',                          :order => 1 ,    :group_id => @startup.id)
@BirthDate                                = Question.new(:display_rules => 'always', :default_answer => '01/01/1990',        :reference_id =>   '4',   :question_type => 'date_time',    :answer_choices => '',                          :order => 2 ,    :group_id => @startup.id)
#answer = manager.get_answer_by_question_name(self.name)
#@BirthDate.validation_rules = "
# self.id == 'Virginia'
#"

@BirthDate.name = "BirthDate"
@BirthDate.text = "What is your Birthdate"
@BirthDate.validation_message = "
Click on the Calendar Icon to the right of the question or enter the Month/Day/Year, for example enter 01/21/1990 for January 21st, 1990. 
"
@BirthDate.save!

@SitDate                                  = Question.new(:display_rules => 'always', :default_answer => 'Current Date',                  :reference_id =>   '5',   :question_type => 'date_time',    :answer_choices => '',                          :order => 3 ,    :group_id => @startup.id)
#@SitDate.name = "SitDate"
#@SitDate.text ="You can not enter a date earlier than Jan 1, 2010.  Click on the Calendar Icon to the right of the question or enter the Month/Day/Year, for example enter 02/21/2011 for February 21st, 2011."
#
#@SitDate.save!

@State                                    = Question.new(:display_rules => 'always', :default_answer => 'Virginia',          :reference_id =>   '6',   :question_type => 'select',       :answer_choices => 'states',                    :order => 4 ,    :group_id => @startup.id)
@Blind                                    = Question.new(:display_rules => 'always', :default_answer => 'No',                :reference_id =>   '7',   :question_type => 'select',       :answer_choices => 'Yes, No',                   :order => 5 ,    :group_id => @startup.id)
@Disability                               = Question.new(:display_rules => 'always', :default_answer => 'Yes',               :reference_id =>   '8',   :question_type => 'select',       :answer_choices => 'Yes, No',                   :order => 6 ,    :group_id => @startup.id)
@SitName                                  = Question.new(:display_rules => 'always', :default_answer => 'Current Situation', :reference_id =>   '9',   :question_type => 'text_field',   :answer_choices => '',                          :order => 7 ,    :group_id => @startup.id)
@VA_CityCounty                             = Question.new(:display_rules => 'always', :default_answer => '',                  :reference_id => '12',  :question_type => 'select',       :answer_choices => 'counties and cities',          :order => 1 , :group_id => @household.id)
@LiveWithSpouse                           = Question.new(:display_rules => 'always', :default_answer => 'Yes',               :reference_id => '13',  :question_type => 'select',       :answer_choices => 'Yes, No',                   :order => 2 ,    :group_id => @household.id)
@SpouseBirthDate                          = Question.new(:display_rules => 'always', :default_answer => '01/01/1950',        :reference_id => '14',  :question_type => 'date_time',    :answer_choices => '',                          :order => 3 ,    :group_id => @household.id)
@SpouseBlind                              = Question.new(:display_rules => 'always', :default_answer => 'No',                :reference_id => '15',  :question_type => 'select',       :answer_choices => 'Yes, No',                   :order => 4 ,    :group_id => @household.id)
@SpouseDisability                         = Question.new(:display_rules => 'always', :default_answer => 'No',                :reference_id => '15',  :question_type => 'select',       :answer_choices => 'Yes, No',                   :order => 5 ,    :group_id => @household.id)
@VA_CaidLiveWithSpouseAndOwnParents              = Question.new(:display_rules => 'always', :default_answer => 'No',                :reference_id => '!7',  :question_type => 'select',       :answer_choices => 'Yes, No',                   :order => 6 ,    :group_id => @household.id)
@VA_CaidLiveWithSpouseAndSpouseParents           = Question.new(:display_rules => 'always', :default_answer => 'No',                :reference_id => '18',  :question_type => 'select',       :answer_choices => 'Yes, No',                   :order => 7 ,    :group_id => @household.id)
@LiveWithSpouseAndOthers                  = Question.new(:display_rules => 'always', :default_answer => 'No',                :reference_id => '19',  :question_type => 'select',       :answer_choices => 'Yes, No',                   :order => 8 ,    :group_id => @household.id)
@VA_LiveWithSpouseAuxGrantFacility           = Question.new(:display_rules => 'always', :default_answer => 'No',                :reference_id => '20',  :question_type => 'select',       :answer_choices => 'Yes, No',                   :order => 9 ,    :group_id => @household.id)
@VA_CaidLiveWithSpouseInFacility               = Question.new(:display_rules => 'always', :default_answer => 'No',                :reference_id => '21',  :question_type => 'select',       :answer_choices => 'Yes, No',                   :order => 10 ,    :group_id => @household.id)
@Alone                                    = Question.new(:display_rules => 'always', :default_answer => 'Yes',               :reference_id => '22',  :question_type => 'select',       :answer_choices => 'Yes, No',                   :order => 11,    :group_id => @household.id)
@LiveWithParents                          = Question.new(:display_rules => 'always', :default_answer => 'No',               :reference_id => '23',  :question_type => 'select',       :answer_choices => 'Yes, No',                   :order => 12,    :group_id => @household.id)
@LiveWithOthers                           = Question.new(:display_rules => 'always', :default_answer => 'Yes',               :reference_id => '24',  :question_type => 'select',       :answer_choices => 'Yes, No',                   :order => 13,    :group_id => @household.id)
@VA_LiveInAuxGrantFacility                   = Question.new(:display_rules => 'always', :default_answer => 'No',                :reference_id => '25',  :question_type => 'select',       :answer_choices => 'Yes, No',                   :order => 14,    :group_id => @household.id)
@VA_CaidLiveInFacility                       = Question.new(:display_rules => 'always', :default_answer => 'No',                :reference_id => '26',  :question_type => 'select',       :answer_choices => 'Yes, No',                   :order => 15,    :group_id => @household.id)
@VA_CaidLiveInFacilitySpouseInCommunity   = Question.new(:display_rules => 'always', :default_answer => 'No',                :reference_id => '27',  :question_type => 'select',       :answer_choices => 'Yes, No',                   :order => 16,    :group_id => @household.id)


@CurrentDate.name = 'CurrentDate'
@CurrentDate.text = 'Today\'s Date'
@CurrentDate.save!

@BirthDate.name = 'BirthDate'
@BirthDate.text = 'What is your birthdate?  (MM/DD/YYYY)'
@BirthDate.save!

@SitDate.name = 'SitDate'
@SitDate.text = 'Enter date for which you want WW-Web to calculate results (MM/DD/YYYY).'
#@SitDate.validation_rules = "
#true
#unless self.id.blank?
#Validation failed for this line /opt/local/lib/ruby/1.8/date/format.rb:599:in `dup': can't dup Fixnum SitDate1 = Date.strptime(self.id, '%m/%d/%Y')
# If (SitDate.year < 2011) then
#   false
#  else
#   true
# end
#else
#  false
#end
#"
@SitDate.save!

@State.name = 'State'
@State.text = 'In what State do you live?'
@State.display_rules = "
unless manager.get_answer_by_question_name('SitDate').blank? || manager.get_answer_by_question_name('BirthDate').blank?
  SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
  BirthDate = Date.strptime(manager.get_answer_by_question_name('BirthDate'), '%m/%d/%Y')
  #answer = 20 # WebCalc.find_by_name('RAge')
 
  if SitDate.year - BirthDate.year >= 15 && SitDate.year - BirthDate.year < 66 then
    true
  else
    false
  end    
else
  false
  
end
"
#@State.validation_rules = "
# self.id == 'Virginia'
#"
#@State.validation_message = "
#Please try again, pay attention to the drop down selection for VA
#"
@State.save!

@Blind.name = 'Blind'
@Blind.text = 'Are you legally blind according to SSA criteria?'
@Blind.display_rules = "
unless manager.get_answer_by_question_name('SitDate').blank? || manager.get_answer_by_question_name('BirthDate').blank?
  SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
  BirthDate = Date.strptime(manager.get_answer_by_question_name('BirthDate'), '%m/%d/%Y')
  State = manager.get_answer_by_question_name('State')
  if SitDate.year - BirthDate.year >= 15 && SitDate.year - BirthDate.year < 66  && State == 'Virginia' then 
    true
  else
    false
  end    
else
  false
end
"
@Blind.save!

@Disability.name = 'Disability'
@Disability.text = 'Do you have a disability according to SSA criteria?'
@Disability.display_rules = "
unless manager.get_answer_by_question_name('SitDate').blank? || manager.get_answer_by_question_name('BirthDate').blank?
  SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
  BirthDate = Date.strptime(manager.get_answer_by_question_name('BirthDate'), '%m/%d/%Y')
  State = manager.get_answer_by_question_name('State')
  Blind = manager.get_answer_by_question_name('Blind')
  if SitDate.year - BirthDate.year >= 15 && SitDate.year - BirthDate.year < 66  && State == 'Virginia' && Blind == 'No' then 
    true
  else
    false
  end    
else
  false
end
"
@Disability.save!
@SitName.name = 'SitName'
@SitName.text = 'Enter a brief name for this situation'
@SitName.display_rules = "
Blind = manager.get_answer_by_question_name('Blind')
Disability = manager.get_answer_by_question_name('Disability')
Blind == 'Yes' || Disability == 'Yes'
"
@SitName.save!


@VA_CityCounty.name = 'VA_CityCounty'
@VA_CityCounty.text = 'In what Virginia City or County do you live?'
@VA_CityCounty.display_rules = "
Blind = manager.get_answer_by_question_name('Blind')
Disability = manager.get_answer_by_question_name('Disability')
Blind == 'Yes' || Disability == 'Yes'
"
@VA_CityCounty.save!
@LiveWithSpouse.name = 'LiveWithSpouse'
@LiveWithSpouse.text = 'Are you married and living with your spouse?'
@LiveWithSpouse.display_rules = "
Blind = manager.get_answer_by_question_name('Blind')
Disability = manager.get_answer_by_question_name('Disability')
Blind == 'Yes' || Disability == 'Yes'
"
@LiveWithSpouse.save!
@SpouseBirthDate.name = 'SpouseBirthDate'
@SpouseBirthDate.text = 'What is your spouse\'s birthdate? (MM/DD/YYYY)'
@SpouseBirthDate.display_rules = "
LiveWithSpouse = manager.get_answer_by_question_name('LiveWithSpouse')
LiveWithSpouse == 'Yes'
"
@SpouseBirthDate.save!
@SpouseBlind.name = 'SpouseBlind'
@SpouseBlind.text = 'Is your spouse legally blind according to SSA criteria?'
@SpouseBlind.display_rules = "
LiveWithSpouse = manager.get_answer_by_question_name('LiveWithSpouse')
LiveWithSpouse == 'Yes'
"
@SpouseBlind.save!
@SpouseDisability.name = 'SpouseDisability'
@SpouseDisability.text = 'Does your spouse have a disability according to SSA criteria?'
@SpouseDisability.display_rules = "
LiveWithSpouse = manager.get_answer_by_question_name('LiveWithSpouse')
SpouseBlind = manager.get_answer_by_question_name('SpouseBlind')
LiveWithSpouse == 'Yes' && SpouseBlind == 'No'
"
@SpouseDisability.save!

#one to fix
# edit on 10/18/2010 change question name from LiveWithSpouseAndOwnParents to VA_CaidLiveWithSpouseAndOwnParents
#Edit to reflect new display rule IF LiveWithSpouse = Y AND (SitDate - BirthDate) < 21 yrs
#20 what am i missing here to access RAge calc?
@VA_CaidLiveWithSpouseAndOwnParents.name = 'VA_CaidLiveWithSpouseAndOwnParents'
@VA_CaidLiveWithSpouseAndOwnParents.text = 'Do you and your spouse live with your parents?'
@VA_CaidLiveWithSpouseAndOwnParents.display_rules = "
unless manager.get_answer_by_question_name('SitDate').blank? || manager.get_answer_by_question_name('SpouseBirthDate').blank?
  SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
  #SpouseBirthDate = Date.strptime(manager.get_answer_by_question_name('SpouseBirthDate'), '%m/%d/%Y')
 RAge1 = 20 # RAge1 = (WebCalc.find_by_name('RAge')).to_f
  
  LiveWithSpouse = manager.get_answer_by_question_name('LiveWithSpouse')
  LiveWithSpouse == 'Yes' && RAge1 < 21
else
  false
end
"
@VA_CaidLiveWithSpouseAndOwnParents.save!

#10/18/2010 Bob changed the name of this question per workbook revision [Row 30 in main log] and sent DR a question about the display rule.  Bob thinks it should be birthdate and not spouse's birthdate
#18
#Bob was wrong "What is important in calculating VA Medicaid eligibility and parental deeming is whether the couple is living with the parents of a member of the couple who is less than 21 years old.  The age of the other member of the couple is not relevant for purposes of determining parental deeming."
@VA_CaidLiveWithSpouseAndSpouseParents.name = 'VA_CaidLiveWithSpouseAndSpouseParents'
@VA_CaidLiveWithSpouseAndSpouseParents.text = 'Do you and your spouse live with your spouse\'s parents?'
#10/19/2010 display rule review
#IF LiveWithSpouse = Y AND (SitDate - SpouseBirthDate) < 21 yrs AND VA_CaidLiveWithSpouseAndOwnParents <> Y
@VA_CaidLiveWithSpouseAndSpouseParents.display_rules = "
unless manager.get_answer_by_question_name('SitDate').blank? || manager.get_answer_by_question_name('SpouseBirthDate').blank?
  SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
  #SpouseBirthDate = Date.strptime(manager.get_answer_by_question_name('SpouseBirthDate'), '%m/%d/%Y')
  SpouseAge = 20 # WebCalc.find_by_name('RSpouseAge')
  LiveWithSpouse = manager.get_answer_by_question_name('LiveWithSpouse')
  VA_CaidLiveWithSpouseAndOwnParents = manager.get_answer_by_question_name('VA_CaidLiveWithSpouseAndOwnParents')
  LiveWithSpouse == 'Yes' &&  SpouseAge < 21 && VA_CaidLiveWithSpouseAndOwnParents != 'Yes'
else
  false
end
"
@VA_CaidLiveWithSpouseAndSpouseParents.save!

@LiveWithSpouseAndOthers.name = 'LiveWithSpouseAndOthers'
@LiveWithSpouseAndOthers.text = 'Do you and your spouse live with other adults?'
@LiveWithSpouseAndOthers.display_rules = "
LiveWithSpouse = manager.get_answer_by_question_name('LiveWithSpouse')
VA_CaidLiveWithSpouseAndOwnParents = manager.get_answer_by_question_name('VA_CaidLiveWithSpouseAndOwnParents')
VA_CaidLiveWithSpouseAndSpouseParents = manager.get_answer_by_question_name('VA_CaidLiveWithSpouseAndSpouseParents')
LiveWithSpouse == 'Yes' && VA_CaidLiveWithSpouseAndOwnParents != 'Yes' && VA_CaidLiveWithSpouseAndSpouseParents != 'Yes' 
"
@LiveWithSpouseAndOthers.save!
@VA_LiveWithSpouseAuxGrantFacility.name = 'VA_LiveWithSpouseAuxGrantFacility'
@VA_LiveWithSpouseAuxGrantFacility.text = 'Do you and your spouse live in a facility or foster care supported by an Auxiliary Grant?'
@VA_LiveWithSpouseAuxGrantFacility.display_rules = "
LiveWithSpouseAndOthers = manager.get_answer_by_question_name('LiveWithSpouseAndOthers')
State = manager.get_answer_by_question_name('State')
LiveWithSpouseAndOthers == 'Yes' && State == 'Virginia'
"
@VA_LiveWithSpouseAuxGrantFacility.save!
@VA_CaidLiveWithSpouseInFacility.name = 'VA_CaidLiveWithSpouseInFacility'
@VA_CaidLiveWithSpouseInFacility.text = 'Do you and your spouse live in a facility supported by Medicaid?'
@VA_CaidLiveWithSpouseInFacility.display_rules =  "
LiveWithSpouseAndOthers = manager.get_answer_by_question_name('LiveWithSpouseAndOthers')
VA_LiveWithSpouseAuxGrantFacility = manager.get_answer_by_question_name('VA_LiveWithSpouseAuxGrantFacility')
LiveWithSpouseAndOthers == 'Yes' && VA_LiveWithSpouseAuxGrantFacility != 'Yes'
"
@VA_CaidLiveWithSpouseInFacility.save!

@Alone.name = 'Alone'
@Alone.text = 'Do you live alone?'
@Alone.display_rules =  "
LiveWithSpouse = manager.get_answer_by_question_name('LiveWithSpouse')
LiveWithSpouse == 'No'
"
@Alone.save!

#This needs work
@LiveWithParents.name = 'LiveWithParents'
@LiveWithParents.text = 'Do you live with your parents?'
@LiveWithParents.display_rules =  "
unless manager.get_answer_by_question_name('SitDate').blank? || manager.get_answer_by_question_name('BirthDate').blank?
  SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
  BirthDate = Date.strptime(manager.get_answer_by_question_name('BirthDate'), '%m/%d/%Y')
  Alone = manager.get_answer_by_question_name('Alone')
  Age = 20 # WebCalc.find_by_name('RAge')
  Alone == 'No' && Age < 22
else
  false
end
"
@LiveWithParents.save!
@LiveWithOthers.name = 'LiveWithOthers'
@LiveWithOthers.text = 'Do you live with other adults?'
@LiveWithOthers.display_rules =  "
LiveWithParents = manager.get_answer_by_question_name('LiveWithParents')
Alone = manager.get_answer_by_question_name('Alone')
Alone == 'No' && LiveWithParents != 'Yes'
"
@LiveWithOthers.save!

#VA_LiveInAuxGrantFacility
#Why does this question not show up when live with others is yes and State == Va?  I fxed a typo but it still needs a double change to the "live with other adults" question answer to get it to show 
@VA_LiveInAuxGrantFacility.name = 'VA_LiveInAuxGrantFacility'
@VA_LiveInAuxGrantFacility.text = 'Do you live in a facility or foster care supported by an Auxiliary Grant?'
@VA_LiveInAuxGrantFacility.display_rules =  "
LiveWithOthers = manager.get_answer_by_question_name('LiveWithOthers')
State = manager.get_answer_by_question_name('State')
LiveWithParents = manager.get_answer_by_question_name('LiveWithParents')

LiveWithOthers == 'Yes' && State == 'Virginia' && LiveWithParents != 'Yes'
"
@VA_LiveInAuxGrantFacility.save!

@VA_CaidLiveInFacility.name = 'VA_CaidLiveInFacility'
@VA_CaidLiveInFacility.text = 'Do you live in a facility supported by Medicaid?'
@VA_CaidLiveInFacility.display_rules =  "
LiveWithOthers = manager.get_answer_by_question_name('LiveWithOthers')
VA_LiveInAuxGrantFacility = manager.get_answer_by_question_name('VA_LiveInAuxGrantFacility')
LiveWithOthers == 'Yes' && VA_LiveInAuxGrantFacility != 'Yes'
"
@VA_CaidLiveInFacility.save!


@VA_CaidLiveInFacilitySpouseInCommunity.name= 'VA_CaidLiveInFacilitySpouseInCommunity'
@VA_CaidLiveInFacilitySpouseInCommunity.text = 'Do you have a spouse living in the community?'
@VA_CaidLiveInFacilitySpouseInCommunity.display_rules =  "
VA_CaidLiveInFacility = manager.get_answer_by_question_name('VA_CaidLiveInFacility')
VA_CaidLiveInFacility == 'Yes'
"
@VA_CaidLiveInFacilitySpouseInCommunity.save!

#@VA_CaidLiveInFacilitySpouseInCommunity   = Question.new(:display_rules => 'always', :default_answer => 'No',                :reference_id => '27',  :question_type => 'select',       :answer_choices => 'Yes, No',                   :order => 16,    :group_id => @household.id)
#29	Do you receive Supplemental Security Income (SSI)?	SsiGet			YES:NO		YES	If Blind = Y OR Disability = Y	Appear	YES	MORE-INFO will tell users to enter YES if they had SSI but their check stoped because of earned income.  If they then answer that they don't get Mediciad (but theiy should be eligible for 1619b, WW-WEB will tell them.  Users on 1619b may not read the MORE-INFO and enter NO, but if they are on Medicaid, they will have a chance to identify their Medicaid Covered Group as 1619b.
@SsiGet   = Question.new(:display_rules => 'always', :default_answer => 'No',                :reference_id => '29',  :question_type => 'select',       :answer_choices => 'Yes, No',                   :order => 1,    :group_id => @ssi.id)
@SsiGet.name = 'SsiGet'
@SsiGet.text = 'Do you receive Supplemental Security Income (SSI)?'
@SsiGet.display_rules = "
Blind = manager.get_answer_by_question_name('Blind')
Disability = manager.get_answer_by_question_name('Disability')
Blind == 'Yes' || Disability == 'Yes'
"
@SsiGet.save!

#30	Do you have a Final Determination letter from SSA saying that you are eligible for SSI and has it been 12 months since the onset of your disability?	SsiGetFinalDetermination			YES:NO		YES	If SsiGet = Y AND Blind = N
@SsiGetFinalDetermination   = Question.new(:display_rules => 'always', :default_answer => 'No',                :reference_id => '',  :question_type => 'select',       :answer_choices => 'Yes, No',                   :order => 2,    :group_id =>  @ssi.id)
@SsiGetFinalDetermination.name = 'SsiGetFinalDetermination'
@SsiGetFinalDetermination.text = 'Do you have a Final Determination letter from SSA saying that you are eligible for SSI and has it been 12 months since the onset of your disability?'
@SsiGetFinalDetermination.display_rules = "
SsiGet = manager.get_answer_by_question_name('SsiGet')
Blind = manager.get_answer_by_question_name('Blind')
SsiGet == 'Yes' && Blind == 'No'
"
@SsiGetFinalDetermination.save!


#31	Medicaid	SubTab2_3_CaidInfo						Active if any included questions appear and as described in WW-Web Behavior.doc		
#32	Do you have any form of Medicaid coverage?	CaidGet			YES:NO		EXPRESSION: If SsiGet = Y, THEN YES, ELSE NO	If Blind = Y OR Disability = Y	Appear	YES
@CaidGet   = Question.new(:display_rules => 'always', :default_answer => 'Yes',                :reference_id => '',  :question_type => 'select',       :answer_choices => 'Yes, No',                   :order => 1,    :group_id =>  @medicaid.id)
@CaidGet.name = 'CaidGet'
@CaidGet.text = 'Do you have any form of Medicaid coverage?'
@CaidGet.display_rules = "
Blind = manager.get_answer_by_question_name('Blind')
Disability = manager.get_answer_by_question_name('Disability')
Blind == 'Yes' || Disability == 'Yes'
"
@CaidGet.save!

#33	Virginia Medicaid: Under what Covered Group do you have Medicaid Coverage?	VA_CaidGetCoveredGroup			SSI Recipient:1619b:MEDICAID WORKS:Auxiliary Grant:Adult Disabled Child:Protected SSI Disabled Child:QMB:SLMB:QI:QDWI:80% FPL:Waiver:Medical Institution:Medically Needy(Spendown)		EXPRESSION:  If SsiGet = Y, THEN SSI Recipient, if (VA_CaidLiveWithSpouseInFacility = Y OR VA_CaidLiveInFacility = Y), THEN Medical Institution, ELSE 80% FPL	If State = Virginia AND CaidGet = Y	Appear	SSI Recipient	If we add other states, they will have different covered groups.
#    allowable answers SSI Recipient:1619b:MEDICAID WORKS:Auxiliary Grant:Adult Disabled Child:Protected SSI Disabled Child:QMB:SLMB:QI:QDWI:80% FPL:Waiver:Medical Institution:Medically Needy(Spendown)
#SSI Recipient:1619b, MEDICAID WORKS, Auxiliary Grant, Adult Disabled Child, Protected SSI Disabled Child, QMB, SLMB, QI, QDWI, 80% FPL, Waiver, Medical Institution, Medically Needy(Spendown)
@VA_CaidGetCoveredGroup   = Question.new(:display_rules => 'always', :default_answer => 'SSI Recipient',                :reference_id => '',  :question_type => 'select',       :answer_choices => 'SSI Recipient, 1619b, MEDICAID WORKS, Auxiliary Grant, Adult Disabled Child, Protected SSI Disabled Child, QMB, SLMB, QI, QDWI, 80% FPL, Waiver, Medical Institution, Medically Needy(Spendown)',                   :order => 2,    :group_id =>  @medicaid.id)
@VA_CaidGetCoveredGroup.name = 'VA_CaidGetCoveredGroup'
@VA_CaidGetCoveredGroup.text = 'Under what Covered Group do you have Medicaid Coverage?'
#If State = Virginia AND CaidGet = Y
@VA_CaidGetCoveredGroup.display_rules = "
State = manager.get_answer_by_question_name('State')
CaidGet = manager.get_answer_by_question_name('CaidGet')
State == 'Virginia' && CaidGet == 'Yes'
"
@VA_CaidGetCoveredGroup.save!

#34	Are you applying for Medicaid coverage?	CaidApply			YES:NO		YES	IF CaidGet = N	no		
@CaidApply   = Question.new(:display_rules => 'always', :default_answer => 'Yes',                :reference_id => '',  :question_type => 'select',       :answer_choices => 'Yes, No',                   :order => 3,    :group_id =>  @medicaid.id)
@CaidApply.name = 'CaidApply'
@CaidApply.text = 'Are you applying for Medicaid coverage?'
@CaidApply.display_rules = "
CaidGet = manager.get_answer_by_question_name('CaidGet')
CaidGet == 'No'
"
@CaidApply.save!
#NOTE while testing these questions i noticed that the VA_CaidApplyCoveredGroup question does not show when it should if default answer for CaidApply is set to Yes.  If it is set to No and then answered something gets reset and the question displays OK
# i'm guessing it is because 2 questions need to show at once if we want to accept the default answer. 

#35	Under what Virginia Covered Group are you applying for Medicaid coverage?	VA_CaidApplyCoveredGroup			SSI Recipient:1619b:MEDICAID WORKS:Auxiliary Grant:Adult Disabled Child:Protected SSI Disabled Child:QMB:SLMB:QI:QDWI:80% FPL:Waiver:Medical Institution:Medically Needy(Spendown)		80% FPL	IF State = Virginia AND CaidApply = Y	no		
@VA_CaidApplyCoveredGroup   = Question.new(:display_rules => 'always', :default_answer => 'SSI Recipient',                :reference_id => '',  :question_type => 'select',       :answer_choices => 'SSI Recipient, 1619b, MEDICAID WORKS, Auxiliary Grant, Adult Disabled Child, Protected SSI Disabled Child, QMB, SLMB, QI, QDWI, 80% FPL, Waiver, Medical Institution, Medically Needy(Spendown)',                   :order => 4,    :group_id =>  @medicaid.id)
@VA_CaidApplyCoveredGroup.name = 'VA_CaidApplyCoveredGroup'
@VA_CaidApplyCoveredGroup.text = 'Under what Virginia Covered Group are you applying for Medicaid coverage?'
#IF State = Virginia AND CaidApply = Y
@VA_CaidApplyCoveredGroup.display_rules = "
State = manager.get_answer_by_question_name('State')
CaidApply = manager.get_answer_by_question_name('CaidApply')
State == 'Virginia' && CaidApply == 'Yes'
"
@VA_CaidApplyCoveredGroup.save!

#36	SSDI	SubTab2_2_DiInfo						Active if any included questions appear and as described in WW-Web Behavior.doc		
#37	Do you receive Social Security Disability Insurance (SSDI)?	DiGet			YES:NO		YES	If Blind = Y OR Disability = Y	Appear	YES
@DiGet   = Question.new(:display_rules => 'always', :default_answer => 'Yes',                :reference_id => '',  :question_type => 'select',       :answer_choices => 'Yes, No',                   :order => 1,    :group_id =>  @ssdi.id)
@DiGet.name = 'DiGet'
@DiGet.text = 'Do you receive Social Security Disability Insurance (SSDI)?'
@DiGet.display_rules = "
Blind = manager.get_answer_by_question_name('Blind')
Disability = manager.get_answer_by_question_name('Disability')
Blind == 'Yes' || Disability == 'Yes'
"
@DiGet.save!

#38	Has it been at least 12 months since the onset of your disability as determined by SSA?	DiGet12MonthsSinceOnset			YES:NO		YES	If DiGet = Y	Appear	YES	
@DiGet12MonthsSinceOnset   = Question.new(:display_rules => 'always', :default_answer => 'Yes',                :reference_id => '',  :question_type => 'select',       :answer_choices => 'Yes, No',                   :order => 2,    :group_id =>  @ssdi.id)
@DiGet12MonthsSinceOnset.name = 'DiGet12MonthsSinceOnset'
@DiGet12MonthsSinceOnset.text = 'Has it been at least 12 months since the onset of your disability as determined by SSA?'
@DiGet12MonthsSinceOnset.display_rules = "
DiGet = manager.get_answer_by_question_name('DiGet')
DiGet == 'Yes'
"
@DiGet12MonthsSinceOnset.save!

#39	Are your SSDI benefits based on your own earnings record or on someone else's?	SsdiEarnRec			Self:Other		Self	If DiGet = Y	Appear	@ssdi
@SsdiEarnRec   = Question.new(:display_rules => 'always', :default_answer => 'Self',                :reference_id => '',  :question_type => 'select',       :answer_choices => 'Self, Other',                   :order => 3,    :group_id =>  @ssdi.id)
@SsdiEarnRec.name = 'SsdiEarnRec'
@SsdiEarnRec.text = 'Are your SSDI benefits based on your own earnings record or on someone else\'s?'
@SsdiEarnRec.display_rules = "
DiGet = manager.get_answer_by_question_name('DiGet')
DiGet == 'Yes'
"
@SsdiEarnRec.save!

#40	Do any dependents receive SSDI benefits based on your earnings record?	SsdiEarnRecDependents			YES:NO 		NO	If SsdiEarnRec = Self	no		
#NOTE we have a similar display issue here when default for SsdiEarn Rec is self and this question does not show
@SsdiEarnRecDependents   = Question.new(:display_rules => 'always', :default_answer => 'Yes',                :reference_id => '',  :question_type => 'select',       :answer_choices => 'Yes, No',                   :order => 4,    :group_id =>  @ssdi.id)
@SsdiEarnRecDependents.name = 'SsdiEarnRecDependents'
@SsdiEarnRecDependents.text = 'Do any dependents receive SSDI benefits based on your earnings record??'
@SsdiEarnRecDependents.display_rules = "
DiGet = manager.get_answer_by_question_name('DiGet')
SsdiEarnRec = manager.get_answer_by_question_name('SsdiEarnRec')
DiGet == 'Yes' && SsdiEarnRec == 'Self'
"
@SsdiEarnRecDependents.save!
 
#40.5	Are you a Disabled Adult Child according to SSA?	SsdiDac			YES:NO		NO	If SsdiEarnRec = Other	Appear	YES	Include this question because DAC's lose SSI-related  Medicaid because of unearned income only if they do so after subtracting SSDI payment from unearned income.
@SsdiDac   = Question.new(:display_rules => 'always', :default_answer => 'Yes',                :reference_id => '',  :question_type => 'select',       :answer_choices => 'Yes, No',                   :order => 5,    :group_id =>  @ssdi.id)
@SsdiDac.name = 'SsdiDac'
@SsdiDac.text = 'Are you a Disabled Adult Child according to SSA?'
@SsdiDac.display_rules = "
SsdiEarnRec = manager.get_answer_by_question_name('SsdiEarnRec')
SsdiEarnRec == 'Other'
"
@SsdiDac.save!

#NOTE this is one of the many places i try to deal with the subtracting Dates to get age issue
#41	What is the onset date of your blindness according to SSA? 	BlindOnsetDate			MM/DD/YEAR or Calendar Popup	Click on the Calendar Icon to the right of the question or enter the Month/Day/Year, for example enter 01/21/1990 for January 21st, 1990. 	1/1/1950	If DiGet = Y AND Blind = Y AND (SitDate - BirthDate > 54 yrs AND < 65 yrs)	#NAME?		Blind individuals between the ages of 54 and 65 who engage in SGA do not lose eligibility for SSDI as long as their skills and abilities are different from what they were before age 55 or before the onset of blindness, whichever is later.
@BlindOnsetDate  = Question.new(:display_rules => 'always', :default_answer => 'Current Date',                  :reference_id =>   '5',   :question_type => 'date_time',    :answer_choices => '',                          :order => 6,    :group_id => @ssdi.id)
@BlindOnsetDate.name = 'BlindOnsetDate'
@BlindOnsetDate.text = 'What is the onset date of your blindness according to SSA? (MM/DD/YYYY)'
#If DiGet = Y AND Blind = Y AND (SitDate - BirthDate > 54 yrs AND < 65 yrs)	  
@BlindOnsetDate.display_rules = "
unless manager.get_answer_by_question_name('SitDate').blank? || manager.get_answer_by_question_name('BirthDate').blank?
  DiGet = manager.get_answer_by_question_name('DiGet')
  Blind = manager.get_answer_by_question_name('Blind')
#  SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
#  BirthDate = Date.strptime(manager.get_answer_by_question_name('BirthDate'), '%m/%d/%Y')
 
# #NOTE this would DRY really nicely but i can't seem to get it to work 
 answer = 20 # WebCalc.find_by_name('RAge') or manager.find_by_name('RAge') ?????
  if answer > 54 && answer < 65 && Blind == 'Yes' && DiGet == 'Yes' then
     true
  else
     false
  end
else
  false
end
"
@BlindOnsetDate.save!


#42	Are your work skills and abilities different now than before age 55?	BlindSkillsBefore55			YES:NO		NO	If DiGet = Y AND Blind = Y AND (SitDate - BirthDate > 54 AND < 65) AND (BlindOnsetDate - BirthDate <= 55 yrs)	#NAME?		If work skills are different, then ESE will not cease because of SGA. BOB, note that the first term in the excel formula prevents a #NUM error when "no' should show and has nothing to do with the actual appearance rule.
@BlindSkillsBefore55  = Question.new(:display_rules => 'always', :default_answer => 'No',                  :reference_id =>   '42',   :question_type => 'select',       :answer_choices => 'Yes, No',                          :order => 7,    :group_id => @ssdi.id)
@BlindSkillsBefore55.name = 'BlindSkillsBefore55'
@BlindSkillsBefore55.text = 'Are your work skills and abilities different now than before age 55??'
#If DiGet = Y AND Blind = Y AND (SitDate - BirthDate > 54 AND < 65) AND (BlindOnsetDate - BirthDate <= 55 yrs)	  
@BlindSkillsBefore55.display_rules = "
unless manager.get_answer_by_question_name('SitDate').blank? || manager.get_answer_by_question_name('BirthDate').blank? || manager.get_answer_by_question_name('BlindOnsetDate').blank? 
  DiGet = manager.get_answer_by_question_name('DiGet')
  Blind = manager.get_answer_by_question_name('Blind')
  SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
  #BirthDate = Date.strptime(manager.get_answer_by_question_name('BirthDate'), '%m/%d/%Y')
  BlindOnsetDate = Date.strptime(manager.get_answer_by_question_name('BlindOnsetDate'), '%m/%d/%Y')
  RAge = 20 # WebCalc.find_by_name('RSpouseAge') (SitDate.year - BirthDate.year)
 
 #I'll live with calculating onset age every time  
  OnsetAge = (BlindOnsetDate.year - BirthDate.year)
  subyear= 0
  if BirthDate.month > BlindOnsetDate.month then
    subyear = 1
  elsif BirthDate.month == BlindOnsetDate.month then
    if Birthdate.day > BlindOnsetDate.day  then
      subyear = 1
    end
  end
  OnsetAge = OnsetAge - subyear
    
  RAge > 54 && RAge < 65 && OnsetAge <= 55 && Blind == 'Yes' && DiGet == 'Yes'
  
else
  false
end
"
@BlindSkillsBefore55.save!

#NOTE this has an example of trying to refernce a previous calc created in the seed file
#43	Are your work skills and abilities different now than before the onset date of your blindness?	BlindSkillsBeforeOnset			YES:NO		NO	If DiGet = Y AND Blind = Y AND (SitDate - BirthDate > 54 AND < 65) AND (BlindOnsetDate - BirthDate > 55 yrs)	#NAME?		If work skills are different, then ESE will not cease because of SGA. BOB, note that the first term in the excel formula prevents a #NUM error when "no' should show and has nothing to do with the actual appearance rule.
@BlindSkillsBeforeOnset  = Question.new(:display_rules => 'always', :default_answer => 'No',                  :reference_id =>   '43',   :question_type => 'select',       :answer_choices => 'Yes, No',                          :order => 8,    :group_id => @ssdi.id)
@BlindSkillsBeforeOnset.name = 'BlindSkillsBeforeOnset'
@BlindSkillsBeforeOnset.text = 'Are your work skills and abilities different now than before the onset date of your blindness?'
#If DiGet = Y AND Blind = Y AND (SitDate - BirthDate > 54 AND < 65) AND (BlindOnsetDate - BirthDate > 55 yrs)	  
@BlindSkillsBeforeOnset.display_rules = "
unless manager.get_answer_by_question_name('SitDate').blank? || manager.get_answer_by_question_name('BirthDate').blank? || manager.get_answer_by_question_name('BlindOnsetDate').blank? 
  DiGet = manager.get_answer_by_question_name('DiGet')
  Blind = manager.get_answer_by_question_name('Blind')
  SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
  #BirthDate = Date.strptime(manager.get_answer_by_question_name('BirthDate'), '%m/%d/%Y')
  BlindOnsetDate = Date.strptime(manager.get_answer_by_question_name('BlindOnsetDate'), '%m/%d/%Y')
  
  RAge = 20 # WebCalc.find_by_name('RAge')
    
  OnsetAge = (BlindOnsetDate.year - BirthDate.year)
  subyear= 0
  if BirthDate.month > BlindOnsetDate.month then
    subyear = 1
  elsif BirthDate.month == BlindOnsetDate.month then
    if Birthdate.day > BlindOnsetDate.day  then
      subyear = 1
    end
  end
  OnsetAge = OnsetAge - subyear
    
  RAge > 54 && RAge < 65 && OnsetAge > 55 && Blind == 'Yes' && DiGet == 'Yes'
  
else
  false
end
"
@BlindSkillsBeforeOnset.save!


#44	Do you have a current Benefits Planning Query (BPQY) report from SSA?	BPQY			YES:NO		NO
@BPQY  = Question.new(:display_rules => 'always', :default_answer => 'No',                  :reference_id =>   '44',   :question_type => 'select',       :answer_choices => 'Yes, No',                          :order => 9,    :group_id => @ssdi.id)
@BPQY.name = 'BPQY'
@BPQY.text = 'Do you have a current Benefits Planning Query (BPQY) report from SSA?'
#If Current/What-If Button = Current AND (SsiGet = Y OR DiGet = Y)'
@BPQY.display_rules = "
SsiGet = manager.get_answer_by_question_name('SsiGet')
DiGet = manager.get_answer_by_question_name('DiGet')
SsiGet ==  'Yes' || DiGet == 'Yes' 
"
@BPQY.save!

#45	Medicare	SubTab2_4_CareInfo						If BlindOnsetDate = Virginia			
#46	Do you have Medicare Part A (Hospitalization Insurance)?	CareAGet			YES:NO		EXPRESSION: If DiGet = Y, THEN YES, ELSE NO	If SsiGet = Y OR DiGet = Y OR CaidGet = Y OR CaidApply = Y	Appear	YES	
@CareAGet  = Question.new(:display_rules => 'always', :default_answer => 'No',                  :reference_id =>   '46',   :question_type => 'select',       :answer_choices => 'Yes, No',                          :order => 1,    :group_id => @medicare.id)
@CareAGet.name = 'CareAGet'
@CareAGet.text = 'Do you have Medicare Part A (Hospitalization Insurance)?'
#If SsiGet = Y OR DiGet = Y OR CaidGet = Y OR CaidApply = Y
@CareAGet.display_rules = "
SsiGet = manager.get_answer_by_question_name('SsiGet')
DiGet = manager.get_answer_by_question_name('DiGet')
CaidGet = manager.get_answer_by_question_name('CaidGet')
CaidApply = manager.get_answer_by_question_name('CaidApply')
SsiGet ==  'Yes' || DiGet == 'Yes' || CaidGet ==  'Yes' || CaidApply == 'Yes' 
"
@CareAGet.save!

#47	Do you have Medicare Part B (Medical Insurance)?	CareBGet			YES:NO		EXPRESSION: If DiGet = Y, THEN YES, ELSE NO	If CareAGet = Y	Appear	YES	
@CareBGet  = Question.new(:display_rules => 'always', :default_answer => 'No',                  :reference_id =>   '47',   :question_type => 'select',       :answer_choices => 'Yes, No',                          :order => 2,    :group_id => @medicare.id)
@CareBGet.name = 'CareBGet'
@CareBGet.text = 'Do you have Medicare Part B (Medical Insurance)?'
#If CareAGet = Y
@CareBGet.display_rules = "
CareAGet = manager.get_answer_by_question_name('CareAGet')
CareAGet ==  'Yes'
"
@CareBGet.save!

#48	Is Your Medicare Part B Premium Deducted from your SSDI Payment?	CareBDeduct			YES:NO		EXPRESSION: If CaidGet = Y, THEN NO, ELSE YES	If DiGet = Y AND CareBGet = Y	Appear	NO	Later we will add the question asking for the amount of the Part B premium.  For now this will remain as is in order to serve as the Spec Notebook for initial development.
@CareBDeduct  = Question.new(:display_rules => 'always', :default_answer => 'No',                  :reference_id =>   '48',   :question_type => 'select',       :answer_choices => 'Yes, No',                          :order => 3,    :group_id => @medicare.id)
@CareBDeduct.name = 'CareBDeduct'
@CareBDeduct.text = 'Is Your Medicare Part B Premium Deducted from your SSDI Payment?'
#If DiGet = Y AND CareBGet = Y
@CareBDeduct.display_rules = "
DiGet = manager.get_answer_by_question_name('DiGet')
CareBGet = manager.get_answer_by_question_name('CareBGet')
DiGet ==  'Yes' && CareBGet ==  'Yes' 
"
@CareBDeduct.save!


#49	 SPOUSE BENEFITS	Tab3_SpouseBenefitInfo						Active if any included Sub-tabs are active and as described in WW-Web Behavior.doc			
#50	Spouse SSI	SubTab3_1_SpouseSsiInfo						Active if any included questions appear and as described in WW-Web Behavior.doc			
#51	Spouse SSI: Does your spouse receive SSI?	SpouseSsiGet			YES:NO		NO	If LiveWithSpouse = Y AND (SpouseBlind = Y OR SpouseDisability = Y	Appear	YES	
@SpouseSsiGet  = Question.new(:display_rules => 'always', :default_answer => 'No',                  :reference_id =>   '51',   :question_type => 'select',       :answer_choices => 'Yes, No',                          :order => 1,    :group_id => @Spouse_SSI.id)
@SpouseSsiGet.name = 'SpouseSsiGet'
@SpouseSsiGet.text = 'Spouse SSI: Does your spouse receive SSI?'
#If LiveWithSpouse = Y AND (SpouseBlind = Y OR SpouseDisability = Y
@SpouseSsiGet.display_rules = "
LiveWithSpouse = manager.get_answer_by_question_name('LiveWithSpouse')
SpouseBlind = manager.get_answer_by_question_name('SpouseBlind')
SpouseDisability = manager.get_answer_by_question_name('SpouseDisability')
LiveWithSpouse ==  'Yes' && (SpouseBlind ==  'Yes' || SpouseDisability ==  'Yes')
"
@SpouseSsiGet.save!

#52	Spouse Medicaid	SubTab3_3_SpouseCaidInfo						Active if any included questions appear and as described in WW-Web Behavior.doc			
#53	Is your spouse currently covered by some type of Medicaid?	CaidSpouseGet			YES:NO		NO	If LiveWithSpouse = Y AND (SpouseBlind = Y OR SpouseDisability = Y	Appear	YES	
@CaidSpouseGet  = Question.new(:display_rules => 'always', :default_answer => 'No',                  :reference_id =>   '53',   :question_type => 'select',       :answer_choices => 'Yes, No',                          :order => 1,    :group_id => @Spouse_Medicaid.id)
@CaidSpouseGet.name = 'CaidSpouseGet'
@CaidSpouseGet.text = 'Is your spouse currently covered by some type of Medicaid'
#If LiveWithSpouse = Y AND (SpouseBlind = Y OR SpouseDisability = Y
@CaidSpouseGet.display_rules = "
LiveWithSpouse = manager.get_answer_by_question_name('LiveWithSpouse')
SpouseBlind = manager.get_answer_by_question_name('SpouseBlind')
SpouseDisability = manager.get_answer_by_question_name('SpouseDisability')
LiveWithSpouse == 'Yes' && (SpouseBlind ==  'Yes' || SpouseDisability ==  'Yes')
"
@CaidSpouseGet.save!

#VA_CaidSpouseGetCoveredGroup new
#VA_SpouseCaidGetCoveredGroup old 
#54	Under what Covered Group does your spouse have Medicaid Coverage?	VA_CaidSpouseGetCoveredGroup			                                                                                                        SSI Recipient:1619b: MEDICAID WORKS:  Auxiliary Grant:Adult Disabled Child: Protected SSI Disabled Child:QMB:SLMB:   QI:QDWI: 80% FPL:Waiver:   Medical Institution:Medically Needy(Spendown):Other		IF SpouseSsiGet = Y THEN SSI Recipient, ELSE 80% FPL	If CaidSpouseGet = Y	Appear	SSI Recipient	
@VA_CaidSpouseGetCoveredGroup  = Question.new(:display_rules => 'always', :default_answer => 'SSI Recipient',                  :reference_id =>   '54',   :question_type => 'select',       :answer_choices => 'SSI Recipient, 1619b, MEDICAID WORKS, Auxiliary Grant, Adult Disabled Child, Protected SSI Disabled Child, QMB, SLMB, QI, QDWI, 80% FPL, Waiver, Medical Institution, Medically Needy(Spendown), Other',                          :order => 2,    :group_id => @Spouse_Medicaid.id)
@VA_CaidSpouseGetCoveredGroup.name = 'VA_CaidSpouseGetCoveredGroup'
@VA_CaidSpouseGetCoveredGroup.text = 'Under what Covered Group does your spouse have Medicaid Coverage'
#If SpouseCaidGet = Y
@VA_CaidSpouseGetCoveredGroup.display_rules = "
CaidSpouseGet = manager.get_answer_by_question_name('CaidSpouseGet')
CaidSpouseGet ==  'Yes'
"
@VA_CaidSpouseGetCoveredGroup.save!

#old SpouseCaidApply
#New CaidSpouseApply
#55	Is your spouse currently applying for 1 some type of Medicaid?	CaidSpouseApply			YES:NO		NO	If CaidSpouseGet = N	no		The assistance unit must include the individual’s spouse with whom the individual lives when the spouse applies for Medicaid and meets the aged, blind or disabled definition in M0310, regardless of whether the spouse receives an SSI or IV-E foster care/adoption subsidy payment. [M0530.000  ABD ASSISTANCE UNIT]
@CaidSpouseApply  = Question.new(:display_rules => 'always', :default_answer => 'No',                  :reference_id =>   '55',   :question_type => 'select',       :answer_choices => 'Yes, No',                          :order => 3,    :group_id => @Spouse_Medicaid.id)
@CaidSpouseApply.name = 'CaidSpouseApply'
@CaidSpouseApply.text = 'Is your spouse currently applying for some type of Medicaid?'
#If CaidSpouseGet = n

#Bob got tired of seeing this when no spouse so he added the display rule for CaidSpouseGet 
#gender = if foo.gender == "male" then "male" else "female" end
#cost = aSong.duration > 180 ? .35 : .25

@CaidSpouseApply.display_rules = "
LiveWithSpouse = manager.get_answer_by_question_name('LiveWithSpouse')
SpouseBlind = manager.get_answer_by_question_name('SpouseBlind')
SpouseDisability = manager.get_answer_by_question_name('SpouseDisability')
CaidSpouseGet = manager.get_answer_by_question_name('CaidSpouseGet')
CaidSpouseGetVisible = (LiveWithSpouse == 'Yes' && (SpouseBlind == 'Yes' || SpouseDisability ==  'Yes')) ? 'Yes' : 'No'
CaidSpouseGetVisible == 'Yes' && CaidSpouseGet == 'No'
"
@CaidSpouseApply.save!

#VA_CaidSpouseApplyCoveredGroup now VA_CaidSpouseApplyCoveredGroup
#old                                VA_SpouseCaidApplyCoveredGroup
#56	For what Covered Group is your spouse applying for Medicaid Coverage?	VA_CaidSpouseApplyCoveredGroup			SSI Recipient:1619b:MEDICAID WORKS:Auxiliary Grant:Adult Disabled Child:Protected SSI Disabled Child:QMB:SLMB:QI:QDWI:80% FPL:Waiver:Medical Institution:Medically Needy(Spendown):Other		80% FPL	If CaidSpouseApply = Y	no		
@VA_CaidSpouseApplyCoveredGroup  = Question.new(:display_rules => 'always', :default_answer => 'SSI Recipient',                  :reference_id =>   '56',   :question_type => 'select',       :answer_choices => 'SSI Recipient, 1619b, MEDICAID WORKS, Auxiliary Grant, Adult Disabled Child, Protected SSI Disabled Child, QMB, SLMB, QI, QDWI, 80% FPL, Waiver, Medical Institution, Medically Needy(Spendown), Other',                          :order => 4,    :group_id => @Spouse_Medicaid.id)
@VA_CaidSpouseApplyCoveredGroup.name = 'VA_CaidSpouseApplyCoveredGroup'
@VA_CaidSpouseApplyCoveredGroup.text = 'For what Covered Group is your spouse applying for Medicaid Coverage?'
#If CaidSpouseApply = Y
@VA_CaidSpouseApplyCoveredGroup.display_rules = "
CaidSpouseApply = manager.get_answer_by_question_name('CaidSpouseApply')
CaidSpouseApply ==  'Yes'
"
@VA_CaidSpouseApplyCoveredGroup.save!

#57	Spouse SSDI	SubTab3_2_SpouseDiInfo						Active if any included questions appear and as described in WW-Web Behavior.doc			
#58	Spouse SSDI: Does your spouse receive SSDI?	SpouseSsdiGet			YES:NO		NO	IF SpouseSsiGet = Y OR CaidSpouseGet = Y OR CaidSpouseApply = Y	Appear	YES	If the spouse does not get SSI, then we don't ask specifically about spouse's income and expenses.  Rather we ask about deemed income and resources. Same with Medicaid.
@SpouseSsdiGet  = Question.new(:display_rules => 'always', :default_answer => 'No',                  :reference_id =>   '58',   :question_type => 'select',       :answer_choices => 'Yes, No',                          :order => 1,    :group_id => @Spouse_SSDI.id)
@SpouseSsdiGet.name = 'SpouseSsdiGet'
@SpouseSsdiGet.text = 'Spouse SSDI: Does your spouse receive SSDI?'
#IF SpouseSsiGet = Y OR CaidSpouseGet = Y OR CaidSpouseApply = Y
@SpouseSsdiGet.display_rules = "
SpouseSsiGet = manager.get_answer_by_question_name('SpouseSsiGet')
CaidSpouseGet = manager.get_answer_by_question_name('CaidSpouseGet')
CaidSpouseApply = manager.get_answer_by_question_name('CaidSpouseApply')
SpouseSsiGet ==  'Yes' || CaidSpouseGet ==  'Yes' || CaidSpouseApply ==  'Yes'
"
@SpouseSsdiGet.save!

#59	Are your spouse's SSDI benefits based on your spouse's own earnings record (Self) or on someone else's (Other)?	SpouseSsdiEarnRec			Self:Other		Self	IF SpouseSsdiGet = Y	Appear	Other	
@SpouseSsdiEarnRec  = Question.new(:display_rules => 'always', :default_answer => 'Self',                  :reference_id =>   '59',   :question_type => 'select',       :answer_choices => 'Self, Other',                          :order => 2,    :group_id => @Spouse_SSDI.id)
@SpouseSsdiEarnRec.name = 'SpouseSsdiEarnRec'
@SpouseSsdiEarnRec.text = 'Are your spouse\'s SSDI benefits based on your spouse\'s own earnings record (Self) or on someone else\'s (Other)?'
#IF SpouseSsdiGet = Y
@SpouseSsdiEarnRec.display_rules = "
SpouseSsdiGet = manager.get_answer_by_question_name('SpouseSsdiGet')
SpouseSsdiGet ==  'Yes'
"
@SpouseSsdiEarnRec.save!

#60	Do any dependents receive SSDI benefits based on your spouse's earnings record?	SpouseSsdiEarnRecDependents			YES:NO		NO	IF SpouseSsdiEarnRec = Self	no		
@SpouseSsdiEarnRecDependents  = Question.new(:display_rules => 'always', :default_answer => 'No',                  :reference_id =>   '60',   :question_type => 'select',       :answer_choices => 'Yes, No',                          :order => 3,    :group_id => @Spouse_SSDI.id)
@SpouseSsdiEarnRecDependents.name = 'SpouseSsdiEarnRecDependents'
@SpouseSsdiEarnRecDependents.text = 'Do any dependents receive SSDI benefits based on your spouse\'s earnings record?'
#IF SpouseSsdiEarnRec = Self
@SpouseSsdiEarnRecDependents.display_rules = "
SpouseSsdiEarnRec = manager.get_answer_by_question_name('SpouseSsdiEarnRec')
SpouseSsdiEarnRec ==  'Self'
"
@SpouseSsdiEarnRecDependents.save!

#60.5	Is your spouse a Disabled Adult Child according to SSA?	SpouseSsdiDac			YES:NO		NO	If SpouseSsdiEarnRec = Other	Appear	YES	Include this question because DAC's lose SSI-related  Medicaid because of unearned income only if they do so after subtracting SSDI payment from unearned income.
@SpouseSsdiDac  = Question.new(:display_rules => 'always', :default_answer => 'No',                  :reference_id =>   '60.5',   :question_type => 'select',       :answer_choices => 'Yes, No',                          :order => 4,    :group_id => @Spouse_SSDI.id)
@SpouseSsdiDac.name = 'SpouseSsdiDac'
@SpouseSsdiDac.text = 'Is your spouse a Disabled Adult Child according to SSA?'
#If SpouseSsdiEarnRec = Other
@SpouseSsdiDac.display_rules = "
SpouseSsdiGet = manager.get_answer_by_question_name('SpouseSsdiGet')
SpouseSsdiEarnRec = manager.get_answer_by_question_name('SpouseSsdiEarnRec')
SpouseSsdiGet == 'Yes' && SpouseSsdiEarnRec ==  'Other'
"
@SpouseSsdiDac.save!

#25	61	What is the onset date of your spouse's blindness according to SSA? 	SpouseBlindOnsetDate			MM/DD/YEAR or Calendar Popup	Click on the Calendar Icon to the right of the question or enter the Month/Day/Year, for example enter 01/21/1990 for January 21st, 1990. 	1/1/1950	If SpouseSsdiGet = Y AND SpouseBlind = Y AND (SitDate - SpouseBirthDate => 55 yrs AND < 65 yrs)	#NAME?		
@SpouseBlindOnsetDate  = Question.new(:display_rules => 'always', :default_answer => 'Current Date',                  :reference_id =>   '5',   :question_type => 'date_time',    :answer_choices => '',                          :order => 5,    :group_id => @Spouse_SSDI.id)
@SpouseBlindOnsetDate.name = 'SpouseBlindOnsetDate'
@SpouseBlindOnsetDate.text = 'What is the onset date of your spouse\'s blindness according to SSA?'
#If SpouseSsdiGet = Y AND SpouseBlind = Y AND (SitDate - SpouseBirthDate => 55 yrs AND < 65 yrs)  
@SpouseBlindOnsetDate.display_rules = "
unless manager.get_answer_by_question_name('SitDate').blank? || manager.get_answer_by_question_name('SpouseBirthDate').blank?
  SpouseSsdiGet = manager.get_answer_by_question_name('SpouseSsdiGet')
  SpouseBlind = manager.get_answer_by_question_name('SpouseBlind')
  #SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
  #SpouseBirthDate = Date.strptime(manager.get_answer_by_question_name('SpouseBirthDate'), '%m/%d/%Y')
  SpouseAge = 20 # WebCalc.find_by_name('RSpouseAge')
    
  SpouseAge > 54 && SpouseAge < 65 && SpouseBlind == 'Yes' && SpouseSsdiGet == 'Yes'
  else
  false
end
"
@SpouseBlindOnsetDate.save!

#25	62	Are your spouse's work skills and abilities different now than before age 55?	SpouseBlindSkillsBefore55			YES:NO		NO	If SpouseSsdiGet = Y AND SpouseBlind = Y AND (SitDate - SpouseBirthDate => 55 AND < 65) AND (SpouseBlindOnsetDate - SpouseBirthDate <= 55 yrs)	no		BOB, note that the first term in the excel formula prevents a #NUM error and has nothing to do with the actual appearance rule.
@SpouseBlindSkillsBefore55  = Question.new(:display_rules => 'always', :default_answer => 'No',                  :reference_id =>   '62',   :question_type => 'select',       :answer_choices => 'Yes, No',                          :order => 6,    :group_id => @Spouse_SSDI.id)
@SpouseBlindSkillsBefore55.name = 'SpouseBlindSkillsBefore55'
@SpouseBlindSkillsBefore55.text = 'Are your spouse\'s work skills and abilities different now than before age 55?'
#If DiGet = Y          AND Blind = Y      AND (SitDate -       BirthDate > 54 AND < 65) AND        (BlindOnsetDate - BirthDate <= 55 yrs)	  
#If SpouseSsdiGet = Y AND SpouseBlind = Y AND (SitDate - SpouseBirthDate => 55 AND < 65) AND (SpouseBlindOnsetDate - SpouseBirthDate <= 55 yrs)
@SpouseBlindSkillsBefore55.display_rules = "
unless manager.get_answer_by_question_name('SitDate').blank? || manager.get_answer_by_question_name('SpouseBirthDate').blank? || manager.get_answer_by_question_name('SpouseBlindOnsetDate').blank? 
  SpouseSsdiGet = manager.get_answer_by_question_name('SpouseSsdiGet')
  SpouseBlind = manager.get_answer_by_question_name('SpouseBlind')
  SpouseBirthDate = Date.strptime(manager.get_answer_by_question_name('SpouseBirthDate'), '%m/%d/%Y')
  SpouseBlindOnsetDate = Date.strptime(manager.get_answer_by_question_name('SpouseBlindOnsetDate'), '%m/%d/%Y')
  SpouseAge = 20 # WebCalc.find_by_name('RSpouseAge')
  subyear = 0
  
  SpouseOnsetAge = (SpouseBlindOnsetDate.year - SpouseBirthDate.year)
  subyear= 0
  if SpouseBirthDate.month > SpouseBlindOnsetDate.month then
    subyear = 1
  elsif SpouseBirthDate.month == SpouseBlindOnsetDate.month then
    if SpouseBirthDate.day > SpouseBlindOnsetDate.day  then
      subyear = 1
    end
  end
  SpouseOnsetAge = SpouseOnsetAge - subyear
    
  SpouseAge > 54 && SpouseAge < 65 && SpouseOnsetAge <= 55 && SpouseBlind == 'Yes' && SpouseSsdiGet == 'Yes'
  
else
  false
end
"
@SpouseBlindSkillsBefore55.save!

#25	63	Are your spouse's work skills and abilities different now than before the onset of blindness?	SpouseBlindSkillsBeforeOnset			YES:NO		NO	If SpouseSsdiGet = Y AND SpouseBlind = Y AND (SitDate - SpouseBirthDate => 55 AND < 65) AND (SpouseBlindOnsetDate - SpouseBirthDate > 55 yrs)	no		BOB, note that the first term in the excel formula prevents a #NUM error when "no' should show and has nothing to do with the actual appearance rule.
@SpouseBlindSkillsBeforeOnset  = Question.new(:display_rules => 'always', :default_answer => 'No',                  :reference_id =>   '63',   :question_type => 'select',       :answer_choices => 'Yes, No',                          :order => 7,    :group_id => @Spouse_SSDI.id)
@SpouseBlindSkillsBeforeOnset.name = 'SpouseBlindSkillsBeforeOnset'
@SpouseBlindSkillsBeforeOnset.text = 'Are your spouse\'s work skills and abilities different now than before the onset of blindness?'
#If SpouseSsdiGet = Y AND SpouseBlind = Y AND (SitDate - SpouseBirthDate => 55 AND < 65) AND (SpouseBlindOnsetDate - SpouseBirthDate > 55 yrs)
@SpouseBlindSkillsBeforeOnset.display_rules = "
unless manager.get_answer_by_question_name('SitDate').blank? || manager.get_answer_by_question_name('SpouseBirthDate').blank? || manager.get_answer_by_question_name('SpouseBlindOnsetDate').blank? 
  SpouseSsdiGet = manager.get_answer_by_question_name('SpouseSsdiGet')
  SpouseBlind = manager.get_answer_by_question_name('SpouseBlind')
  SpouseBirthDate = Date.strptime(manager.get_answer_by_question_name('SpouseBirthDate'), '%m/%d/%Y')
  SpouseBlindOnsetDate = Date.strptime(manager.get_answer_by_question_name('SpouseBlindOnsetDate'), '%m/%d/%Y')
  SpouseAge = 20 # WebCalc.find_by_name('RSpouseAge')
    
  SpouseOnsetAge = (SpouseBlindOnsetDate.year - SpouseBirthDate.year)
  subyear= 0
  if SpouseBirthDate.month > SpouseBlindOnsetDate.month then
    subyear = 1
  elsif SpouseBirthDate.month == SpouseBlindOnsetDate.month then
    if SpouseBirthDate.day > SpouseBlindOnsetDate.day  then
      subyear = 1
    end
  end
  SpouseOnsetAge = SpouseOnsetAge - subyear
    
  SpouseAge > 54 && SpouseAge < 65 && SpouseOnsetAge > 55 && SpouseBlind == 'Yes' && SpouseSsdiGet == 'Yes'
  
else
  false
end
"
@SpouseBlindSkillsBeforeOnset.save!

#25	64	Spouse Medicare	SubTab3_4_SpouseCareInfo						Active if any included questions appear and as described in WW-Web Behavior.doc			
#25	65	Does your spouse have Medicare Part A (Hospitalization Insurance)?	SpouseCareAGet			YES:NO		EXPRESSION: If SpouseSsdiGet = Y, THEN YES, ELSE NO	If LiveWithSpouse = Y	Appear	YES	
#10/18/2010 edit display rule
#IF SpouseSsiGet = Y OR CaidSpouseGet = Y OR CaidSpouseApply = Y

@SpouseCareAGet  = Question.new(:display_rules => 'always', :default_answer => 'No',                  :reference_id =>   '65',   :question_type => 'select',       :answer_choices => 'Yes, No',                          :order => 1,    :group_id => @Spouse_Medicare.id)
@SpouseCareAGet.name = 'SpouseCareAGet'
@SpouseCareAGet.text = 'Does your spouse have Medicare Part A (Hospitalization Insurance)?'
#If LiveWithSpouse = Y   :ASK DR about this one, seems too simple : the other part a display rule If SsiGet = Y OR DiGet = Y OR CaidGet = Y OR CaidApply = Y
##IF SpouseSsiGet = Y OR CaidSpouseGet = Y OR CaidSpouseApply = Y Revised on 10/18/2010
@SpouseCareAGet.display_rules = "
SpouseSsiGet = manager.get_answer_by_question_name('SpouseSsiGet')
CaidSpouseGet = manager.get_answer_by_question_name('CaidSpouseGet')
CaidSpouseApply= manager.get_answer_by_question_name('CaidSpouseApply')
(SpouseSsiGet == 'Yes' || CaidSpouseGet == 'Yes' || CaidSpouseApply == 'Yes') 
"
@SpouseCareAGet.save!

#25	66	Does your spouse have Medicare Part B (Medical Insurance)?	SpouseCareBGet			YES:NO		EXPRESSION: If SpouseSsdiGet = Y, THEN YES, ELSE NO	If SpouseCareAGet = Y	Appear	YES
@SpouseCareBGet  = Question.new(:display_rules => 'always', :default_answer => 'No',                  :reference_id =>   '66',   :question_type => 'select',       :answer_choices => 'Yes, No',                          :order => 2,    :group_id => @Spouse_Medicare.id)
@SpouseCareBGet.name = 'SpouseCareBGet'
@SpouseCareBGet.text = 'Does your spouse have Medicare Part B (Medical Insurance)?'
#If SpouseCareAGet = Y
@SpouseCareBGet.display_rules = "
SpouseCareAGet = manager.get_answer_by_question_name('SpouseCareAGet')
SpouseCareAGet ==  'Yes'
"
@SpouseCareBGet.save!


#25	67	Is your spouse's Medicare Part B Premium Deducted from your spouse's SSDI Payment?	SpouseCareBDeduct			YES:NO		EXPRESSION: If CaidSpouseGet = Y, THEN NO, ELSE YES	IF SpouseSsdiGet AND SpouseCareBGet = Y	Appear	NO	
@SpouseCareBDeduct  = Question.new(:display_rules => 'always', :default_answer => 'No',                  :reference_id =>   '67',   :question_type => 'select',       :answer_choices => 'Yes, No',                          :order => 3,    :group_id => @Spouse_Medicare.id)
@SpouseCareBDeduct.name = 'SpouseCareBDeduct'
@SpouseCareBDeduct.text = 'Is your spouse\'s Medicare Part B Premium Deducted from your spouse\'s SSDI Payment?'
# IF SpouseSsdiGet AND SpouseCareBGet = Y
@SpouseCareBDeduct.display_rules = "
SpouseSsdiGet = manager.get_answer_by_question_name('SpouseSsdiGet')
SpouseCareBGet = manager.get_answer_by_question_name('SpouseCareBGet')
SpouseSsdiGet == 'Yes' && SpouseCareBGet = 'Yes'
"
@SpouseCareBDeduct.save!


#25 68	INCOME & RESOURCES	Tab4_IncomeResource						Active if any included Sub-tabs are active and as described in WW-Web Behavior.doc			
#25 69	Deeming	SubTab4_1_Deeming						Active if any included questions appear and as described in WW-Web Behavior.doc			
#SsiParDeemAmt nwe name on 10/18/2010 along with many other name changes too many to document
#25	70	How much of your parents' monthly income is deemed to you for SSI purposes?	SsiParDeemAmt			Zero or Positive Number 	Enter numbers only.  Do not enter $ or decimal point.	0.00	 If SsiGet = Y AND LiveWithParents = Y	#NAME?		NOTE: IF FAMILY HAS ONE PARENT ON SSI AND SPOUSAL DEEMING THEN A SPECIAL RULE APPLIES: SI 01320.650 Deeming of Income from an Ineligible Spouse to an Eligible Individual and Eligible Child
@SsiParDeemAmt  = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '70',   :question_type => 'text_field',       :answer_choices => '',                          :order => 1,    :group_id => @Deeming.id)
@SsiParDeemAmt.name = 'SsiParDeemAmt'
@SsiParDeemAmt.text = 'How much of your parents\' monthly income is deemed to you for SSI purposes?'
# If SsiGet = Y AND LiveWithParents = Y AND SitDate - BirthDate < 18
#NOTE THIS NEED BIRTHDATE added when we figure out how to reference calc.
@SsiParDeemAmt.display_rules = "
SsiGet = manager.get_answer_by_question_name('SsiGet')
LiveWithParents = manager.get_answer_by_question_name('LiveWithParents')
LiveWithParents == 'Yes' && SsiGet == 'Yes'
"
@SsiParDeemAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
if answer != nil then
    true if (Float(answer) >= 0) rescue false
  else 
    true
end
"
@SsiParDeemAmt.validation_message = "Enter positive numbers only.  Do not enter $." 

@SsiParDeemAmt.save!

#VA_CaidParDeemAmt
#25	72	How much of your parents' monthly income is deemed to you for Medicaid purposes?	VA_CaidParDeemAmt			Zero or Positive Number  	Enter numbers only.  Do not enter $ or decimal point.	0.00	 If (CaidGet = Y OR CaidApply = Y) AND LiveWithParents = Y	#NAME?		
@VA_CaidParDeemAmt  = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '70',   :question_type => 'text_field',       :answer_choices => '',                          :order => 2,    :group_id => @Deeming.id)
@VA_CaidParDeemAmt.name = 'VA_CaidParDeemAmt'
@VA_CaidParDeemAmt.text = 'How much of your parents\' monthly income is deemed to you for Medicaid purposes?'
#If (CaidGet = Y OR CaidApply = Y) AND LiveWithParents = Y
@VA_CaidParDeemAmt.display_rules = "
CaidGet = manager.get_answer_by_question_name('CaidGet')
CaidApply = manager.get_answer_by_question_name('CaidApply')
LiveWithParents = manager.get_answer_by_question_name('LiveWithParents')
(CaidGet == 'Yes' || CaidApply == 'Yes') && LiveWithParents == 'Yes'
"
@VA_CaidParDeemAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
if answer != nil then
    true if (Float(answer) >= 0) rescue false
  else 
    true
end
"
@VA_CaidParDeemAmt.validation_message = "Enter positive numbers only.  Do not enter $."
@VA_CaidParDeemAmt.save!

#VA_CaidCoupleParDeemAmt
#25	73	How much parental monthly income is deemed to you and your spouse for Medicaid purposes?	VA_CaidCoupleParDeemAmt			Zero or Positive Number  	Enter numbers only.  Do not enter $ or decimal point.	0.00	 If (CaidGet = Y OR CaidApply = Y) AND (CaidSpouseGet = Y OR CaidSpouseApply = Y) AND (VA_CaidLiveWithSpouseAndOwnParents = Y OR  VA_CaidLiveWithSpouseAndSpouseParents = Y)	no		
@VA_CaidCoupleParDeemAmt  = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '73',   :question_type => 'text_field',       :answer_choices => '',                          :order => 3,    :group_id => @Deeming.id)
@VA_CaidCoupleParDeemAmt.name = 'VA_CaidCoupleParDeemAmt'
@VA_CaidCoupleParDeemAmt.text = 'How much parental monthly income is deemed to you and your spouse for Medicaid purposes?'
#If (CaidGet = Y OR CaidApply = Y) AND (CaidSpouseGet = Y OR CaidSpouseApply = Y) AND (VA_CaidLiveWithSpouseAndOwnParents = Y OR  VA_CaidLiveWithSpouseAndSpouseParents = Y)
@VA_CaidCoupleParDeemAmt.display_rules = "
CaidGet = manager.get_answer_by_question_name('CaidGet')
CaidApply = manager.get_answer_by_question_name('CaidApply')
CaidSpouseGet = manager.get_answer_by_question_name('CaidSpouseGet')
CaidSpouseApply = manager.get_answer_by_question_name('CaidSpouseApply')
VA_CaidLiveWithSpouseAndOwnParents = manager.get_answer_by_question_name('VA_CaidLiveWithSpouseAndOwnParents')
VA_CaidLiveWithSpouseAndSpouseParents = manager.get_answer_by_question_name('VA_CaidLiveWithSpouseAndSpouseParents')
(CaidGet == 'Yes' || CaidApply == 'Yes') && (CaidSpouseGet == 'Yes' || CaidSpouseApply == 'Yes') && (VA_CaidLiveWithSpouseAndOwnParents == 'Yes' || VA_CaidLiveWithSpouseAndSpouseParents == 'Yes')
"
@VA_CaidCoupleParDeemAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
if answer != nil then
    true if (Float(answer) >= 0) rescue false
  else 
    true
end
"
@VA_CaidCoupleParDeemAmt.validation_message = "Enter positive numbers only.  Do not enter $."
@VA_CaidCoupleParDeemAmt.save!

#29	73.5	Are any of your spouse's income or resources deemed to you for SSI purposes?	SsiSpouseDeem			YES:NO		NO	IF SsiGet = Y AND LiveWithSpouse = Y AND SpouseSsiGet = N
@SsiSpouseDeem  = Question.new(:display_rules => 'always', :default_answer => 'No',                  :reference_id =>   '73.5',   :question_type => 'select',       :answer_choices => 'Yes, No',                          :order => 4,    :group_id => @Deeming.id)
@SsiSpouseDeem.name = 'SsiSpouseDeem'
@SsiSpouseDeem.text = 'Are any of your spouse\'s income or resources deemed to you for SSI purposes?'
#IF SsiGet = Y AND LiveWithSpouse = Y AND SpouseSsiGet = N
#IF SsiGet = Y AND LiveWithSpouse = Y AND SpouseSsiGet = <> Y
#If (SpouseSsiGet = Y OR VA_CaidSpouseGetCoveredGroup =  1619b) AND (SpouseSsiOrCaidEarnAmt  > VA_RateSsiCaidMonthlyThresholdAmt)

@SsiSpouseDeem.display_rules = "
SsiGet = manager.get_answer_by_question_name('SsiGet')
LiveWithSpouse = manager.get_answer_by_question_name('LiveWithSpouse')
SpouseSsiGet = manager.get_answer_by_question_name('SpouseSsiGet')
(SsiGet == 'Yes' && LiveWithSpouse == 'Yes'  && SpouseSsiGet != 'Yes')
"
@SsiSpouseDeem.save!

#SsiSpouseDeemUnearnAmt

#25	74	How much of your spouse's monthly unearned income is deemed to you for SSI purposes?	SsiSpouseDeemUnearnAmt			Zero or Positive Number  	Enter numbers only.  Do not enter $ or decimal point.	0.00	IF SsiGet = Y AND SpouseSsiGet = N	no	
@SsiSpouseDeemUnearnAmt  = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '74',   :question_type => 'text_field',       :answer_choices => '',                          :order => 5,    :group_id => @Deeming.id)
@SsiSpouseDeemUnearnAmt.name = 'SsiSpouseDeemUnearnAmt'
@SsiSpouseDeemUnearnAmt.text = 'How much of your spouse\'s monthly unearned income is deemed to you for SSI purposes?' 
#IF SsiGet = Y AND SpouseSsiGet = N
# review Display rule for 74 on 10/20/2010
#IF SsiSpouseDeem = Y

@SsiSpouseDeemUnearnAmt.display_rules = "
SsiSpouseDeem = manager.get_answer_by_question_name('SsiSpouseDeem')
(SsiSpouseDeem == 'Yes')
"
@SsiSpouseDeemUnearnAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
if answer != nil then
    true if (Float(answer) >= 0) rescue false
  else 
    true
end
"
@SsiSpouseDeemUnearnAmt.validation_message = "Enter positive numbers only.  Do not enter $."
@SsiSpouseDeemUnearnAmt.save!


#Question added on 10/18/2010
#29	74.5	Is any of your spouse's income deemed to you for Medicaid purposes?	VA_CaidSpouseDeem			YES:NO		NO	IF (CaidGet = Y OR CaidApply = Y) AND ((SpouseBlind = N AND SpouseDisability = N AND SitDate - SpouseBirthDate < 65 yrs) OR (CaidSpouseGet = N AND CaidSpouseApply = N))
@VA_CaidSpouseDeem  = Question.new(:display_rules => 'always', :default_answer => 'No',                  :reference_id =>   '73.5',   :question_type => 'select',       :answer_choices => 'Yes, No',                          :order => 4,    :group_id => @Deeming.id)
@VA_CaidSpouseDeem.name = 'VA_CaidSpouseDeem'
@VA_CaidSpouseDeem.text = 'Is any of your spouse\'s income deemed to you for Medicaid purposes?'
#IF (CaidGet = Y OR CaidApply = Y) AND ((SpouseBlind = N AND SpouseDisability = N AND SitDate - SpouseBirthDate < 65 yrs) OR (CaidSpouseGet = N AND CaidSpouseApply = N))
#IF 1( CaidGet = Y OR CaidApply = Y 1) AND 2(3( SpouseBlind = N AND SpouseDisability = N AND SitDate - SpouseBirthDate < 65 yrs3) OR 4(CaidSpouseGet = N AND CaidSpouseApply = N4)2)

@VA_CaidSpouseDeem.display_rules = "
CaidGet = manager.get_answer_by_question_name('CaidGet')
CaidApply = manager.get_answer_by_question_name('CaidApply')
SpouseBlind = manager.get_answer_by_question_name('SpouseBlind')
SpouseDisability = manager.get_answer_by_question_name('SpouseDisability')
SpouseAge = 64
CaidSpouseGet = manager.get_answer_by_question_name('CaidSpouseGet')
CaidSpouseApply = manager.get_answer_by_question_name('CaidSpouseApply')
(CaidGet  == 'Yes' || CaidApply  == 'Yes') && ((SpouseBlind  == 'No' && SpouseDisability  == 'No' && SpouseAge < 65) || (CaidSpouseGet  == 'No' && CaidSpouseApply  == 'No'))
"
@VA_CaidSpouseDeem.save!
#this quest display rule still needs testing

# new VA_CaidSpouseDeemUnearnAmt
#25	75	How much of your spouse's monthly unearned income is deemed to you for Medicaid purposes?	VA_CaidSpouseDeemUnearnAmt			Zero or Positive Number  	Enter numbers only.  Do not enter $ or decimal point.	0.00	IF (CaidGet = Y OR CaidApply = Y) AND ((SpouseBlind = N AND SpouseDisability = N AND SitDate - SpouseBirthDate < 65 yrs) OR (CaidSpouseGet = N AND VA_CaidSpouseGetCoveredGroup = N))	#NAME?
#This needs to be chagned based on Wkbk 29 
@VA_CaidSpouseDeemUnearnAmt  = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '75',   :question_type => 'text_field',       :answer_choices => '',                          :order => 6,    :group_id => @Deeming.id)
@VA_CaidSpouseDeemUnearnAmt.name = 'VA_CaidSpouseDeemUnearnAmt'
@VA_CaidSpouseDeemUnearnAmt.text = 'How much of your spouse\'s monthly unearned income is deemed to you for Medicaid purposes?'
#IF (CaidGet = Y OR CaidApply = Y) AND 
#((SpouseBlind = N AND SpouseDisability = N AND SitDate - SpouseBirthDate < 65 yrs) 
# OR (CaidSpouseGet = N AND VA_CaidSpouseGetCoveredGroup = N))
#Review new display rule
#IF VA_CaidSpouseDeem = Y

@VA_CaidSpouseDeemUnearnAmt.display_rules = "
VA_CaidSpouseDeem = manager.get_answer_by_question_name('VA_CaidSpouseDeem')
(VA_CaidSpouseDeem == 'Yes')
"
@VA_CaidSpouseDeemUnearnAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
if answer != nil then
    true if (Float(answer) >= 0) rescue false
  else 
    true
end
"
@VA_CaidSpouseDeemUnearnAmt.validation_message = "Enter positive numbers only.  Do not enter $."
@VA_CaidSpouseDeemUnearnAmt.save!


#new SsiSpouseDeemEarnAmt
 
#25	76	How much of your spouse's monthly earned income is deemed to you for SSI purposes?	SsiSpouseDeemEarnAmt			Zero or Positive Number 	Enter numbers only.  Do not enter $ or decimal point.	0.00	IF SsiGet = Y AND SpouseSsiGet = N	no
#Note bob changed this one to add SsiGet == 'Yes' && SpouseBlind == 'No' && SpouseDisability == 'No') to display rules to get desired behavior
@SsiSpouseDeemEarnAmt  = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '76',   :question_type => 'text_field',       :answer_choices => '',                          :order => 7,    :group_id => @Deeming.id)
@SsiSpouseDeemEarnAmt.name = 'SsiSpouseDeemEarnAmt'
@SsiSpouseDeemEarnAmt.text = 'How much of your spouse\'s monthly earned income is deemed to you for SSI purposes?'
#IF SsiGet = Y AND SpouseSsiGet = N  IF SsiGet = Y AND SpouseSsiGet = N
# review display rule on 10/20/2010
#IF SsiSpouseDeem = Y

@SsiSpouseDeemEarnAmt.display_rules = "
SsiSpouseDeem = manager.get_answer_by_question_name('SsiSpouseDeem')
SsiSpouseDeem == 'Yes'
"
@SsiSpouseDeemEarnAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
if answer != nil then
    true if (Float(answer) >= 0) rescue false
  else 
    true
end
"
@SsiSpouseDeemEarnAmt.validation_message = "Enter positive numbers only.  Do not enter $."

@SsiSpouseDeemEarnAmt.save!

#new VA_CaidSpouseDeemEarnAmt name chagned on 10/19/2010
#25	77	How much of your spouse's monthly earned income is deemed to you for Medicaid purposes?	VA_CaidSpouseDeemEarnAmt			Zero or Positive Number 	Enter numbers only.  Do not enter $ or decimal point.	0.00	IF (CaidGet = Y OR CaidApply = Y) AND ((SpouseBlind = N AND SpouseDisability = N AND SitDate - SpouseBirthDate < 65 yrs) OR (CaidSpouseGet = N AND CaidSpouseApply = N))	#NAME?
@VA_CaidSpouseDeemEarnAmt  = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '75',   :question_type => 'text_field',       :answer_choices => '',                          :order => 8,    :group_id => @Deeming.id)
@VA_CaidSpouseDeemEarnAmt.name = 'VA_CaidSpouseDeemEarnAmt'
@VA_CaidSpouseDeemEarnAmt.text = 'How much of your spouse\'s monthly earned income is deemed to you for Medicaid purposes?'
#IF (CaidGet = Y OR CaidApply = Y) AND 
#((SpouseBlind = N AND SpouseDisability = N AND SitDate - SpouseBirthDate < 65 yrs) 
# OR (CaidSpouseGet = N AND VA_CaidSpouseGetCoveredGroup = N))

#IF (CaidGet = Y OR CaidApply = Y) AND 
#((SpouseBlind = N AND SpouseDisability = N AND SitDate - SpouseBirthDate < 65 yrs) 
#OR (CaidSpouseGet = N AND CaidSpouseApply = N))
#10/20/2011 Display rule edit based on 29
#IF VA_CaidSpouseDeem = Y

@VA_CaidSpouseDeemEarnAmt.display_rules = "
VA_CaidSpouseDeem = manager.get_answer_by_question_name('VA_CaidSpouseDeem')
VA_CaidSpouseDeem == 'Yes'
"
@VA_CaidSpouseDeemEarnAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
if answer != nil then
    true if (Float(answer) >= 0) rescue false
  else 
    true
end
"
@VA_CaidSpouseDeemEarnAmt.validation_message = "Enter positive numbers only.  Do not enter $."
@VA_CaidSpouseDeemEarnAmt.save!

#25	78	Resources	SubTab4_2_Resources						Active if any included questions appear and as described in WW-Web Behavior.doc	
#25	79	Do you have countable resources (for SSI purposes) that exceed the $2000 resource limit? (Do not count resources included in a PASS)	SsiResourceLimitExceed			YES:NO		NO	If SsiGet = Y AND SpouseSsiGet <> Y AND SsiSpouseDeemUnearnAmt + SsiSpouseDeemEarnAmt NOT> 0
@SsiResourceLimitExceed  = Question.new(:display_rules => 'always', :default_answer => 'No',                  :reference_id =>   '79',   :question_type => 'select',       :answer_choices => 'Yes, No',                          :order => 1,    :group_id => @Resources.id)
@SsiResourceLimitExceed.name = 'SsiResourceLimitExceed'
@SsiResourceLimitExceed.text = 'Do you have countable resources (for SSI purposes) that exceed the $2000 resource limit? (Do not count resources included in a PASS)?'
#If SsiGet = Y AND SpouseSsiGet <> Y AND SsiSpouseDeemUnearnAmt + SsiSpouseDeemEarnAmt NOT> 0

#10/27 revision test based on YC's to float recommendation
### YC: whenever trying to use an input as a float use the '.to_f' method (eg: "0".to_f => 0, "".to_f => 0, nil.to_f => 0, "1.0".to_f => 1,0, etc)

@SsiResourceLimitExceed.display_rules = "
SsiGet = manager.get_answer_by_question_name('SsiGet')
SpouseSsiGet = manager.get_answer_by_question_name('SpouseSsiGet')
SsiSpouseDeemUnearnAmt = (manager.get_answer_by_question_name('SsiSpouseDeemUnearnAmt')).to_f
SsiSpouseDeemEarnAmt = manager.get_answer_by_question_name('SsiSpouseDeemEarnAmt').to_f
#if SsiSpouseDeemUnearnAmt != nil then
#  SsiSpouseDeemUnearnAmt = Float(SsiSpouseDeemUnearnAmt)
#else
#  SsiSpouseDeemUnearnAmt = 0
#end
#if SsiSpouseDeemEarnAmt != nil then
#  SsiSpouseDeemEarnAmt = Float(SsiSpouseDeemEarnAmt)
#else 
#  SsiSpouseDeemEarnAmt = 0
#end
SsiGet == 'Yes' && !(SpouseSsiGet == 'Yes') && !(SsiSpouseDeemUnearnAmt + SsiSpouseDeemEarnAmt > 0) 
"
@SsiResourceLimitExceed.save!

#25	80	Do you and your spouse have countable resources (for SSI purposes) that exceed the $3000 resource limit? (Do not count resources included in a PASS)	
# SsiCoupleResourceLimitExceed			YES:NO		NO	If SsiGet = Y AND (SpouseSsiGet = Y OR SsiSpouseDeemUnearnAmt + SsiSpouseDeemEarnAmt > 0)	Appear
@SsiCoupleResourceLimitExceed  = Question.new(:display_rules => 'always', :default_answer => 'No',                  :reference_id =>   '80',   :question_type => 'select',       :answer_choices => 'Yes, No',                          :order => 2,    :group_id => @Resources.id)
@SsiCoupleResourceLimitExceed.name = 'SsiCoupleResourceLimitExceed'
@SsiCoupleResourceLimitExceed.text = 'Do you and your spouse have countable resources (for SSI purposes) that exceed the $3000 resource limit? (Do not count resources included in a PASS)'
#If SsiGet = Y AND (SpouseSsiGet = Y OR SsiSpouseDeemUnearnAmt + SsiSpouseDeemEarnAmt > 0)

@SsiCoupleResourceLimitExceed.display_rules = "
SsiGet = manager.get_answer_by_question_name('SsiGet')
SpouseSsiGet = manager.get_answer_by_question_name('SpouseSsiGet')
SsiSpouseDeemUnearnAmt = manager.get_answer_by_question_name('SsiSpouseDeemUnearnAmt').to_f
SsiSpouseDeemEarnAmt = manager.get_answer_by_question_name('SsiSpouseDeemEarnAmt').to_f
#if SsiSpouseDeemUnearnAmt != nil then
#  SsiSpouseDeemUnearnAmt = Float(SsiSpouseDeemUnearnAmt)
#else
#  SsiSpouseDeemUnearnAmt = 0
#end
#if SsiSpouseDeemEarnAmt != nil then
#  SsiSpouseDeemEarnAmt = Float(SsiSpouseDeemEarnAmt)
#else
#  SsiSpouseDeemEarnAmt = 0
#end
SsiGet == 'Yes' && (SpouseSsiGet == 'Yes' || (SsiSpouseDeemUnearnAmt + SsiSpouseDeemEarnAmt > 0))
"
@SsiCoupleResourceLimitExceed.save!


#26	81	Do you have countable resources (for Medicaid purposes) that exceed the $2000 resource limit? (Include any deemed resources.)	
#CaidResourceLimitExceed			YES:NO		NO	
#If (CaidGet = Y OR CaidApply = Y) AND (CaidSpouseGet <> Y AND CaidSpouseApply <> Y AND (VA_CaidSpouseDeemUnearnAmt + VA_CaidSpouseDeemEarnAmt) NOT> 0)	
@CaidResourceLimitExceed  = Question.new(:display_rules => 'always', :default_answer => 'No',                  :reference_id =>   '81',   :question_type => 'select',       :answer_choices => 'Yes, No',                          :order => 3,    :group_id => @Resources.id)
@CaidResourceLimitExceed.name = 'CaidResourceLimitExceed'
@CaidResourceLimitExceed.text = 'Do you have countable resources (for Medicaid purposes) that exceed the $2000 resource limit? (Include any deemed resources.)'
#If (CaidGet = Y OR CaidApply = Y) AND (CaidSpouseGet <> Y AND CaidSpouseApply <> Y AND (VA_CaidSpouseDeemUnearnAmt + VA_CaidSpouseDeemEarnAmt) NOT> 0)	
#=IF(AND(OR(L34="YES";L36="YES");L56<>"YES";L58<>"YES";NOT(L79+L81>0));"Appear";"no")

#Display rule 10/19/2011 review
#If (CaidGet = Y OR CaidApply = Y) AND LiveWithSpouse = N
@CaidResourceLimitExceed.display_rules = "
CaidGet = manager.get_answer_by_question_name('CaidGet')
CaidApply = manager.get_answer_by_question_name('CaidApply')
LiveWithSpouse = manager.get_answer_by_question_name('LiveWithSpouse')
(CaidGet == 'Yes' || CaidApply == 'Yes')  && LiveWithSpouse == 'No' 
"
@CaidResourceLimitExceed.save!

#26	82	Do you and your spouse have countable resources (for Medicaid purposes) that exceed the $3000 resource limit? (Include any deemed resources.)	
#CaidCoupleResourceLimitExceed			YES:NO		NO	
#If (CaidGet = Y OR CaidApply = Y) AND ((CaidSpouseGet = Y OR CaidSpouseApply = Y) OR (VA_CaidSpouseDeemUnearnAmt + VA_CaidSpouseDeemEarnAmt) > 0)	Appear
@CaidCoupleResourceLimitExceed  = Question.new(:display_rules => 'always', :default_answer => 'No',                  :reference_id =>   '82',   :question_type => 'select',       :answer_choices => 'Yes, No',                          :order => 4,    :group_id => @Resources.id)
@CaidCoupleResourceLimitExceed.name = 'CaidCoupleResourceLimitExceed'
@CaidCoupleResourceLimitExceed.text = 'Do you and your spouse have countable resources (for Medicaid purposes) that exceed the $3000 resource limit? (Include any deemed resources.)	'
#If (CaidGet = Y OR CaidApply = Y) AND (CaidSpouseGet <> Y AND CaidSpouseApply <> Y AND (VA_CaidSpouseDeemUnearnAmt + VA_CaidSpouseDeemEarnAmt) NOT> 0)	
#=IF(AND(OR(L34="YES";L36="YES");L56<>"YES";L58<>"YES";NOT(L79+L81>0));"Appear";"no")

#If (CaidGet = Y OR CaidApply = Y) AND ((CaidSpouseGet = Y OR CaidSpouseApply = Y) OR (VA_CaidSpouseDeemUnearnAmt + VA_CaidSpouseDeemEarnAmt) > 0)
#Revised Display rule 10/19/2011
#If (CaidGet = Y OR CaidApply = Y OR CaidSpouseGet = Y OR CaidSpouseApply = Y) AND LiveWithSpouse = Y
 
@CaidCoupleResourceLimitExceed.display_rules = "
CaidGet = manager.get_answer_by_question_name('CaidGet')
CaidApply = manager.get_answer_by_question_name('CaidApply')
CaidSpouseGet = manager.get_answer_by_question_name('CaidSpouseGet')
CaidSpouseApply = manager.get_answer_by_question_name('CaidSpouseApply')
LiveWithSpouse = manager.get_answer_by_question_name('LiveWithSpouse')
(CaidGet == 'Yes' || CaidApply == 'Yes' || CaidSpouseGet == 'Yes') && LiveWithSpouse == 'Yes'
"
@CaidCoupleResourceLimitExceed.save!

#25	83	In-Kind Support	SubTab4_3_InKindSupport						Active if any included questions appear and as described in WW-Web Behavior.doc		
#25	84	In-Kind Support: Is your SSI check reduced because of In-Kind Support from others in your household?	InKind			YES:NO		YES	If SsiGet = Y AND SsiResourceLimitExceed <> Y AND SsiCoupleResourceLimitExceed <> Y AND (LiveWithSpouseAndOthers = Y OR LiveWithOthers = Y) AND VA_LiveWithSpouseAuxGrantFacility <> Y AND VA_CaidLiveWithSpouseInFacility <> Y AND VA_LiveInAuxGrantFacility <> Y AND VA_CaidLiveInFacility <> Y	Appear	NO
@InKind  = Question.new(:display_rules => 'always', :default_answer => 'No',                  :reference_id =>   '84',   :question_type => 'select',       :answer_choices => 'Yes, No',                          :order => 1,    :group_id => @In_Kind_Support.id)
@InKind.name = 'InKind'
@InKind.text = 'Is your SSI check reduced because of In-Kind Support from others in your household'
#If SsiGet = Y AND SsiResourceLimitExceed <> Y AND SsiCoupleResourceLimitExceed <> Y 
#AND (LiveWithSpouseAndOthers = Y OR LiveWithOthers = Y) 
#AND VA_LiveWithSpouseAuxGrantFacility <> Y AND VA_CaidLiveWithSpouseInFacility <> Y AND VA_LiveInAuxGrantFacility <> Y AND VA_CaidLiveInFacility <> Y

#30 review on Nov 2 2010
#If SsiGet = Y AND SsiResourceLimitExceed <> Y AND SsiCoupleResourceLimitExceed <> Y 
# AND (LiveWithSpouseAndOthers = Y OR LiveWithOthers = Y OR (LiveWithParents =  Y AND RAge > 17)) AND VA_LiveWithSpouseAuxGrantFacility <> Y AND VA_CaidLiveWithSpouseInFacility <> Y AND VA_LiveInAuxGrantFacility <> Y AND VA_CaidLiveInFacility <> Y
#Note RAge needed here
@InKind.display_rules = "
SsiGet = manager.get_answer_by_question_name('SsiGet')
SsiResourceLimitExceed  = manager.get_answer_by_question_name('SsiResourceLimitExceed ')
SsiCoupleResourceLimitExceed = manager.get_answer_by_question_name('SsiCoupleResourceLimitExceed')
LiveWithSpouseAndOthers = manager.get_answer_by_question_name('LiveWithSpouseAndOthers')
LiveWithOthers = manager.get_answer_by_question_name('LiveWithOthers')
LiveWithParents = manager.get_answer_by_question_name('LiveWithParents')
RAge = 17  #a bad hardwire
VA_LiveWithSpouseAuxGrantFacility = manager.get_answer_by_question_name('VA_LiveWithSpouseAuxGrantFacility')
VA_CaidLiveWithSpouseInFacility = manager.get_answer_by_question_name('VA_CaidLiveWithSpouseInFacility')
VA_LiveInAuxGrantFacility = manager.get_answer_by_question_name('VA_LiveInAuxGrantFacility')
VA_CaidLiveInFacility = manager.get_answer_by_question_name('VA_CaidLiveInFacility')
(SsiGet == 'Yes') && (SsiResourceLimitExceed != 'Yes') && (SsiCoupleResourceLimitExceed != 'Yes') && ((LiveWithSpouseAndOthers == 'Yes' || LiveWithOthers == 'Yes') || (LiveWithParents ==  'Yes' && RAge > 17)) && (VA_LiveWithSpouseAuxGrantFacility != 'Yes') && (VA_CaidLiveWithSpouseInFacility != 'Yes') && (VA_LiveInAuxGrantFacility != 'Yes') && (VA_CaidLiveInFacility != 'Yes') 
"
@InKind.save!

#25	85	1/3rd Reduction Rule: Is this In-Kind Support considered Full, that is, is it figured using the Value of the One-Third Reduction (VTR)?	
#InKindThird			YES:NO		YES	If InKind = Y	no		
@InKindThird  = Question.new(:display_rules => 'always', :default_answer => 'Yes',                  :reference_id =>   '85',   :question_type => 'select',       :answer_choices => 'Yes, No',                          :order => 2,    :group_id => @In_Kind_Support.id)
@InKindThird.name = 'InKindThird'
@InKindThird.text = '1/3rd Reduction Rule: Is this In-Kind Support considered Full, that is, is it figured using the Value of the One-Third Reduction (VTR)?	'
@InKindThird.display_rules = "
InKind = manager.get_answer_by_question_name('InKind')
InKind == 'Yes' 
"
@InKindThird.save!

#26	86	PMV Rule: How much In-Kind Support are you considered by SSA to receive?  (Default is the Presumed Maximum Value or PMV.)	
#InKindPMVAmt			IF SsiGet = Y AND SpouseSsiGet = Y, THEN Zero or Positive Number <= RatePmvCoupleAmt, ELSE <= RatePmvAmt	You can not enter an amount higher than the Presumed Maximum Value (PMV) of RateTwoThirdsFbrAmt for an individual or RatePmvCoupleAmt for a couple on SSI.  Enter numbers only.  Do not enter $ or decimal point.	EXPRESSION:  IF SpouseSsiGet = Y, THEN RatePmvCoupleAmt, ELSE RatePmvAmt	If InKindThird = N	no		This amount will be added to the user's unearned income. Allowable answer includes Couple PMV if user has spouse because that PMV could be used in spousal deeming.
@InKindPMVAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '86',   :question_type => 'text_field',       :answer_choices => '',                          :order => 3,    :group_id => @In_Kind_Support.id)
@InKindPMVAmt.name = 'InKindPMVAmt'
@InKindPMVAmt.text = 'PMV Rule: How much In-Kind Support are you considered by SSA to receive?  (Default is the Presumed Maximum Value or PMV.)'
#If InKindThird = N
@InKindPMVAmt.display_rules = "
InKindThird = manager.get_answer_by_question_name('InKindThird')
InKindThird == 'No' 
"
#IF SsiGet = Y AND SpouseSsiGet = Y, THEN Zero or Positive Number <= RatePmvCoupleAmt, ELSE <= RatePmvAmt   NOTE RATE HARDWIRES #NOTE THIS RATEtoUse routine should be broken out, probably used again later
@InKindPMVAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
SsiGet = manager.get_answer_by_question_name('SsiGet')
SpouseSsiGet = manager.get_answer_by_question_name('SpouseSsiGet')
RatePMV = 244.67
RatePmvCoupleAmt = 357.00
if SsiGet == 'Yes' && SpouseSsiGet == 'Yes' then
  RateToUse = RatePmvCoupleAmt
else
  RateToUse = RatePMV  
end

if answer != nil then
    DoWeFloat = (true if (Float(answer) >= 0) rescue false)
    if DoWeFloat then 
      Float(answer) <= RateToUse 
    else
      false
   end  
else 
  true
end
"
@InKindPMVAmt.validation_message = "Enter positive numbers only.  Do not enter $."
@InKindPMVAmt.save!


#25	87	Own Unearned Income	SubTab4_4_OwnUnearnedIncome						Active if any included questions appear and as described in WW-Web Behavior.doc			
#25	88	What is your Primary Insurance Amount (the full amount of your monthly SSDI benefit based on your earnings record)?	
#Name change  New SsdiAmtSelfFull
#SsdiAmtSelfFull			Zero or Positive Number	Enter numbers only.  Do not enter $ or decimal point.	0.00	If SsdiEarnRec = Self	no		
@SsdiAmtSelfFull = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '88',   :question_type => 'text_field',       :answer_choices => '',                          :order => 1,    :group_id => @Own_Unearned_Income.id)
@SsdiAmtSelfFull.name = 'SsdiAmtSelfFull'
@SsdiAmtSelfFull.text = 'What is your Primary Insurance Amount (the full amount of your monthly SSDI benefit based on your earnings record)?'
#If SsdiEarnRec = Self
@SsdiAmtSelfFull.display_rules = "
SsdiEarnRec = manager.get_answer_by_question_name('SsdiEarnRec')
SsdiEarnRec == 'Self'
"
@SsdiAmtSelfFull.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
if answer != nil then
    true if (Float(answer) >= 0) rescue false
  else 
    true
end
"
@SsdiAmtSelfFull.validation_message = "Enter positive numbers only.  Do not enter $."

@SsdiAmtSelfFull.save!

#new name SsdiAmtOtherFull
#25	89	What is the full monthly amount of your SSDI cash benefit (assuming no adjustment for Medicare Part B premium or previous under/over-payments)?	
#SsdiAmtOtherFull			Zero or Positive Number 	Enter numbers only.  Do not enter $ or decimal point.	0.00	If SsdiEarnRec = Other	Appear
@SsdiAmtOtherFull = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '89',   :question_type => 'text_field',       :answer_choices => '',                          :order => 2,    :group_id => @Own_Unearned_Income.id)
@SsdiAmtOtherFull.name = 'SsdiAmtOtherFull'
@SsdiAmtOtherFull.text = 'What is the full monthly amount of your SSDI cash benefit (assuming no adjustment for Medicare Part B premium or previous under/over-payments)?'
#If SsdiEarnRec = Other
@SsdiAmtOtherFull.display_rules = "
SsdiEarnRec = manager.get_answer_by_question_name('SsdiEarnRec')
SsdiEarnRec == 'Other'
"
@SsdiAmtOtherFull.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
if answer != nil then
    true if (Float(answer) >= 0) rescue false
  else 
    true
end
"
@SsdiAmtOtherFull.validation_message = "Enter positive numbers only.  Do not enter $."

@SsdiAmtOtherFull.save!

#10/18/2010 edit Change question wording
#10/18/2010 review display rule
#If SsdiGet = Y OR (SsiGet = Y AND (SsiResourceLimitExceed <> Y OR SsiCoupleResourceLimitExceed <> Y) OR ((CaidGet = Y OR CaidApply = Y) AND (CaidResourceLimitExceed <>Y OR CaidCoupleResourceLimitExceed <>Y))
#Note mismatchd parens in display rule If SsdiGet = Y OR 1(SsiGet = Y AND 2(SsiResourceLimitExceed <> Y OR SsiCoupleResourceLimitExceed <> Y 2) OR 3(4(CaidGet = Y OR CaidApply = Y4) AND 5(CaidResourceLimitExceed <>Y OR CaidCoupleResourceLimitExceed <>Y5)3)
#Look at excel
#=IF(OR(L39="YES";AND(L31="YES";OR(L84<>"YES";L85<>"YES"));AND(OR(L34="YES";L36="YES");OR(L86<>"YES";L87<>"YES")));"Appear";"no")
#messy but looks ok, show unless any of the recource limits ewxceeded.
#25	90	How much unearned income per month (other than SSDI or SSI) do you receive? 	
#UnearnAmt			Zero or Positive Number 	Enter numbers only.  Do not enter $ or decimal point.	0.00	
#If DiGet = Y OR (SsiGet = Y AND LiveWithSpouse = N AND SsiResourceLimitExceed <> Y) 
#OR (SsiGet = Y AND LiveWithSpouse = Y AND SsiCoupleResourceLimitExceed <> Y) 
#OR ((CaidGet = Y OR CaidApply = Y) AND LiveWithSpouse = N AND CaidResourceLimitExceed <>Y) 
#OR ((CaidGet = Y OR CaidApply = Y) AND  LiveWithSpouse = Y AND CaidCoupleResourceLimitExceed <>Y)	Appear	2,000.00
#=IF(OR(L39="YES";AND(L31="YES";L15="NO";L83<>"YES");AND(L31="YES";L15="YES";L84<>"YES");AND(OR(L34="YES";L36="YES");L15="NO";L85<>"YES");OR(L34="YES";L36="YES");L15="YES";L86<>"YES");"Appear";"no")
#per DR on phone ask if on ssi or di or caid and nome of the applicable resource limits are exceeded
@UnearnAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '90',   :question_type => 'text_field',       :answer_choices => '',                          :order => 3,    :group_id => @Own_Unearned_Income.id)
@UnearnAmt.name = 'UnearnAmt'
@UnearnAmt.text = 'How much other unearned income per month do you receive? (Do not count any SSI or SSDI.)?'
#If DiGet = Y OR (SsiGet = Y AND LiveWithSpouse = N AND SsiResourceLimitExceed <> Y) OR (SsiGet = Y AND LiveWithSpouse = Y AND SsiCoupleResourceLimitExceed <> Y) 
#OR ((CaidGet = Y OR CaidApply = Y) AND LiveWithSpouse = N AND CaidResourceLimitExceed <>Y) OR ((CaidGet = Y OR CaidApply = Y) AND  LiveWithSpouse = Y AND CaidCoupleResourceLimitExceed <>Y)

#note this display rule is also needed to determine if unearned income is displayed in numeric outputs and i hope to not duplicate
#if we can create a calc here and then refernce the calc in both places that would be good

@UnearnAmt.display_rules = "
DiGet = manager.get_answer_by_question_name('DiGet')
SsiGet = manager.get_answer_by_question_name('SsiGet')
SsiResourceLimitExceed = manager.get_answer_by_question_name('SsiResourceLimitExceed')
SsiCoupleResourceLimitExceed = manager.get_answer_by_question_name('SsiCoupleResourceLimitExceed')
CaidGet = manager.get_answer_by_question_name('CaidGet')
CaidApply = manager.get_answer_by_question_name('CaidApply')
CaidResourceLimitExceed = manager.get_answer_by_question_name('CaidResourceLimitExceed')
CaidCoupleResourceLimitExceed = manager.get_answer_by_question_name('CaidCoupleResourceLimitExceed')
(DiGet == 'Yes') || (SsiGet == 'Yes'  && (!(SsiResourceLimitExceed == 'Yes') && !(SsiResourceLimitExceed == 'Yes')) || ((CaidGet == 'Yes' || CaidApply == 'Yes') && (!(CaidResourceLimitExceed == 'Yes') && !(CaidCoupleResourceLimitExceed == 'Yes'))))
"

@UnearnAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
if answer != nil then
    true if (Float(answer) >= 0) rescue false
  else 
    true
end
"
@UnearnAmt.validation_message = "Enter positive numbers only.  Do not enter $."

@UnearnAmt.save!

#25	91	How much of your $2000 of unearned income is infrequent or irregular?	UnearnInfrequentAmt			Zero or Positive Number 	Enter numbers only.  Do not enter $ or decimal point.	0.00	
#IF UnearnAmt > 0 AND (SsiGet = Y OR CaidGet = Y OR CaidApply = Y)	Appear	20.00
@UnearnInfrequentAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '91',   :question_type => 'text_field',       :answer_choices => '',                          :order => 4,    :group_id => @Own_Unearned_Income.id)
@UnearnInfrequentAmt.name = 'UnearnInfrequentAmt'
@UnearnInfrequentAmt.text = 'How much of your of unearned income is infrequent or irregular?'
#IF UnearnAmt > 0 AND (SsiGet = Y OR CaidGet = Y OR CaidApply = Y)
@UnearnInfrequentAmt.display_rules = "
UnearnAmt = manager.get_answer_by_question_name('UnearnAmt')
SsiGet = manager.get_answer_by_question_name('SsiGet')
CaidGet = manager.get_answer_by_question_name('CaidGet')
CaidApply = manager.get_answer_by_question_name('CaidApply')
if UnearnAmt != nil then
  UnearnAmtNum = Float(UnearnAmt)
else
  UnearnAmtNum = 0
end
(UnearnAmtNum > 0) && (SsiGet == 'Yes' || CaidGet == 'Yes' || CaidApply == 'Yes') 
"
@UnearnInfrequentAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
UnearnAmt = manager.get_answer_by_question_name('UnearnAmt')

if answer != nil then
    if (true if (Float(answer) >= 0) rescue false) then
        if Float(answer) <=  Float(UnearnAmt) then
          true
        else 
          false
        end
    else
      false
    end  
else       
    true
end
"
@UnearnInfrequentAmt.validation_message = "You can not enter an amount higher than your unearned income, not counting SSDI or SSI.  Do not enter $."
@UnearnInfrequentAmt.save!

#why doesn't UnearnAmt > 0 work here?

#25	92	How much of your $2000 of unearned income would SSA define as Income Based On Need?	
#UnearnIncomeBasedOnNeedAmt			Zero or Positive Number <= UnearnAmt	You can not enter an amount higher than your unearned income, not counting SSDI or SSI (UnearnAmt).  Enter numbers only.  Do not enter $ or decimal point.	0.00	
#IF UnearnAmt > 0 AND (SsiGet = Y OR CaidGet = Y OR CaidApply = Y)	Appear	25.00
@UnearnIncomeBasedOnNeedAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '92',   :question_type => 'text_field',       :answer_choices => '',                          :order => 5,    :group_id => @Own_Unearned_Income.id)
@UnearnIncomeBasedOnNeedAmt.name = 'UnearnIncomeBasedOnNeedAmt'
@UnearnIncomeBasedOnNeedAmt.text = 'How much of your unearned income would SSA define as Income Based On Need?'
#IF UnearnAmt > 0 AND (SsiGet = Y OR CaidGet = Y OR CaidApply = Y)
@UnearnIncomeBasedOnNeedAmt.display_rules = "
UnearnAmt = manager.get_answer_by_question_name('UnearnAmt')
SsiGet = manager.get_answer_by_question_name('SsiGet')
CaidGet = manager.get_answer_by_question_name('CaidGet')
CaidApply = manager.get_answer_by_question_name('CaidApply')
if UnearnAmt != nil then
  UnearnAmt = Float(UnearnAmt)
else
  UnearnAmt = 0  
end
(UnearnAmt > 0) && (SsiGet == 'Yes' || CaidGet == 'Yes' || CaidApply == 'Yes') 
"
@UnearnIncomeBasedOnNeedAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
UnearnAmt = manager.get_answer_by_question_name('UnearnAmt')

if answer != nil then
    if (true if (Float(answer) >= 0) rescue false) then
        if Float(answer) <=  Float(UnearnAmt) then
          true
        else 
          false
        end
    else
      false
    end  
else       
    true
end
"
@UnearnIncomeBasedOnNeedAmt.validation_message = "You can not enter an amount higher than your unearned income, not counting SSDI or SSI.  Do not enter $."

@UnearnIncomeBasedOnNeedAmt.save!

#note most of the unearned income questions do not show correctly, i'm hoping its an interface issue, it could be how i'm handling unearned income entry
#25	93	How much of your $2000 of unearned income would SSA define as Assistance Based On Need?	UnearnAssistanceBasedOnNeedAmt			Zero or Positive Number <= UnearnAmt	You can not enter an amount higher than your unearned income, not counting SSDI or SSI (UnearnAmt).  Enter numbers only.  Do not enter $ or decimal point.	0.00	
#IF UnearnAmt > 0 AND (SsiGet = Y OR CaidGet = Y OR CaidApply = Y)	Appear	30.00
@UnearnAssistanceBasedOnNeedAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '92',   :question_type => 'text_field',       :answer_choices => '',                          :order => 5,    :group_id => @Own_Unearned_Income.id)
@UnearnAssistanceBasedOnNeedAmt.name = 'UnearnAssistanceBasedOnNeedAmt'
@UnearnAssistanceBasedOnNeedAmt.text = 'How much of your unearned income would SSA define as Assistance Based On Need?'
#IF UnearnAmt > 0 AND (SsiGet = Y OR CaidGet = Y OR CaidApply = Y)
@UnearnAssistanceBasedOnNeedAmt.display_rules = "
UnearnAmt = manager.get_answer_by_question_name('UnearnAmt').to_f
SsiGet = manager.get_answer_by_question_name('SsiGet')
CaidGet = manager.get_answer_by_question_name('CaidGet')
CaidApply = manager.get_answer_by_question_name('CaidApply')
#if UnearnAmt != nil then
#  UnearnAmt = Float(UnearnAmt)
#  else
#    UnearnAmt = 0
#end
(UnearnAmt > 0) && (SsiGet == 'Yes' || CaidGet == 'Yes' || CaidApply == 'Yes') 
"
@UnearnAssistanceBasedOnNeedAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
UnearnAmt = manager.get_answer_by_question_name('UnearnAmt')

if answer != nil then
    if (true if (Float(answer) >= 0) rescue false) then
        if Float(answer) <=  Float(UnearnAmt) then
          true
        else 
          false
        end
    else
      false
    end  
else       
    true
end
"
@UnearnAssistanceBasedOnNeedAmt.validation_message = "You can not enter an amount higher than your unearned income, not counting SSDI or SSI.  Do not enter $."

@UnearnAssistanceBasedOnNeedAmt.save!

#25	94	Spouse Unearned Income	SubTab4_5_SpouseUnearnedIncome						Active if any included questions appear and as described in WW-Web Behavior.doc			
#25	95	What is your spouse's Primary Insurance Amount (the full amount of your spouse's monthly SSDI benefit based on your spouse's earnings record)?	
#SpouseDiAmtSelfFull			Zero or Positive Number 	Enter numbers only.  Do not enter $ or decimal point.	0.00	IF SpouseSsdiEarnRec = Self	no	300.00	
@SpouseDiAmtSelfFull = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '95',   :question_type => 'text_field',       :answer_choices => '',                          :order => 1,    :group_id => @Spouse_Unearned_Income.id)
@SpouseDiAmtSelfFull.name = 'SpouseDiAmtSelfFull'
@SpouseDiAmtSelfFull.text = 'What is your spouse\'s Primary Insurance Amount? (the full amount of your spouse\'s monthly SSDI benefit based on your spouse\'s earnings record)'
#IF SpouseSsdiEarnRec = Self
@SpouseDiAmtSelfFull.display_rules = "
SpouseSsdiEarnRec = manager.get_answer_by_question_name('SpouseSsdiEarnRec')
SpouseSsdiEarnRec == 'Self'
"
@SpouseDiAmtSelfFull.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
if answer != nil then
    true if (Float(answer) >= 0) rescue false
  else 
    true
end
"
@SpouseDiAmtSelfFull.validation_message = "Enter positive numbers only.  Do not enter $."
@SpouseDiAmtSelfFull.save!

#25	96	What is the full monthly amount of your spouse's SSDI cash benefit (assuming no adjustment for Medicare Part B premium or previous under/over-payments)? 	SpouseDiAmtOtherFull			Zero or Positive Number 	Enter numbers only.  Do not enter $ or decimal point.	0.00	IF SpouseSsdiEarnRec = Other	Appear	
@SpouseDiAmtOtherFull = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '95',   :question_type => 'text_field',       :answer_choices => '',                          :order => 2,    :group_id => @Spouse_Unearned_Income.id)
@SpouseDiAmtOtherFull.name = 'SpouseDiAmtOtherFull'
@SpouseDiAmtOtherFull.text = 'What is the full monthly amount of your spouse\'s SSDI cash benefit (assuming no adjustment for Medicare Part B premium or previous under/over-payments)?'
#IF SpouseSsdiEarnRec = Other
@SpouseDiAmtOtherFull.display_rules = "
SpouseSsdiEarnRec = manager.get_answer_by_question_name('SpouseSsdiEarnRec')
SpouseSsdiEarnRec == 'Other'
"
@SpouseDiAmtOtherFull.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
if answer != nil then
    true if (Float(answer) >= 0) rescue false
  else 
    true
end
"
@SpouseDiAmtOtherFull.validation_message = "Enter positive numbers only.  Do not enter $."
@SpouseDiAmtOtherFull.save!

#25	97	How much unearned income per month (other than SSDI or SSI) does your spouse receive? 	
#SpouseUnEarnAmt			Zero or Positive Number 	Enter numbers only.  Do not enter $ or decimal point.	0.00	
#IF (SpouseSsiGet = Y AND SsiCoupleResourceLimitExceed <> Y) 
#OR ((CaidSpouseGet = Y OR CaidSpouseApply = Y) AND CaidCoupleResourceLimitExceed <> Y)	Appear	
@SpouseUnEarnAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '97',   :question_type => 'text_field',       :answer_choices => '',                          :order => 3,    :group_id => @Spouse_Unearned_Income.id)
@SpouseUnEarnAmt.name = 'SpouseUnEarnAmt'
@SpouseUnEarnAmt.text = 'How much unearned income per month (other than SSDI or SSI) does your spouse receive ?'
#IF (SpouseSsiGet = Y AND SsiCoupleResourceLimitExceed <> Y) OR ((CaidSpouseGet = Y OR CaidSpouseApply = Y) AND CaidCoupleResourceLimitExceed <> Y)

@SpouseUnEarnAmt.display_rules = "
SpouseSsiGet = manager.get_answer_by_question_name('SpouseSsiGet')
SsiCoupleResourceLimitExceed = manager.get_answer_by_question_name('SsiCoupleResourceLimitExceed')
CaidSpouseGet = manager.get_answer_by_question_name('CaidSpouseGet')
CaidSpouseApply = manager.get_answer_by_question_name('CaidSpouseApply')
CaidCoupleResourceLimitExceed = manager.get_answer_by_question_name('CaidCoupleResourceLimitExceed')
(SpouseSsiGet == 'Yes' && SsiCoupleResourceLimitExceed != 'Yes') || ((CaidSpouseGet == 'Yes' || CaidSpouseApply == 'Yes') && CaidCoupleResourceLimitExceed != 'Yes')
"
@SpouseUnEarnAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
if answer != nil then
    true if (Float(answer) >= 0) rescue false
  else 
    true
end
"
@SpouseUnEarnAmt.validation_message = "Enter positive numbers only.  Do not enter $."
@SpouseUnEarnAmt.save!

#25	98	How much of your spouse's $ of unearned income does your spouse receive infrequently or irregularly?	SpouseUnearnInfrequentAmt			Zero or Positive Number	Enter numbers only.  Do not enter $ or decimal point.	0.00	IF SpouseUnEarnAmt > 0	no
@SpouseUnearnInfrequentAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '98',   :question_type => 'text_field',       :answer_choices => '',                          :order => 4,    :group_id => @Spouse_Unearned_Income.id)
@SpouseUnearnInfrequentAmt.name = 'SpouseUnearnInfrequentAmt'
@SpouseUnearnInfrequentAmt.text = 'How much of your spouse\'s unearned income does your spouse receive infrequently or irregularly?'
#IF SpouseUnEarnAmt > 0
@SpouseUnearnInfrequentAmt.display_rules = "
SpouseUnEarnAmt = manager.get_answer_by_question_name('SpouseUnEarnAmt').to_f
#if SpouseUnEarnAmt != nil then
#  SpouseUnEarnAmt = Float(SpouseUnEarnAmt)
#  else
#    SpouseUnEarnAmt = 0
#end
SpouseUnEarnAmt > 0
"
@SpouseUnearnInfrequentAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
SpouseUnEarnAmt = manager.get_answer_by_question_name('SpouseUnEarnAmt')

if answer != nil then
    if (true if (Float(answer) >= 0) rescue false) then
        if Float(answer) <=  Float(SpouseUnEarnAmt) then
          true
        else 
          false
        end
    else
      false
    end  
else       
    true
end
"
@SpouseUnearnInfrequentAmt.validation_message = "You can not enter an amount higher than your spouse's unearned income, not counting SSDI or SSI.  Do not enter $."

@SpouseUnearnInfrequentAmt.save!


#25	99	How much of your spouse's $SpouseUnEarnAmt of unearned income would SSA define as INCOME Based On Need?	
#SpouseUnearnIncomeBasedOnNeedAmt			Zero or Positive Number <= SpouseUnEarnAmt	You can not enter an amount higher than your spouse's unearned income, not counting SSDI or SSI (SpouseUnEarnAmt).  Enter numbers only.  Do not enter $ or decimal point.	0.00	IF SpouseUnEarnAmt > 0	no	90.00
@SpouseUnearnIncomeBasedOnNeedAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '99',   :question_type => 'text_field',       :answer_choices => '',                          :order => 5,    :group_id => @Spouse_Unearned_Income.id)
@SpouseUnearnIncomeBasedOnNeedAmt.name = 'SpouseUnearnIncomeBasedOnNeedAmt'
@SpouseUnearnIncomeBasedOnNeedAmt.text = 'How much of your spouse\'s unearned income would SSA define as INCOME Based On Need??'
#IF SpouseUnEarnAmt > 0
@SpouseUnearnIncomeBasedOnNeedAmt.display_rules = "
SpouseUnEarnAmt = manager.get_answer_by_question_name('SpouseUnEarnAmt').to_f
#if SpouseUnEarnAmt != nil then
#  SpouseUnEarnAmt = Float(SpouseUnEarnAmt)
#  else
#    SpouseUnEarnAmt = 0
#end
SpouseUnEarnAmt > 0
"
@SpouseUnearnIncomeBasedOnNeedAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
SpouseUnEarnAmt = manager.get_answer_by_question_name('SpouseUnEarnAmt')

if answer != nil then
    if (true if (Float(answer) >= 0) rescue false) then
        if Float(answer) <=  Float(SpouseUnEarnAmt) then
          true
        else 
          false
        end
    else
      false
    end  
else       
    true
end
"
@SpouseUnearnIncomeBasedOnNeedAmt.validation_message = "You can not enter an amount higher than your spouse's unearned income, not counting SSDI or SSI.  Do not enter $."

@SpouseUnearnIncomeBasedOnNeedAmt.save!

#25	100	How much of your spouse's $SpouseUnEarnAmt of unearned income would SSA define as ASSISTANCE Based On Need?	
#SpouseUnearnAssistanceBasedOnNeedAmt			Zero or Positive Number <= SpouseUnEarnAmt	You can not enter an amount higher than your spouse's unearned income, not counting SSDI or SSI (SpouseUnEarnAmt).  Enter numbers only.  Do not enter $ or decimal point.	0.00	IF SpouseUnEarnAmt > 0	no	30.00
@SpouseUnearnAssistanceBasedOnNeedAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '100',   :question_type => 'text_field',       :answer_choices => '',                          :order => 6,    :group_id => @Spouse_Unearned_Income.id)
@SpouseUnearnAssistanceBasedOnNeedAmt.name = 'SpouseUnearnAssistanceBasedOnNeedAmt'
@SpouseUnearnAssistanceBasedOnNeedAmt.text = 'How much of your spouse\'s unearned income would SSA define as ASSISTANCE Based On Need?'
#IF SpouseUnEarnAmt > 0
@SpouseUnearnAssistanceBasedOnNeedAmt.display_rules = "
SpouseUnEarnAmt = manager.get_answer_by_question_name('SpouseUnEarnAmt').to_f
#if SpouseUnEarnAmt != nil then
#  SpouseUnEarnAmt = Float(SpouseUnEarnAmt)
#  else
#    SpouseUnEarnAmt = 0
#end
SpouseUnEarnAmt > 0
"
@SpouseUnearnAssistanceBasedOnNeedAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
SpouseUnEarnAmt = manager.get_answer_by_question_name('SpouseUnEarnAmt')

if answer != nil then
    if (true if (Float(answer) >= 0) rescue false) then
        if Float(answer) <=  Float(SpouseUnEarnAmt) then
          true
        else 
          false
        end
    else
      false
    end  
else       
    true
end
"
@SpouseUnearnAssistanceBasedOnNeedAmt.validation_message = "You can not enter an amount higher than your spouse's unearned income, not counting SSDI or SSI.  Do not enter $."
@SpouseUnearnAssistanceBasedOnNeedAmt.save!

#25	101	Own Earned Income	SubTab4_6_OwnEarnedIncome						Active if any included questions appear and as described in WW-Web Behavior.doc		

#new name SsdiEarnAmt
#25	102	How much do you Earn monthly in gross wages, salary or self-employment? [NOTE: Select "Help" for difference between Earn & Receive.]	
#SsdiEarnAmt			Zero or Positive Number	Enter numbers only.  Do not enter $ or decimal point.	0.00	If  DiGet = Y	Appear	1,000.00
@SsdiEarnAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '102',   :question_type => 'text_field',       :answer_choices => '',                          :order => 1,    :group_id => @Own_Earned_Income.id)
@SsdiEarnAmt.name = 'SsdiEarnAmt'
@SsdiEarnAmt.text = 'How much do you Earn monthly in gross wages, salary or self-employment? [NOTE: Select "Help" for difference between Earn & Receive.]'
#If  DiGet = Y
@SsdiEarnAmt.display_rules = "
DiGet = manager.get_answer_by_question_name('DiGet')
DiGet == 'Yes'
"
@SsdiEarnAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
if answer != nil then
    true if (Float(answer) >= 0) rescue false
  else 
    true
end
"
@SsdiEarnAmt.validation_message = "Enter positive numbers only.  Do not enter $."
@SsdiEarnAmt.save!

#25	103	How much do you Receive monthly in gross wages, salary or self-employment? [NOTE: Select "Help" for difference between Earn & Receive.]	
#SsiOrCaidEarnAmt			Zero or Positive Number 	Enter numbers only.  Do not enter $ or decimal point.	EXPRESSION: $0.00 OR SsdiEarnAmt	
#If (SsiGet = Y AND LiveWithSpouse = N AND SsiResourceLimitExceed <> Y) OR (SsiGet = Y AND LiveWithSpouse = Y AND SsiCoupleResourceLimitExceed <> Y) OR ((CaidGet = Y OR CaidApply = Y) AND LiveWithSpouse = N AND CaidResourceLimitExceed <>Y) OR ((CaidGet = Y OR CaidApply = Y) AND  LiveWithSpouse = Y AND CaidCoupleResourceLimitExceed <>Y)	Appear	1,000.00
@SsiOrCaidEarnAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '103',   :question_type => 'text_field',       :answer_choices => '',                          :order => 1,    :group_id => @Own_Earned_Income.id)
@SsiOrCaidEarnAmt.name = 'SsiOrCaidEarnAmt'
@SsiOrCaidEarnAmt.text = 'How much do you Receive monthly in gross wages, salary or self-employment? [NOTE: Select "Help" for difference between Earn & Receive.]'
#If (SsiGet = Y AND LiveWithSpouse = N AND SsiResourceLimitExceed <> Y) OR 
#(SsiGet = Y AND LiveWithSpouse = Y AND SsiCoupleResourceLimitExceed <> Y) 
#OR ((CaidGet = Y OR CaidApply = Y) AND LiveWithSpouse = N AND CaidResourceLimitExceed <>Y) 
#OR ((CaidGet = Y OR CaidApply = Y) AND  LiveWithSpouse = Y AND CaidCoupleResourceLimitExceed <>Y)
@SsiOrCaidEarnAmt.display_rules = "
SsiGet = manager.get_answer_by_question_name('SsiGet')
LiveWithSpouse = manager.get_answer_by_question_name('LiveWithSpouse')
SsiResourceLimitExceed = manager.get_answer_by_question_name('SsiResourceLimitExceed')
SsiCoupleResourceLimitExceed = manager.get_answer_by_question_name('SsiCoupleResourceLimitExceed')
CaidGet = manager.get_answer_by_question_name('CaidGet')
CaidApply = manager.get_answer_by_question_name('CaidApply')
CaidResourceLimitExceed = manager.get_answer_by_question_name('CaidResourceLimitExceed')
CaidCoupleResourceLimitExceed = manager.get_answer_by_question_name('CaidCoupleResourceLimitExceed')
(SsiGet == 'Yes' && LiveWithSpouse == 'No' && SsiResourceLimitExceed != 'Yes') || (SsiGet == 'Yes' && LiveWithSpouse == 'Yes' && SsiCoupleResourceLimitExceed != 'Yes') || ((CaidGet == 'Yes' || CaidApply == 'Yes') && LiveWithSpouse == 'No' && CaidResourceLimitExceed !='Yes') || ((CaidGet == 'Yes' || CaidApply == 'Yes') &&  LiveWithSpouse == 'Yes' && CaidCoupleResourceLimitExceed != 'Yes')
"
@SsiOrCaidEarnAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
if answer != nil then
    true if (Float(answer) >= 0) rescue false
  else 
    true
end
"
@SsiOrCaidEarnAmt.validation_message = "Enter positive numbers only.  Do not enter $."
@SsiOrCaidEarnAmt.save!

#Debugging note Bob has found an error when LiveWithSpouse is false but unable to figure it out.  Found while testing 
#the (SsiGet == 'Yes' && LiveWithSpouse == 'No' && SsiResourceLimitExceed != 'Yes')  clause

#new SsiIndividThreshold
#26	104	Individualized Threshold:  Has an individualized earnings threshold been established for you (above which you lose 1619(b) Medicaid coverage)?	
#SsiIndividThreshold			YES:NO		NO	If SsiGet = Y OR VA_CaidGetCoveredGroup = 1619b AND (SsiOrCaidEarnAmt > VA_RateSsiCaidMonthlyThresholdAmt)	no
@SsiIndividThreshold = Question.new(:display_rules => 'always', :default_answer => 'No',                  :reference_id =>   '104',   :question_type => 'select',       :answer_choices => 'Yes, No',                          :order => 3,    :group_id => @Own_Earned_Income.id)
@SsiIndividThreshold.name = 'SsiIndividThreshold'
@SsiIndividThreshold.text = 'Individualized Threshold:  Has an individualized earnings threshold been established for you (above which you lose 1619(b) Medicaid coverage)?'
#If SsiGet = Y OR VA_CaidGetCoveredGroup = 1619b AND (SsiOrCaidEarnAmt > VA_RateSsiCaidMonthlyThresholdAmt)
@SsiIndividThreshold.display_rules = "
SsiGet = manager.get_answer_by_question_name('SsiGet')
VA_CaidGetCoveredGroup = manager.get_answer_by_question_name('VA_CaidGetCoveredGroup')
SsiOrCaidEarnAmt = manager.get_answer_by_question_name('SsiOrCaidEarnAmt').to_f
#if SsiOrCaidEarnAmt != nil then
#  SsiOrCaidEarnAmt = Float(SsiOrCaidEarnAmt)
#  else
#    SsiOrCaidEarnAmt = 0
#end
VA_RateSsiCaidMonthlyThresholdAmt = 30600
(((SsiGet == 'Yes') || (VA_CaidGetCoveredGroup == '1619b')) && (SsiOrCaidEarnAmt > VA_RateSsiCaidMonthlyThresholdAmt))
"
@SsiIndividThreshold.save!

#note Bob would like to do a VA_RateSsiCaidMonthlyThresholdAmt = manager.WebRate.find_by_name('MedicaidAnnualThreshold') but can't figure out how
# to make it work

#Also why does the delete key jump to the previous screen??
#26	105	How much is your individualized earnings threshold (annual amount)?	SsiAnnualIndividThresholdAmt			Number > RateSsiCaidMonthlyThresholdTbl * 12 for State	Your Individualized Threshold amount must be larger than the annual threshold amount for your state (VA_RateSsiCaidMonthlyThresholdAmt).  Enter numbers only.  Do not enter $ or decimal point.	0.00	If SsiIndividThreshold = Y	no
@SsiAnnualIndividThresholdAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '105',   :question_type => 'text_field',       :answer_choices => '',                          :order => 4,    :group_id => @Own_Earned_Income.id)
@SsiAnnualIndividThresholdAmt.name = 'SsiAnnualIndividThresholdAmt'
@SsiAnnualIndividThresholdAmt.text = 'How much is your individualized earnings threshold (annual amount)?'
#If SsiIndividThreshold = Y
@SsiAnnualIndividThresholdAmt.display_rules = "
SsiIndividThreshold = manager.get_answer_by_question_name('SsiIndividThreshold')
SsiIndividThreshold == 'Yes'
"
#NOTE Rate Hardwire
@SsiAnnualIndividThresholdAmt.validation_rules = "
VA_RateSsiCaidMonthlyThresholdAmt = 30600
answer = manager.get_answer_by_question_name(self.name)
if answer != nil then
    true if (Float(answer) > VA_RateSsiCaidMonthlyThresholdAmt) rescue false
  else 
    true
end
"
@SsiAnnualIndividThresholdAmt.validation_message = "Your Individualized Threshold amount must be larger than the annual threshold amount for your state, " + "$30600.00"
@SsiAnnualIndividThresholdAmt.save!

#25	106	Spouse Earned Income	SubTab4_7_SpouseEarnedIncome						Active if any included questions appear and as described in WW-Web Behavior.doc	
#25	107	How much monthly income from wages, salary or self-employment does your spouse Earn? [NOTE: Select "Help" for difference between Earn & Receive.] 	SpouseSsdiEarnAmt			Zero or Positive Number	Enter numbers only.  Do not enter $ or decimal point.	0.00	IF SpouseSsdiGet = Y	Appear
@SpouseSsdiEarnAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '107',   :question_type => 'text_field',       :answer_choices => '',                          :order => 1,    :group_id => @Spouse_Earned_Income.id)
@SpouseSsdiEarnAmt.name = 'SpouseSsdiEarnAmt'
@SpouseSsdiEarnAmt.text = 'How much monthly income from wages, salary or self-employment does your spouse Earn? [NOTE: Select "Help" for difference between Earn & Receive.]'
#IF SpouseSsdiGet = Y
@SpouseSsdiEarnAmt.display_rules = "
SpouseSsdiGet = manager.get_answer_by_question_name('SpouseSsdiGet')
SpouseSsdiGet == 'Yes'
"
@SpouseSsdiEarnAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
if answer != nil then
    true if (Float(answer) >= 0) rescue false
  else 
    true
end
"
@SpouseSsdiEarnAmt.validation_message = "Enter positive numbers only.  Do not enter $."
@SpouseSsdiEarnAmt.save!

#25	108	How much monthly income from wages, salary or self-employment does your spouse Receive? [NOTE: Select "Help" for difference between Earn & Receive.] 	SpouseSsiOrCaidEarnAmt			Zero or Positive Number	Enter numbers only.  Do not enter $ or decimal point.	0.00	IF (SpouseSsiGet = Y AND SsiCoupleResourceLimitExceed <> Y) OR ((CaidSpouseGet = Y OR CaidSpouseApply = Y) AND CaidCoupleResourceLimitExceed <> Y)
@SpouseSsiOrCaidEarnAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '107',   :question_type => 'text_field',       :answer_choices => '',                          :order => 2,    :group_id => @Spouse_Earned_Income.id)
@SpouseSsiOrCaidEarnAmt.name = 'SpouseSsiOrCaidEarnAmt'
@SpouseSsiOrCaidEarnAmt.text = 'How much monthly income from wages, salary or self-employment does your spouse Receive? [NOTE: Select "Help" for difference between Earn & Receive.] '
#IF (SpouseSsiGet = Y AND SsiCoupleResourceLimitExceed <> Y) OR ((CaidSpouseGet = Y OR CaidSpouseApply = Y) AND CaidCoupleResourceLimitExceed <> Y)
#Review display rule
#IF (SpouseSsiGet = Y AND SsiCoupleResourceLimitExceed <> Y) OR ((CaidSpouseGet = Y OR CaidSpouseApply = Y) AND CaidCoupleResourceLimitExceed <> Y)
@SpouseSsiOrCaidEarnAmt.display_rules = "
SpouseSsiGet = manager.get_answer_by_question_name('SpouseSsiGet')
SsiCoupleResourceLimitExceed = manager.get_answer_by_question_name('SsiCoupleResourceLimitExceed')
CaidSpouseGet = manager.get_answer_by_question_name('CaidSpouseGet')
CaidSpouseApply = manager.get_answer_by_question_name('CaidSpouseApply')
CaidCoupleResourceLimitExceed = manager.get_answer_by_question_name('CaidCoupleResourceLimitExceed')
((SpouseSsiGet == 'Yes') && SsiCoupleResourceLimitExceed != 'Yes') || ((CaidSpouseGet == 'Yes' || CaidSpouseApply == 'Yes') && CaidCoupleResourceLimitExceed != 'Yes')
"
@SpouseSsiOrCaidEarnAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
if answer != nil then
    true if (Float(answer) >= 0) rescue false
  else 
    true
end
"
@SpouseSsiOrCaidEarnAmt.validation_message = "Enter positive numbers only.  Do not enter $."
@SpouseSsiOrCaidEarnAmt.save!

## NOTE rate issue here
#26	109	Spouse Individualized Threshold:  Has an individualized earnings threshold been established for your spouse (above which your spouse loses 1619(b) Medicaid coverage)?	
#SpouseIndividThreshold			YES:NO		NO	If (VA_CaidSpouseGetCoveredGroup = SSI Recipient OR 1619b) AND (SpouseSsiOrCaidEarnAmt  > VA_RateSsiCaidMonthlyThresholdAmt)
@SpouseIndividThreshold = Question.new(:display_rules => 'always', :default_answer => 'No',                  :reference_id =>   '104',   :question_type => 'select',       :answer_choices => 'Yes, No',                          :order => 3,    :group_id => @Spouse_Earned_Income.id)
@SpouseIndividThreshold.name = 'SpouseIndividThreshold'
@SpouseIndividThreshold.text = 'Spouse Individualized Threshold:  Has an individualized earnings threshold been established for your spouse (above which your spouse loses 1619(b) Medicaid coverage)?'
#If (VA_CaidSpouseGetCoveredGroup = SSI Recipient OR 1619b) AND (SpouseSsiOrCaidEarnAmt  > VA_RateSsiCaidMonthlyThresholdAmt)
# revised display rule on 10/19/2010
#If (SpouseSsiGet = Y OR VA_CaidSpouseGetCoveredGroup =  1619b) AND (SpouseSsiOrCaidEarnAmt  > VA_RateSsiCaidMonthlyThresholdAmt)
#30 review
#If (SpouseSsiGet = Y OR VA_CaidSpouseGetCoveredGroup =  1619b) AND (SpouseSsiOrCaidEarnAmt  > VA_RateSsiCaidMonthlyThresholdAmt)

@SpouseIndividThreshold.display_rules = "
SpouseSsiGet = manager.get_answer_by_question_name('SpouseSsiGet')
VA_CaidSpouseGetCoveredGroup = manager.get_answer_by_question_name('VA_CaidSpouseGetCoveredGroup')
SpouseSsiOrCaidEarnAmt = manager.get_answer_by_question_name('SpouseSsiOrCaidEarnAmt')
if SpouseSsiOrCaidEarnAmt != nil then
  SpouseSsiOrCaidEarnAmt = Float(SpouseSsiOrCaidEarnAmt)
  else
    SpouseSsiOrCaidEarnAmt = 0
end
VA_RateSsiCaidMonthlyThresholdAmt = 30699
(((SpouseSsiGet == 'Yes') || (VA_CaidSpouseGetCoveredGroup == '1619b')) && (SpouseSsiOrCaidEarnAmt > VA_RateSsiCaidMonthlyThresholdAmt))
"
@SpouseIndividThreshold.save!


#26	110	How much is your spouse's individualized earnings threshold (annual amount)?	
#SpouseAnnualIndividThresholdAmt			Number < RateSsiCaidMonthlyThresholdTbl * 12 for State	Your spouse's Individualized Threshold amount must be larger than the annual threshold amount for your state (VA_RateSsiCaidMonthlyThresholdAmt).  Enter numbers only.  Do not enter $ or decimal point.	0.00	If SpouseIndividThreshold = Y
@SpouseAnnualIndividThresholdAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '110',   :question_type => 'text_field',       :answer_choices => '',                          :order => 4,    :group_id => @Spouse_Earned_Income.id)
@SpouseAnnualIndividThresholdAmt.name = 'SpouseAnnualIndividThresholdAmt'
@SpouseAnnualIndividThresholdAmt.text = 'How much is your spouse\'s individualized earnings threshold (annual amount)?'
# If SpouseIndividThreshold = Y
@SpouseAnnualIndividThresholdAmt.display_rules = "
SpouseIndividThreshold = manager.get_answer_by_question_name('SpouseIndividThreshold')
SpouseIndividThreshold == 'Yes'
"
#NOTE Rate Hardwire
@SpouseAnnualIndividThresholdAmt.validation_rules = "
VA_RateSsiCaidMonthlyThresholdAmt = 30600
answer = manager.get_answer_by_question_name(self.name)
if answer != nil then
    true if (Float(answer) > VA_RateSsiCaidMonthlyThresholdAmt) rescue false
  else 
    true
end
"
@SpouseAnnualIndividThresholdAmt.validation_message = "Your spouse's Individualized Threshold amount must be larger than the annual threshold amount for your state, " + "$30600.00"

@SpouseAnnualIndividThresholdAmt.save!


#25	111	EXPENSES	Tab5_Expenses						Active if any included Sub-tabs are active and as described in WW-Web Behavior.doc	
#25	112	Work Expenses	SubTab5_1_WorkExp						Active if any included questions appear and as described in WW-Web Behavior.doc	
#25	113	What is the monthly amount of your disability-related work expenses?	
#DisWorkExpAmt			Zero or Positive Number  	Enter numbers only.  Do not enter $ or decimal point.	0.00	If SsdiEarnAmt > 0 OR SsiOrCaidEarnAmt > 0	Appear
@DisWorkExpAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '113',   :question_type => 'text_field',       :answer_choices => '',                          :order => 1,    :group_id => @Work_Expenses.id)
@DisWorkExpAmt.name = 'DisWorkExpAmt'
@DisWorkExpAmt.text = 'What is the monthly amount of your disability-related work expenses?'
# If SsdiEarnAmt > 0 OR SsiOrCaidEarnAmt > 0

@DisWorkExpAmt.display_rules = "
SsdiEarnAmt = manager.get_answer_by_question_name('SsdiEarnAmt').to_f
SsiOrCaidEarnAmt = manager.get_answer_by_question_name('SsiOrCaidEarnAmt').to_f
#if SsdiEarnAmt != nil then
#  SsdiEarnAmt = Float(SsdiEarnAmt)
#else 
#  SsdiEarnAmt = 0
#end
#if SsiOrCaidEarnAmt != nil then
#  SsiOrCaidEarnAmt = Float(SsiOrCaidEarnAmt)
#else
#  SsiOrCaidEarnAmt = 0
#end
(SsdiEarnAmt > 0 ) || (SsiOrCaidEarnAmt > 0 )
"
@DisWorkExpAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
if answer != nil then
    true if (Float(answer) >= 0) rescue false
  else 
    true
end
"
@DisWorkExpAmt.validation_message = "Enter positive numbers only.  Do not enter $."
@DisWorkExpAmt.save!

#25	114	How much are your spouse's monthly disability-related work expenses?	SpouseDisWorkExpAmt			Zero or Positive Number  	Enter numbers only.  Do not enter $ or decimal point.	0.00	If SpouseSsdiEarnAmt > 0 OR SpouseSsiOrCaidEarnAmt > 0
@SpouseDisWorkExpAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '114',   :question_type => 'text_field',       :answer_choices => '',                          :order => 2,    :group_id => @Work_Expenses.id)
@SpouseDisWorkExpAmt.name = 'SpouseDisWorkExpAmt'
@SpouseDisWorkExpAmt.text = 'How much are your spouse\'s monthly disability-related work expenses??'
#If SpouseSsdiEarnAmt > 0 OR SpouseSsiOrCaidEarnAmt > 0
@SpouseDisWorkExpAmt.display_rules = "
SpouseSsdiEarnAmt = manager.get_answer_by_question_name('SpouseSsdiEarnAmt').to_f
SpouseSsiOrCaidEarnAmt = manager.get_answer_by_question_name('SpouseSsiOrCaidEarnAmt').to_f
#if SpouseSsdiEarnAmt != nil then
#  SpouseSsdiEarnAmt = Float(SpouseSsdiEarnAmt)
#else 
#  SpouseSsdiEarnAmt = 0
#end
#if SpouseSsiOrCaidEarnAmt != nil then
#  SpouseSsiOrCaidEarnAmt = Float(SpouseSsiOrCaidEarnAmt)
#else
#  SpouseSsiOrCaidEarnAmt = 0
#end
(SpouseSsdiEarnAmt > 0 ) || (SpouseSsiOrCaidEarnAmt > 0 )
"
@SpouseDisWorkExpAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
if answer != nil then
    true if (Float(answer) >= 0) rescue false
  else 
    true
end
"
@SpouseDisWorkExpAmt.validation_message = "Enter positive numbers only.  Do not enter $."
@SpouseDisWorkExpAmt.save!

#25	115	How much are the monthly estimated taxes on your earnings?	
#EstEarnTaxAmt			Zero or Positive Number  	Enter numbers only.  Do not enter $ or decimal point.	0.00	If SsdiEarnAmt > 0 OR SsiOrCaidEarnAmt > 0
@EstEarnTaxAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '115',   :question_type => 'text_field',       :answer_choices => '',                          :order => 3,    :group_id => @Work_Expenses.id)
@EstEarnTaxAmt.name = 'EstEarnTaxAmt'
@EstEarnTaxAmt.text = 'How much are the monthly estimated taxes on your earnings?'
# If SsdiEarnAmt > 0 OR SsiOrCaidEarnAmt > 0
@EstEarnTaxAmt.display_rules = "
SsdiEarnAmt = manager.get_answer_by_question_name('SsdiEarnAmt').to_f
SsiOrCaidEarnAmt = manager.get_answer_by_question_name('SsiOrCaidEarnAmt').to_f
#if SsdiEarnAmt != nil then
#  SsdiEarnAmt = Float(SsdiEarnAmt)
#else 
#  SsdiEarnAmt = 0
#end
#if SsiOrCaidEarnAmt != nil then
#  SsiOrCaidEarnAmt = Float(SsiOrCaidEarnAmt)
#else
#  SsiOrCaidEarnAmt = 0
#end
(SsdiEarnAmt > 0 ) || (SsiOrCaidEarnAmt > 0 )
"
@EstEarnTaxAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
if answer != nil then
    true if (Float(answer) >= 0) rescue false
  else 
    true
end
"
@EstEarnTaxAmt.validation_message = "Enter positive numbers only.  Do not enter $."
@EstEarnTaxAmt.save!

#25	116	How much are your spouse's monthly estimated taxes on earnings?	
#SpouseEstEarnTaxAmt			Zero or Positive Number  	Enter numbers only.  Do not enter $ or decimal point.	0.00	If SpouseSsdiEarnAmt > 0 OR  SpouseSsiOrCaidEarnAmt > 0	Appear	50.00
@SpouseEstEarnTaxAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '116',   :question_type => 'text_field',       :answer_choices => '',                          :order => 4,    :group_id => @Work_Expenses.id)
@SpouseEstEarnTaxAmt.name = 'SpouseEstEarnTaxAmt'
@SpouseEstEarnTaxAmt.text = 'How much are your spouse\'s monthly estimated taxes on earnings?'
#If SpouseSsdiEarnAmt > 0 OR SpouseSsiOrCaidEarnAmt > 0
@SpouseEstEarnTaxAmt.display_rules = "
SpouseSsdiEarnAmt = manager.get_answer_by_question_name('SpouseSsdiEarnAmt').to_f
SpouseSsiOrCaidEarnAmt = manager.get_answer_by_question_name('SpouseSsiOrCaidEarnAmt').to_f
#if SpouseSsdiEarnAmt != nil then
#  SpouseSsdiEarnAmt = Float(SpouseSsdiEarnAmt)
#else 
#  SpouseSsdiEarnAmt = 0
#end
#if SpouseSsiOrCaidEarnAmt != nil then
#  SpouseSsiOrCaidEarnAmt = Float(SpouseSsiOrCaidEarnAmt)
#else
#  SpouseSsiOrCaidEarnAmt = 0
#end
(SpouseSsdiEarnAmt > 0 ) || (SpouseSsiOrCaidEarnAmt > 0 )
"
@SpouseEstEarnTaxAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
if answer != nil then
    true if (Float(answer) >= 0) rescue false
  else 
    true
end
"
@SpouseEstEarnTaxAmt.validation_message = "Enter positive numbers only.  Do not enter $."
@SpouseEstEarnTaxAmt.save!

#25	117	What is the monthly amount of other work expenses that you have?	
#OthWorkExpAmt			Zero or Positive Number  	Enter numbers only.  Do not enter $ or decimal point.	0.00	If SsdiEarnAmt > 0 OR SsiOrCaidEarnAmt > 0	Appear
@OthWorkExpAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '117',   :question_type => 'text_field',       :answer_choices => '',                          :order => 5,    :group_id => @Work_Expenses.id)
@OthWorkExpAmt.name = 'OthWorkExpAmt'
@OthWorkExpAmt.text = 'What is the monthly amount of other work expenses that you have?'
# If SsdiEarnAmt > 0 OR SsiOrCaidEarnAmt > 0
@OthWorkExpAmt.display_rules = "
SsdiEarnAmt = manager.get_answer_by_question_name('SsdiEarnAmt').to_f
SsiOrCaidEarnAmt = manager.get_answer_by_question_name('SsiOrCaidEarnAmt').to_f
#if SsdiEarnAmt != nil then
#  SsdiEarnAmt = Float(SsdiEarnAmt)
#else 
#  SsdiEarnAmt = 0
#end
#if SsiOrCaidEarnAmt != nil then
#  SsiOrCaidEarnAmt = Float(SsiOrCaidEarnAmt)
##else
#  SsiOrCaidEarnAmt = 0
#end
(SsdiEarnAmt > 0 ) || (SsiOrCaidEarnAmt > 0 )
"
@OthWorkExpAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
if answer != nil then
    true if (Float(answer) >= 0) rescue false
  else 
    true
end
"
@OthWorkExpAmt.validation_message = "Enter positive numbers only.  Do not enter $."
@OthWorkExpAmt.save!

#25	118	What is the monthly amount of other work expenses that your spouse has?	
#SpouseOthWorkExpAmt			Zero or Positive Number  	Enter numbers only.  Do not enter $ or decimal point.	0.00	If SpouseSsdiEarnAmt > 0 OR  SpouseSsiOrCaidEarnAmt > 0	Appear
@SpouseOthWorkExpAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '118',   :question_type => 'text_field',       :answer_choices => '',                          :order => 6,    :group_id => @Work_Expenses.id)
@SpouseOthWorkExpAmt.name = 'SpouseOthWorkExpAmt'
@SpouseOthWorkExpAmt.text = 'What is the monthly amount of other work expenses that your spouse has?'
#If SpouseSsdiEarnAmt > 0 OR SpouseSsiOrCaidEarnAmt > 0
@SpouseOthWorkExpAmt.display_rules = "
SpouseSsdiEarnAmt = manager.get_answer_by_question_name('SpouseSsdiEarnAmt').to_f
SpouseSsiOrCaidEarnAmt = manager.get_answer_by_question_name('SpouseSsiOrCaidEarnAmt').to_f
#if SpouseSsdiEarnAmt != nil then
#  SpouseSsdiEarnAmt = Float(SpouseSsdiEarnAmt)
#else 
#  SpouseSsdiEarnAmt = 0
#end
#if SpouseSsiOrCaidEarnAmt != nil then
#  SpouseSsiOrCaidEarnAmt = Float(SpouseSsiOrCaidEarnAmt)
#else
#  SpouseSsiOrCaidEarnAmt = 0
#end
(SpouseSsdiEarnAmt > 0 ) || (SpouseSsiOrCaidEarnAmt > 0 )
"
@SpouseOthWorkExpAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
if answer != nil then
    true if (Float(answer) >= 0) rescue false
  else 
    true
end
"
@SpouseOthWorkExpAmt.validation_message = "Enter positive numbers only.  Do not enter $."
@SpouseOthWorkExpAmt.save!

#25	119	Other Expenses	SubTab5_3_OtherExpenses						Active if any included questions appear and as described in WW-Web Behavior.doc	
#25	120	How much does the facility or home charge you monthly for room, board and services?	
#VA_AuxGrantFacilityRateAmt			Zero or positve number 	Enter numbers only.  Do not enter $ or decimal point.	EXPRESSION: IF VA_CityCounty = Arlington OR Louden OR Prince William OR Fairfax OR Alexandria, THEN VA_RateMaxAuxGrantFaciltyRatePd8Amt, ELSE VA_RateMaxAuxGrantFaciltyRateElseAmt	If VA_LiveInAuxGrantFacility = Y AND CaidResourceLimitExceed <> Y	What is the monthly amount of other work expenses that your spouse has?
@VA_AuxGrantFacilityRateAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '120',   :question_type => 'text_field',       :answer_choices => '',                          :order => 1,    :group_id => @Other_Expenses.id)
@VA_AuxGrantFacilityRateAmt.name = 'VA_AuxGrantFacilityRateAmt'
@VA_AuxGrantFacilityRateAmt.text = 'How much does the facility or home charge you monthly for room, board and services?'
#If VA_LiveInAuxGrantFacility = Y AND CaidResourceLimitExceed <> Y
@VA_AuxGrantFacilityRateAmt.display_rules = "
VA_LiveInAuxGrantFacility = manager.get_answer_by_question_name('VA_LiveInAuxGrantFacility')
CaidResourceLimitExceed = manager.get_answer_by_question_name('CaidResourceLimitExceed')
(VA_LiveInAuxGrantFacility == 'Yes') && (CaidResourceLimitExceed != 'Yes' )
"
@VA_AuxGrantFacilityRateAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
if answer != nil then
    true if (Float(answer) >= 0) rescue false
  else 
    true
end
"
@VA_AuxGrantFacilityRateAmt.validation_message = "Enter positive numbers only.  Do not enter $."
#xx 
## THis ain't working need to be able to calcualte a number here, more than input text
#NOTE RATE Hardwire 
@VA_AuxGrantFacilityRateAmt.default_answer = "
VA_RateMaxAuxGrantFaciltyRatePd8Amt = 605
VA_RateMaxAuxGrantFaciltyRateElseAmt = 438
VA_CityCounty = manager.get_answer_by_question_name('VA_CityCounty')
if VA_CityCounty == 'Arlington' || VA_CityCounty == 'Louden' || VA_CityCounty == 'Prince William' || VA_CityCounty == 'Fairfax' || VA_CityCounty == 'Alexandria' then
  VA_RateMaxAuxGrantFaciltyRatePd8Amt 
else
  VA_RateMaxAuxGrantFaciltyRateElseAmt
end
"
@VA_AuxGrantFacilityRateAmt.save!


#25	121	How much does the facility or home charge you and your spouse monthly for room, board and services?	
#VA_CoupleAuxGrantFacilityRateAmt			Zero or Positive Number  	Enter numbers only.  Do not enter $ or decimal point.	EXPRESSION: IF VA_CityCounty = Arlington OR Louden OR Prince William OR Fairfax OR Alexandria, THEN VA_RateCoupleMaxAuxGrantFaciltyRatePd8Amt, ELSE VA_RateCoupleMaxAuxGrantFaciltyRateElseAmt	If VA_LiveWithSpouseAuxGrantFacility = Y AND CaidCoupleResourceLimitExceed <> Y	no
@VA_CoupleAuxGrantFacilityRateAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '121',   :question_type => 'text_field',       :answer_choices => '',                          :order => 2,    :group_id => @Other_Expenses.id)
@VA_CoupleAuxGrantFacilityRateAmt.name = 'VA_CoupleAuxGrantFacilityRateAmt'
@VA_CoupleAuxGrantFacilityRateAmt.text = 'How much does the facility or home charge you and your spouse monthly for room, board and services?'
#If VA_LiveWithSpouseAuxGrantFacility = Y AND CaidCoupleResourceLimitExceed <> Y
@VA_CoupleAuxGrantFacilityRateAmt.display_rules = "
VA_LiveWithSpouseAuxGrantFacility = manager.get_answer_by_question_name('VA_LiveWithSpouseAuxGrantFacility')
CaidCoupleResourceLimitExceed = manager.get_answer_by_question_name('CaidCoupleResourceLimitExceed')
(VA_LiveWithSpouseAuxGrantFacility == 'Yes') && (CaidCoupleResourceLimitExceed != 'Yes' )
"
@VA_CoupleAuxGrantFacilityRateAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
if answer != nil then
    true if (Float(answer) >= 0) rescue false
  else 
    true
end
"
@VA_CoupleAuxGrantFacilityRateAmt.validation_message = "Enter positive numbers only.  Do not enter $."
@VA_CoupleAuxGrantFacilityRateAmt.save!

#25	122	Estimate your own monthly medical expenses with Medicaid coverage.	
#EstMedExpWithCaidAmt			Zero or Positive Number  	Enter numbers only.  Do not enter $ or decimal point.	0.00	IF (CaidGet = Y OR CaidApply = Y) AND CaidResourceLimitExceed <> Y AND CaidCoupleResourceLimitExceed <> Y	Appear
@EstMedExpWithCaidAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '122',   :question_type => 'text_field',       :answer_choices => '',                          :order => 3,    :group_id => @Other_Expenses.id)
@EstMedExpWithCaidAmt.name = 'EstMedExpWithCaidAmt'
@EstMedExpWithCaidAmt.text = 'Estimate your own monthly medical expenses with Medicaid coverage.'
#IF (CaidGet = Y OR CaidApply = Y) AND CaidResourceLimitExceed <> Y AND CaidCoupleResourceLimitExceed <> Y
@EstMedExpWithCaidAmt.display_rules = "
CaidGet = manager.get_answer_by_question_name('CaidGet')
CaidApply = manager.get_answer_by_question_name('CaidApply')
CaidResourceLimitExceed = manager.get_answer_by_question_name('CaidResourceLimitExceed')
CaidCoupleResourceLimitExceed = manager.get_answer_by_question_name('CaidCoupleResourceLimitExceed')
(CaidGet == 'Yes' || CaidApply == 'Yes') && CaidResourceLimitExceed != 'Yes' && CaidCoupleResourceLimitExceed != 'Yes'
"
@EstMedExpWithCaidAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
if answer != nil then
    true if (Float(answer) >= 0) rescue false
  else 
    true
end
"
@EstMedExpWithCaidAmt.validation_message = "Enter positive numbers only.  Do not enter $."
@EstMedExpWithCaidAmt.save!

#25	123	Estimate your own monthly medical expenses without Medicaid coverage.	
#EstMedExpWithoutCaidAmt			Zero or Positive Number  	Enter numbers only.  Do not enter $ or decimal point.	0.00	If SsiGet Y OR DiGet OR CaidGet = Y OR CaidApply = Y	Appear
@EstMedExpWithoutCaidAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '123',   :question_type => 'text_field',       :answer_choices => '',                          :order => 4,    :group_id => @Other_Expenses.id)
@EstMedExpWithoutCaidAmt.name = 'EstMedExpWithoutCaidAmt'
@EstMedExpWithoutCaidAmt.text = 'Estimate your own monthly medical expenses without Medicaid coverage.'
#If SsiGet Y OR DiGet OR CaidGet = Y OR CaidApply = Y
@EstMedExpWithoutCaidAmt.display_rules = "
SsiGet = manager.get_answer_by_question_name('SsiGet')
DiGet = manager.get_answer_by_question_name('DiGet')
CaidGet = manager.get_answer_by_question_name('CaidGet')
CaidApply = manager.get_answer_by_question_name('CaidApply')
( SsiGet == 'Yes' ) || (DiGet == 'Yes' ) || ( CaidGet == 'Yes' ) || ( CaidApply == 'Yes' )
"
@EstMedExpWithoutCaidAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
if answer != nil then
    true if (Float(answer) >= 0) rescue false
  else 
    true
end
"
@EstMedExpWithoutCaidAmt.validation_message = "Enter positive numbers only.  Do not enter $."
@EstMedExpWithoutCaidAmt.save!

#25	124	Estimate your spouse's monthly medical expenses with Medicaid coverage.	
#SpouseEstMedExpWithCaidAmt			Zero or Positive Number  	Enter numbers only.  Do not enter $ or decimal point.	0.00	IF (CaidSpouseGet = Y OR CaidSpouseApply = Y) AND CaidCoupleResourceLimitExceed <>Y	Appear
@SpouseEstMedExpWithCaidAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '124',   :question_type => 'text_field',       :answer_choices => '',                          :order => 5,    :group_id => @Other_Expenses.id)
@SpouseEstMedExpWithCaidAmt.name = 'SpouseEstMedExpWithCaidAmt'
@SpouseEstMedExpWithCaidAmt.text = 'Estimate your spouse\'s monthly medical expenses with Medicaid coverage'
#IF (CaidSpouseGet = Y OR CaidSpouseApply = Y) AND CaidCoupleResourceLimitExceed <>Y
@SpouseEstMedExpWithCaidAmt.display_rules = "
CaidSpouseGet = manager.get_answer_by_question_name('CaidSpouseGet')
CaidSpouseApply = manager.get_answer_by_question_name('CaidSpouseApply')
CaidCoupleResourceLimitExceed = manager.get_answer_by_question_name('CaidCoupleResourceLimitExceed')
(CaidSpouseGet == 'Yes' || CaidSpouseApply == 'Yes') && CaidCoupleResourceLimitExceed != 'Yes'
"
@SpouseEstMedExpWithCaidAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
if answer != nil then
    true if (Float(answer) >= 0) rescue false
  else 
    true
end
"
@SpouseEstMedExpWithCaidAmt.validation_message = "Enter positive numbers only.  Do not enter $."
@SpouseEstMedExpWithCaidAmt.save!

#25	125	Estimate your spouse's monthly medical expenses without Medicaid coverage.	
#SpouseEstMedExpWithoutCaidAmt			Zero or Positive Number  	Enter numbers only.  Do not enter $ or decimal point.	0.00	IF SpouseSsiGet = Y OR CaidSpouseGet = Y OR CaidSpouseApply = Y	Appear
@SpouseEstMedExpWithoutCaidAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '125',   :question_type => 'text_field',       :answer_choices => '',                          :order => 6,    :group_id => @Other_Expenses.id)
@SpouseEstMedExpWithoutCaidAmt.name = 'SpouseEstMedExpWithoutCaidAmt'
@SpouseEstMedExpWithoutCaidAmt.text = 'Estimate your spouse\'s monthly medical expenses without Medicaid coverage.'
#IF SpouseSsiGet = Y OR CaidSpouseGet = Y OR CaidSpouseApply = Y
@SpouseEstMedExpWithoutCaidAmt.display_rules = "
SpouseSsiGet = manager.get_answer_by_question_name('SpouseSsiGet')
CaidSpouseGet = manager.get_answer_by_question_name('CaidSpouseGet')
CaidSpouseApply = manager.get_answer_by_question_name('CaidSpouseApply')
SpouseSsiGet == 'Yes' || CaidSpouseGet == 'Yes' || CaidSpouseApply == 'Yes'
"
@SpouseEstMedExpWithoutCaidAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
if answer != nil then
    true if (Float(answer) >= 0) rescue false
  else 
    true
end
"
@SpouseEstMedExpWithoutCaidAmt.validation_message = "Enter positive numbers only.  Do not enter $."
@SpouseEstMedExpWithoutCaidAmt.save!


#25	126	Estimate the monthly amount of any other expenses you want to include in WW-Web calculations	
#OtherExpAmt			Zero or Positive Number  	Enter numbers only.  Do not enter $ or decimal point.	0.00	If SsiGet Y OR DiGet OR CaidGet = Y OR CaidApply = Y	Appear
@OtherExpAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '126',   :question_type => 'text_field',       :answer_choices => '',                          :order => 7,    :group_id => @Other_Expenses.id)
@OtherExpAmt.name = 'OtherExpAmt'
@OtherExpAmt.text = 'Estimate the monthly amount of any other expenses you want to include in WW-Web calculations'
  #If If SsiGet Y OR DiGet OR CaidGet = Y OR CaidApply = Y
@OtherExpAmt.display_rules = "
SsiGet = manager.get_answer_by_question_name('SsiGet')
DiGet = manager.get_answer_by_question_name('DiGet')
CaidGet = manager.get_answer_by_question_name('CaidGet')
CaidApply = manager.get_answer_by_question_name('CaidApply')
SsiGet == 'Yes' || DiGet == 'Yes' || CaidGet == 'Yes' || CaidApply == 'Yes'
"
@OtherExpAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
if answer != nil then
    true if (Float(answer) >= 0) rescue false
  else 
    true
end
"
@OtherExpAmt.validation_message = "Enter positive numbers only.  Do not enter $."

@OtherExpAmt.save!

#25	127	Estimate the monthly amount of any other of your spouse's expenses you want to include in WW-Web calculations.	
#SpouseOtherExpAmt			Zero or Positive Number  	Enter numbers only.  Do not enter $ or decimal point.	0.00	 If SpouseSsiGet = Y OR CaidSpouseGet = Y OR CaidSpouseApply = Y
@SpouseOtherExpAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '127',   :question_type => 'text_field',       :answer_choices => '',                          :order => 8,    :group_id => @Other_Expenses.id)
@SpouseOtherExpAmt.name = 'SpouseOtherExpAmt'
@SpouseOtherExpAmt.text = 'Estimate the monthly amount of any other of your spouse\'s expenses you want to include in WW-Web calculations.'
#IF SpouseSsiGet = Y OR CaidSpouseGet = Y OR CaidSpouseApply = Y
@SpouseOtherExpAmt.display_rules = "
SpouseSsiGet = manager.get_answer_by_question_name('SpouseSsiGet')
CaidSpouseGet = manager.get_answer_by_question_name('CaidSpouseGet')
CaidSpouseApply = manager.get_answer_by_question_name('CaidSpouseApply')
SpouseSsiGet == 'Yes' || CaidSpouseGet == 'Yes' || CaidSpouseApply == 'Yes'
"
@SpouseOtherExpAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
if answer != nil then
    true if (Float(answer) >= 0) rescue false
  else 
    true
end
"
@SpouseOtherExpAmt.validation_message = "Enter positive numbers only.  Do not enter $."

@SpouseOtherExpAmt.save!


#25	128	Employability Investments	SubTab5_2_Investments						Active if any included questions appear and as described in WW-Web Behavior.doc		
#25	129	How much are you spending and/or setting aside per month to improve your future financial self-sufficiency?	
#EmployInvestAmt			Zero or Positive Number  	Enter numbers only.  Do not enter $ or decimal point.	0.00	If SsiGet = Y AND (InKindPMVAmt + SsiParDeemAmt + SsiSpouseDeemUnearnAmt + SsdiAmtSelfFull + SsdiAmtOtherFull + UnearnAmt + SpouseUnEarnAmt + SsiSpouseDeemEarnAmt + SsiOrCaidEarnAmt + SpouseSsiOrCaidEarnAmt) > 0.00	Appear	450.00
@EmployInvestAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '129',   :question_type => 'text_field',       :answer_choices => '',                          :order => 1,    :group_id => @Employability_Investments.id)
@EmployInvestAmt.name = 'EmployInvestAmt'
@EmployInvestAmt.text = 'How much are you spending and/or setting aside per month to improve your future financial self-sufficiency?'
#If SsiGet = Y AND (InKindPMVAmt + SsiParDeemAmt + SsiSpouseDeemUnearnAmt + SsdiAmtSelfFull + SsdiAmtOtherFull + UnearnAmt + SpouseUnEarnAmt + SsiSpouseDeemEarnAmt + SsiOrCaidEarnAmt + SpouseSsiOrCaidEarnAmt) > 0.00
@EmployInvestAmt.display_rules = "
SsiGet = manager.get_answer_by_question_name('SsiGet')
InKindPMVAmt = manager.get_answer_by_question_name('InKindPMVAmt').to_f
SsiParDeemAmt = manager.get_answer_by_question_name('SsiParDeemAmt').to_f
SsiSpouseDeemUnearnAmt = manager.get_answer_by_question_name('SsiSpouseDeemUnearnAmt').to_f
SsdiAmtSelfFull = manager.get_answer_by_question_name('SsdiAmtSelfFull').to_f
SsdiAmtOtherFull = manager.get_answer_by_question_name('SsdiAmtOtherFull').to_f
UnearnAmt = manager.get_answer_by_question_name('UnearnAmt').to_f
SpouseUnEarnAmt = manager.get_answer_by_question_name('SpouseUnEarnAmt').to_f
SsiSpouseDeemEarnAmt = manager.get_answer_by_question_name('SsiSpouseDeemEarnAmt').to_f
SsiOrCaidEarnAmt = manager.get_answer_by_question_name('SsiOrCaidEarnAmt').to_f
SpouseSsiOrCaidEarnAmt = manager.get_answer_by_question_name('SpouseSsiOrCaidEarnAmt').to_f
#if InKindPMVAmt != nil then
#  InKindPMVAmt = Float(InKindPMVAmt)
#else 
#  InKindPMVAmt = 0
#end
#if SsiParDeemAmt != nil then
#  SsiParDeemAmt = Float(SsiParDeemAmt)
#else
#  SsiParDeemAmt = 0
#end
#if SsiSpouseDeemUnearnAmt != nil then
#  SsiSpouseDeemUnearnAmt = Float(SsiSpouseDeemUnearnAmt)
#else
#  SsiSpouseDeemUnearnAmt = 0
#end
#if SsdiAmtSelfFull != nil then
#  SsdiAmtSelfFull = Float(SsdiAmtSelfFull)
#else
#  SsdiAmtSelfFull = 0
#end
#if SsdiAmtOtherFull != nil then
#  SsdiAmtOtherFull = Float(SsdiAmtOtherFull)
#else
#  SsdiAmtOtherFull = 0
#end
#if UnearnAmt != nil then
#  UnearnAmt = Float(UnearnAmt)
#else
#  UnearnAmt = 0
#end
#if SpouseUnEarnAmt != nil then
#  SpouseUnEarnAmt = Float(SpouseUnEarnAmt)
#else
#  SpouseUnEarnAmt = 0
#end
#if SsiSpouseDeemEarnAmt != nil then
#  SsiSpouseDeemEarnAmt = Float(SsiSpouseDeemEarnAmt)
#else
#  SsiSpouseDeemEarnAmt = 0
#end
#if SsiOrCaidEarnAmt != nil then
#  SsiOrCaidEarnAmt = Float(SsiOrCaidEarnAmt)
#else
#  SsiOrCaidEarnAmt = 0
#end
#if SpouseSsiOrCaidEarnAmt != nil then
#  SpouseSsiOrCaidEarnAmt = Float(SpouseSsiOrCaidEarnAmt)
#else
#  SpouseSsiOrCaidEarnAmt = 0
#end
SsiGet == 'Yes' && ((InKindPMVAmt + SsiParDeemAmt + SsiSpouseDeemUnearnAmt + SsdiAmtSelfFull + SsdiAmtOtherFull + UnearnAmt + SpouseUnEarnAmt + SsiSpouseDeemEarnAmt + SsiOrCaidEarnAmt + SpouseSsiOrCaidEarnAmt) > 0)
"
@EmployInvestAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
if answer != nil then
    true if (Float(answer) >= 0) rescue false
  else 
    true
end
"
@EmployInvestAmt.validation_message = "Enter positive numbers only.  Do not enter $."
@EmployInvestAmt.save!


#25	130	How much is your spouse spending and/or setting aside per month to improve future financial self-sufficiency?	
#SpouseEmployInvestAmt			Zero or Positive Number  	Enter numbers only.  Do not enter $ or decimal point.	0.00	If SpouseSsiGet = Y AND (InKindPMVAmt + SsiParDeemAmt + SsiSpouseDeemUnearnAmt + SsdiAmtSelfFull + SsdiAmtOtherFull + UnearnAmt + SpouseUnEarnAmt + SsiSpouseDeemEarnAmt + SsiOrCaidEarnAmt + SpouseSsiOrCaidEarnAmt - EmployInvestAmt) > 0.00
#SpouseEmployInvestAmt			Zero or Positive Number  	Enter numbers only.  Do not enter $ or decimal point.	0.00	If SsiGet = Y AND (InKindPMVAmt + SsiParDeemAmt + SsiSpouseDeemUnearnAmt + SsdiAmtSelfFull + SsdiAmtOtherFull + UnearnAmt + SpouseUnEarnAmt + SsiSpouseDeemEarnAmt + SsiOrCaidEarnAmt + SpouseSsiOrCaidEarnAmt) > 0.00	Appear	450.00
@SpouseEmployInvestAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '129',   :question_type => 'text_field',       :answer_choices => '',                          :order => 1,    :group_id => @Employability_Investments.id)
@SpouseEmployInvestAmt.name = 'SpouseEmployInvestAmt'
@SpouseEmployInvestAmt.text = 'How much is your spouse spending and/or setting aside per month to improve future financial self-sufficiency?'
#If SpouseSsiGet = Y AND (InKindPMVAmt + SsiParDeemAmt + SsiSpouseDeemUnearnAmt + SsdiAmtSelfFull + SsdiAmtOtherFull + UnearnAmt + SpouseUnEarnAmt + SsiSpouseDeemEarnAmt + SsiOrCaidEarnAmt + SpouseSsiOrCaidEarnAmt - EmployInvestAmt) > 0.00
@SpouseEmployInvestAmt.display_rules = "
SpouseSsiGet = manager.get_answer_by_question_name('SpouseSsiGet')
InKindPMVAmt = manager.get_answer_by_question_name('InKindPMVAmt').to_f
SsiParDeemAmt = manager.get_answer_by_question_name('SsiParDeemAmt').to_f
SsiSpouseDeemUnearnAmt = manager.get_answer_by_question_name('SsiSpouseDeemUnearnAmt').to_f
SsdiAmtSelfFull = manager.get_answer_by_question_name('SsdiAmtSelfFull').to_f
SsdiAmtOtherFull = manager.get_answer_by_question_name('SsdiAmtOtherFull').to_f
UnearnAmt = manager.get_answer_by_question_name('UnearnAmt').to_f
SpouseUnEarnAmt = manager.get_answer_by_question_name('SpouseUnEarnAmt').to_f
SsiSpouseDeemEarnAmt = manager.get_answer_by_question_name('SsiSpouseDeemEarnAmt').to_f
SsiOrCaidEarnAmt = manager.get_answer_by_question_name('SsiOrCaidEarnAmt').to_f
SpouseSsiOrCaidEarnAmt = manager.get_answer_by_question_name('SpouseSsiOrCaidEarnAmt').to_f
EmployInvestAmt = manager.get_answer_by_question_name('EmployInvestAmt').to_f
#if InKindPMVAmt != nil then
#  InKindPMVAmt = Float(InKindPMVAmt)
#else 
#  InKindPMVAmt = 0
#end
#if SsiParDeemAmt != nil then
#  SsiParDeemAmt = Float(SsiParDeemAmt)
#else
#  SsiParDeemAmt = 0
#end
#if SsiSpouseDeemUnearnAmt != nil then
#  SsiSpouseDeemUnearnAmt = Float(SsiSpouseDeemUnearnAmt)
#else
#  SsiSpouseDeemUnearnAmt = 0
#end
#if SsdiAmtSelfFull != nil then
#  SsdiAmtSelfFull = Float(SsdiAmtSelfFull)
#else
#  SsdiAmtSelfFull = 0
#end
#if SsdiAmtOtherFull != nil then
#  SsdiAmtOtherFull = Float(SsdiAmtOtherFull)
#else
#  SsdiAmtOtherFull = 0
#end
#if UnearnAmt != nil then
#  UnearnAmt = Float(UnearnAmt)
#else
#  UnearnAmt = 0
#end
#if SpouseUnEarnAmt != nil then
#  SpouseUnEarnAmt = Float(SpouseUnEarnAmt)
#else
#  SpouseUnEarnAmt = 0
#end
#if SsiSpouseDeemEarnAmt != nil then
#  SsiSpouseDeemEarnAmt = Float(SsiSpouseDeemEarnAmt)
#else
#  SsiSpouseDeemEarnAmt = 0
#end
#if SsiOrCaidEarnAmt != nil then
#  SsiOrCaidEarnAmt = Float(SsiOrCaidEarnAmt)
#else
#  SsiOrCaidEarnAmt = 0
#end
#if SpouseSsiOrCaidEarnAmt != nil then
#  SpouseSsiOrCaidEarnAmt = Float(SpouseSsiOrCaidEarnAmt)
#else
#  SpouseSsiOrCaidEarnAmt = 0
#end
#if EmployInvestAmt != nil then
#  EmployInvestAmt = Float(EmployInvestAmt)
#else
#  EmployInvestAmt = 0
#end
SpouseSsiGet == 'Yes' && ((InKindPMVAmt + SsiParDeemAmt + SsiSpouseDeemUnearnAmt + SsdiAmtSelfFull + SsdiAmtOtherFull + UnearnAmt + SpouseUnEarnAmt + SsiSpouseDeemEarnAmt + SsiOrCaidEarnAmt + SpouseSsiOrCaidEarnAmt - EmployInvestAmt) > 0)
"
@SpouseEmployInvestAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
if answer != nil then
    true if (Float(answer) >= 0) rescue false
  else 
    true
end
"
@SpouseEmployInvestAmt.validation_message = "Enter positive numbers only.  Do not enter $."
@SpouseEmployInvestAmt.save!

#25	131	WORK INCENTIVES	Tab6_WorkIncentives						Active if any included Sub-tabs are active and as described in WW-Web Behavior.doc		
#25	132	Student Earned Income Exclutsion (SEIE)	SubTab6_1_Seie						Active if any included questions appear and as described in WW-Web Behavior.doc		
#25	133	Are you a student?	

#Student			YES:NO		YES	If (SsiGet = Y OR CaidGet = Y OR CaidApply = Y) AND (SitDate minus BirthDate < 21) AND SsiOrCaidEarnAmt > 0	
@Student = Question.new(:display_rules => 'always', :default_answer => 'Yes',                  :reference_id =>   '133',   :question_type => 'select',       :answer_choices => 'Yes, No',                          :order => 1,    :group_id => @Student_Earned_Income_Exclutsion.id)
@Student.name = 'Student'
@Student.text = 'Are you a student?'
#If (SsiGet = Y OR CaidGet = Y OR CaidApply = Y) AND (SitDate minus BirthDate < 21) AND SsiOrCaidEarnAmt > 0
# revised display rule 10/19/2011
# IF (SsiGet = Y OR CaidGet = Y OR CaidApply = Y) AND SitDate minus BirthDate < 22 AND SsiOrCaidEarnAmt > 0

@Student.display_rules = "
unless manager.get_answer_by_question_name('SitDate').blank? || manager.get_answer_by_question_name('BirthDate').blank? 
SsiGet = manager.get_answer_by_question_name('SsiGet')
CaidGet = manager.get_answer_by_question_name('CaidGet')
CaidApply = manager.get_answer_by_question_name('CaidApply')
SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
BirthDate = Date.strptime(manager.get_answer_by_question_name('BirthDate'), '%m/%d/%Y')
SsiOrCaidEarnAmt = manager.get_answer_by_question_name('SsiOrCaidEarnAmt')
if SsiOrCaidEarnAmt != nil then
  SsiOrCaidEarnAmt = Float(SsiOrCaidEarnAmt)
else
  SsiOrCaidEarnAmt = 0
end
Age = (SitDate.year - BirthDate.year)
subyear= 0
if BirthDate.month > SitDate.month then
  subyear = 1
elsif BirthDate.month == SitDate.month then
  if BirthDate.day > SitDate.day  then
    subyear = 1
  end
end
Age = Age - subyear
((SsiGet == 'Yes' || CaidGet == 'Yes' || CaidApply == 'Yes') && (Age < 22) && (SsiOrCaidEarnAmt > 0))
else
  false
end
"
@Student.save!

#xx
#25	134	How much of your monthly earnings ($SsiOrCaidEarnAmt) are excluded as a Student Earned Income Exclusion (SEIE)?	
#SeieAmt			Zero or Positive Number <= the smaller of ((RateSEIEMaxMonthly OR SsiOrCaidEarnAmt) 	Your Student Earned Income Exclusion (SE(E) can not be greater than the smaller of the maximum monthly  exclusion (RateSEIEMaxMonthly) or your monthly earned income (SsiOrCaidEarnAmt).  Enter numbers only.  Do not enter $ or decimal point.	EXPRESSION: the smaller of ((RateSEIEMaxMonthly OR SsiOrCaidEarnAmt) 	If Student = Y
@SeieAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '129',   :question_type => 'text_field',       :answer_choices => '',                          :order => 2,    :group_id => @Student_Earned_Income_Exclutsion.id)
@SeieAmt.name = 'SeieAmt'
@SeieAmt.text = 'How much of your monthly earnings are excluded as a Student Earned Income Exclusion (SEIE)?	'
#If Student = Y
@SeieAmt.display_rules = "
Student = manager.get_answer_by_question_name('Student')
Student == 'Yes'
"
#NOTE rate hardware xx
#Zero or Positive Number <= the smaller of ((RateSEIEMaxMonthly OR SsiOrCaidEarnAmt) 

@SeieAmt.validation_rules = "
RateSEIEMaxMonthly = 1640
answer = manager.get_answer_by_question_name(self.name)
SsiOrCaidEarnAmt = manager.get_answer_by_question_name('SsiOrCaidEarnAmt')
if SsiOrCaidEarnAmt != nil then
  SsiOrCaidEarnAmt = Float(SsiOrCaidEarnAmt)
else
  SsiOrCaidEarnAmt = 0
end
if answer != nil then
    true if Float(answer) >=0  && (Float(answer) <= [RateSEIEMaxMonthly, SsiOrCaidEarnAmt].min) rescue false
  else 
    true
end
"
#NOTE hardwired rate in validation message
#Your Student Earned Income Exclusion (SE(E) can not be greater than the smaller of the maximum monthly  exclusion (RateSEIEMaxMonthly) or your monthly earned income (SsiOrCaidEarnAmt).  Enter numbers only.  Do not enter $ or decimal point.

@SeieAmt.validation_message = "Your Student Earned Income Exclusion (SEIE) can not be greater than the smaller of the maximum monthly exclusion, " + "$1,640" + ", or your monthly earned income."
@SeieAmt.save!

#25	135	Is your spouse a student?	
#SpouseStudent			YES:NO		NO	 If (SpouseSsiGet = Y OR CaidSpouseGet = Y OR CaidSpouseApply = Y) AND (SitDate minus SpouseBirthDate >= 16 AND < 21) AND (SpouseSsiOrCaidEarnAmt > 0 OR SsiSpouseDeemEarnAmt > 0 OR VA_CaidSpouseDeemEarnAmt > 0)
@SpouseStudent = Question.new(:display_rules => 'always', :default_answer => 'Yes',                  :reference_id =>   '133',   :question_type => 'select',       :answer_choices => 'Yes, No',                          :order => 3,    :group_id => @Student_Earned_Income_Exclutsion.id)
@SpouseStudent.name = 'SpouseStudent'
@SpouseStudent.text = 'Is your spouse a student?'
#If (SpouseSsiGet = Y OR CaidSpouseGet = Y OR CaidSpouseApply = Y) AND (SitDate minus SpouseBirthDate >= 16 AND < 21) AND (SpouseSsiOrCaidEarnAmt > 0 OR SsiSpouseDeemEarnAmt > 0 OR VA_CaidSpouseDeemEarnAmt > 0)
#10/19/2011 revised rule Talk to DR on phone, we can drop the > 16
#If (SpouseSsiGet = Y OR CaidSpouseGet = Y OR CaidSpouseApply = Y OR SsiSpouseDeem = Y OR VA_CaidSpouseDeem = Y) AND SitDate minus SpouseBirthDate < 22 AND SpouseSsiOrCaidEarnAmt > 0
#Fix hardwire 
#Revised display rule per email
#If (SpouseSsiGet = Y OR CaidSpouseGet = Y OR CaidSpouseApply = Y) AND SitDate minus SpouseBirthDate < 22 AND (SpouseSsiOrCaidEarnAmt > 0 OR SsiSpouseDeem = Y OR VA_CaidSpouseDeem = Y)
#review again per Workbook 30
#If (SpouseSsiGet = Y OR CaidSpouseGet = Y OR CaidSpouseApply = Y) AND SitDate minus SpouseBirthDate < 22 AND (SpouseSsiOrCaidEarnAmt > 0 OR SsiSpouseDeem = Y OR VA_CaidSpouseDeem = Y)
#Bob does still not have a handle on why the SSISpouseDeem or caid deeming are factors in this display rule.
@SpouseStudent.display_rules = "
SpouseSsiGet = manager.get_answer_by_question_name('SpouseSsiGet')
CaidSpouseGet = manager.get_answer_by_question_name('CaidSpouseGet')
CaidSpouseApply = manager.get_answer_by_question_name('CaidSpouseApply')
RSpouseAge = 20
SpouseSsiOrCaidEarnAmt = manager.get_answer_by_question_name('SpouseSsiOrCaidEarnAmt')
SsiSpouseDeem = manager.get_answer_by_question_name('SsiSpouseDeem')
VA_CaidSpouseDeem = manager.get_answer_by_question_name('VA_CaidSpouseDeem')

if SpouseSsiOrCaidEarnAmt != nil then
  SpouseSsiOrCaidEarnAmt = Float(SpouseSsiOrCaidEarnAmt)
else
  SpouseSsiOrCaidEarnAmt = 0
end

(SpouseSsiGet == 'Yes' || CaidSpouseGet = 'Yes' || CaidSpouseApply = 'Yes') && RSpouseAge < 22 &&  ((SpouseSsiOrCaidEarnAmt > 0) || SsiSpouseDeem == 'Yes' || VA_CaidSpouseDeem == 'Yes')
"
@SpouseStudent.save!

#i think this is new from 27
#27	135.5	How much does your spouse earn per month?	SpouseWhoIsDeemedEarnAmt						If SpouseStudent = Y AND (SsiSpouseDeem = Y OR VA_CaidSpouseDeem = Y) 
@SpouseWhoIsDeemedEarnAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '136',   :question_type => 'text_field',       :answer_choices => '',                          :order => 4,    :group_id => @Student_Earned_Income_Exclutsion.id)
@SpouseWhoIsDeemedEarnAmt.name = 'SpouseWhoIsDeemedEarnAmt'
@SpouseWhoIsDeemedEarnAmt.text = 'How much does your spouse earn per month?'
#If SpouseStudent = Y AND (SsiSpouseDeem = Y OR VA_CaidSpouseDeem = Y) 
#30 workbook review Nov 2 2010
#If SpouseStudent = Y AND SpouseSsiGet <> Y AND (SsiSpouseDeem = Y OR VA_CaidSpouseDeem = Y) 

@SpouseWhoIsDeemedEarnAmt.display_rules = "
SpouseStudent = manager.get_answer_by_question_name('SpouseStudent')
SpouseSsiGet = manager.get_answer_by_question_name('SpouseSsiGet')
SsiSpouseDeem = manager.get_answer_by_question_name('SsiSpouseDeem')
VA_CaidSpouseDeem = manager.get_answer_by_question_name('VA_CaidSpouseDeem')
SpouseStudent == 'Yes' && SpouseSsiGet != 'Yes' && (SsiSpouseDeem  == 'Yes' || VA_CaidSpouseDeem == 'Yes')
"
@SpouseWhoIsDeemedEarnAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
if answer != nil then
    true if (Float(answer) >= 0) rescue false
  else 
    true
end
"
@SpouseWhoIsDeemedEarnAmt.validation_message = "Enter positive numbers only.  Do not enter $."
@SpouseWhoIsDeemedEarnAmt.save!

#25	136	How much of your spouse's monthly earnings ($SpouseSsiOrCaidEarnAmt) are excluded as a Student Earned Income Exclusion (SEIE)?	
#SpouseSeieAmt			Zero or Positive Number <= the smaller of ((RateSEIEMaxMonthly - SeieAmt) OR (SpouseSsiOrCaidEarnAmt IF > 0 OR SsiSpouseDeemEarnAmt IF > 0)	Your spouse's Student Earned Income Exclusion (SE(E) can not be greater than the smaller of the maximum monthly  exclusion (RateSEIEMaxMonthly) or your spouse's monthly earned income (MAX of SpouseSsiOrCaidEarnAmt OR SsiSpouseDeemEarnAmt).  Enter numbers only.  Do not enter $ or decimal point.	EXPRESSION: the smaller of ((RateSEIEMaxMonthly - SeieAmt) OR (SpouseSsiOrCaidEarnAmt IF > 0 OR SsiSpouseDeemEarnAmt IF > 0)	If SpouseStudent = Y
@SpouseSeieAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '136',   :question_type => 'text_field',       :answer_choices => '',                          :order => 4,    :group_id => @Student_Earned_Income_Exclutsion.id)
@SpouseSeieAmt.name = 'SpouseSeieAmt'
@SpouseSeieAmt.text = 'How much of your spouse\'s monthly earnings are excluded as a Student Earned Income Exclusion (SEIE)?'
#If SpouseStudent = Y
@SpouseSeieAmt.display_rules = "
SpouseStudent = manager.get_answer_by_question_name('SpouseStudent')
SpouseStudent == 'Yes'
"
#Note to Bob Review Ruby rescue to see if we can get rid of the bad float error when text entered with tab key
#Zero or Positive Number <= the smaller of ((RateSEIEMaxMonthly - SeieAmt) OR (SpouseSsiOrCaidEarnAmt IF > 0 OR SsiSpouseDeemEarnAmt IF > 0)
@SpouseSeieAmt.validation_rules = "
RateSEIEMaxMonthly = 1640
answer = manager.get_answer_by_question_name(self.name)
SeieAmt = manager.get_answer_by_question_name('SeieAmt')
if SeieAmt != nil then
  SeieAmt = Float(SeieAmt)
else
  SeieAmt = 0
end

SpouseSsiOrCaidEarnAmt = manager.get_answer_by_question_name('SpouseSsiOrCaidEarnAmt')
SsiSpouseDeemEarnAmt = manager.get_answer_by_question_name('SsiSpouseDeemEarnAmt')
if SpouseSsiOrCaidEarnAmt != nil then
  SpouseSsiOrCaidEarnAmt = Float(SpouseSsiOrCaidEarnAmt)
else
  SpouseSsiOrCaidEarnAmt = 0
end
if SsiSpouseDeemEarnAmt != nil then
  SsiSpouseDeemEarnAmt = Float(SsiSpouseDeemEarnAmt)
else
  SsiSpouseDeemEarnAmt = 0
end

SpouseEarnings = [SpouseSsiOrCaidEarnAmt,SsiSpouseDeemEarnAmt].max

if answer != nil then
    true if (Float(answer) >= 0 && Float(answer) <= [RateSEIEMaxMonthly - SeieAmt, SpouseEarnings].min) rescue false
  else 
    true
end
"
@SpouseSeieAmt.validation_message = "Your spouse's Student Earned Income Exclusion (SEIE) can not be greater than the smaller of the maximum monthly exclusion, " + "$1,640" + ", or or your spouse\'s monthly earned income."
#Your spouse's Student Earned Income Exclusion (SEIE) can not be greater than the smaller of the maximum monthly  exclusion or your spouse's monthly earned income And the combined total of you and your spouse's SEIE can ot be less than Enter numbers only.  Do not enter $ or decimal point."
#Your spouse's Student Earned Income Exclusion (SEIE) can not be greater than the smaller of the maximum monthly  exclusion ("&$WebRates.D18&") or your spouse's monthly earned income (MAX of "&D113&" OR "&D81&").  Enter numbers only.  Do not enter $ or decimal point."
@SpouseSeieAmt.save!


#NOTE this has a reference to a Rate that needs to be fixes
#25	137	Your SEIE exclusion ($SeieAmt) is less than your earnings ($SsiOrCaidEarnAmt).  Have you used up your SEIE annual exclusion amount ($6600)?	
#SeieLessThanEarnAnnualLmtReached			YES:NO		YES	If Student = Y AND SpouseStudent <> Y AND SeieAmt > 0 AND SsiOrCaidEarnAmt <  RateSEIEMaxMonthly  AND SeieAmt < SsiOrCaidEarnAmt
@SeieLessThanEarnAnnualLmtReached = Question.new(:display_rules => 'always', :default_answer => 'Yes',                  :reference_id =>   '137',   :question_type => 'select',       :answer_choices => 'Yes, No',                          :order => 5,    :group_id => @Student_Earned_Income_Exclutsion.id)
@SeieLessThanEarnAnnualLmtReached.name = 'SeieLessThanEarnAnnualLmtReached'
@SeieLessThanEarnAnnualLmtReached.text = 'Your SEIE exclusion is less than your earnings. Have you used up your SEIE annual exclusion amount ($6600)?'
#If Student = Y AND SpouseStudent <> Y AND SeieAmt > 0 AND SsiOrCaidEarnAmt <  RateSEIEMaxMonthly  AND SeieAmt < SsiOrCaidEarnAmt
@SeieLessThanEarnAnnualLmtReached.display_rules = "
Student = manager.get_answer_by_question_name('Student')
SpouseStudent = manager.get_answer_by_question_name('SpouseStudent')
SeieAmt = manager.get_answer_by_question_name('SeieAmt')
if SeieAmt != nil then
  SeieAmt = Float(SeieAmt)
else
  SeieAmt = 0
end
SsiOrCaidEarnAmt = manager.get_answer_by_question_name('SsiOrCaidEarnAmt')
if SsiOrCaidEarnAmt != nil then
  SsiOrCaidEarnAmt = Float(SsiOrCaidEarnAmt)
else
  SsiOrCaidEarnAmt = 0
end
RateSEIEMaxMonthly = 1640
(Student == 'Yes') && (SpouseStudent != 'Yes') && (SeieAmt > 0) && (SsiOrCaidEarnAmt <  RateSEIEMaxMonthly) && (SeieAmt < SsiOrCaidEarnAmt)
"
@SeieLessThanEarnAnnualLmtReached.save!


#25	138	Your SEIE exclusion ($SeieAmt) is less than the SEIE Monthly Maximum Exclusion ($RateSEIEMaxMonthly).  Have you used up your SEIE annual exclusion amount ($6600)?	
#SeieLessThanSeieMaxAnnualLmtReached			YES:NO		YES	If Student = Y AND SpouseStudent <> Y AND SeieAmt > 0 AND SsiOrCaidEarnAmt >RateSEIEMaxMonthly  AND SeieAmt < RateSEIEMaxMonthly
@SeieLessThanSeieMaxAnnualLmtReached = Question.new(:display_rules => 'always', :default_answer => 'Yes',                  :reference_id =>   '138',   :question_type => 'select',       :answer_choices => 'Yes, No',                          :order => 6,    :group_id => @Student_Earned_Income_Exclutsion.id)
@SeieLessThanSeieMaxAnnualLmtReached.name = 'SeieLessThanSeieMaxAnnualLmtReached'
@SeieLessThanSeieMaxAnnualLmtReached.text = 'Your SEIE exclusion is less than the SEIE Monthly Maximum Exclusion.  Have you used up your SEIE annual exclusion amount ($6600)?'
#If Student = Y AND SpouseStudent <> Y AND SeieAmt > 0 AND SsiOrCaidEarnAmt >RateSEIEMaxMonthly  AND SeieAmt < RateSEIEMaxMonthly  BOB is taking a long look at this rule but letting it go for now
@SeieLessThanSeieMaxAnnualLmtReached.display_rules = "
Student = manager.get_answer_by_question_name('Student')
SpouseStudent = manager.get_answer_by_question_name('SpouseStudent')
SeieAmt = manager.get_answer_by_question_name('SeieAmt')
if SeieAmt != nil then
  SeieAmt = Float(SeieAmt)
else
  SeieAmt = 0
end
SsiOrCaidEarnAmt = manager.get_answer_by_question_name('SsiOrCaidEarnAmt')
if SsiOrCaidEarnAmt != nil then
  SsiOrCaidEarnAmt = Float(SsiOrCaidEarnAmt)
else
  SsiOrCaidEarnAmt = 0
end
RateSEIEMaxMonthly = 1640
(Student == 'Yes') && (SpouseStudent != 'Yes') && (SeieAmt > 0) && (SsiOrCaidEarnAmt >  RateSEIEMaxMonthly) && (SeieAmt <  RateSEIEMaxMonthly)
"
@SeieLessThanSeieMaxAnnualLmtReached.save!

#139	You have no SEIE excluded income. Have you already excluded in this calendar year enough earnings to reach the maximum annual SEIE limit ($RateSEIEMaxYear)?	
#SeieAnnualLmtPreviouslyReached			YES:NO		YES	If Student = Y AND SpouseStudent <> Y AND SsiOrCaidEarnAmt > 0 AND SeieAmt = 0
@SeieAnnualLmtPreviouslyReached = Question.new(:display_rules => 'always', :default_answer => 'Yes',                  :reference_id =>   '139',   :question_type => 'select',       :answer_choices => 'Yes, No',                          :order => 7,    :group_id => @Student_Earned_Income_Exclutsion.id)
@SeieAnnualLmtPreviouslyReached.name = 'SeieAnnualLmtPreviouslyReached'
@SeieAnnualLmtPreviouslyReached.text = 'You have no SEIE excluded income. Have you already excluded in this calendar year enough earnings to reach the maximum annual SEIE limit ($RateSEIEMaxYear)?'
#If Student = Y AND SpouseStudent <> Y AND SsiOrCaidEarnAmt > 0 AND SeieAmt = 0
@SeieAnnualLmtPreviouslyReached.display_rules = "
Student = manager.get_answer_by_question_name('Student')
SpouseStudent = manager.get_answer_by_question_name('SpouseStudent')
SeieAmt = manager.get_answer_by_question_name('SeieAmt')
if SeieAmt != nil then
  SeieAmt = Float(SeieAmt)
else
  SeieAmt = 0
end
SsiOrCaidEarnAmt = manager.get_answer_by_question_name('SsiOrCaidEarnAmt')
if SsiOrCaidEarnAmt != nil then
  SsiOrCaidEarnAmt = Float(SsiOrCaidEarnAmt)
else
  SsiOrCaidEarnAmt = 0
end
(Student == 'Yes') && (SpouseStudent != 'Yes') && (SeieAmt == 0) && (SsiOrCaidEarnAmt > 0)
"
@SeieAnnualLmtPreviouslyReached.save!

#NOTE Here is another Rate figure hardwired into the seed file
#25	140	The sum of your SEIE exclusion ($SeieAmt) and your spouse's ($SpouseSeieAmt) is less than the sum of your earnings ($SsiOrCaidEarnAmt) and your spouse's ($SpouseSsiOrCaidEarnAmt).  Have you and your spouse used up your SEIE annual exclusion amount ($RateSEIEMaxYear)?	
#CoupleSeieLessThanEarnMaxAnnualLmtReached			YES:NO		YES	If (Student = Y AND SpouseStudent = Y AND SeieAmt + SpouseSeieAmt > 0 AND (SsiOrCaidEarnAmt + SsiSpouseDeemEarnAmt + SpouseSsiOrCaidEarnAmt) < RateSEIEMaxMonthly AND (SeieAmt + SpouseSeieAmt) < (SsiOrCaidEarnAmt + SsiSpouseDeemEarnAmt + SpouseSsiOrCaidEarnAmt)
@CoupleSeieLessThanEarnMaxAnnualLmtReached = Question.new(:display_rules => 'always', :default_answer => 'Yes',                  :reference_id =>   '140',   :question_type => 'select',       :answer_choices => 'Yes, No',                          :order => 8,    :group_id => @Student_Earned_Income_Exclutsion.id)
@CoupleSeieLessThanEarnMaxAnnualLmtReached.name = 'CoupleSeieLessThanEarnMaxAnnualLmtReached'
@CoupleSeieLessThanEarnMaxAnnualLmtReached.text = 'The sum of your SEIE exclusion and your spouse\'s is less than the sum of your earnings and your spouse\'s. Have you and your spouse used up your SEIE annual exclusion amount?'
#If (Student = Y AND SpouseStudent = Y AND SeieAmt + SpouseSeieAmt > 0 AND (SsiOrCaidEarnAmt + SsiSpouseDeemEarnAmt + SpouseSsiOrCaidEarnAmt) < RateSEIEMaxMonthly AND (SeieAmt + SpouseSeieAmt) < (SsiOrCaidEarnAmt + SsiSpouseDeemEarnAmt + SpouseSsiOrCaidEarnAmt)
#10/22/2010 review for souse earning question change
#If (Student = Y AND SpouseStudent = Y AND SeieAmt + SpouseSeieAmt > 0 AND (SsiOrCaidEarnAmt + SpouseWhoIsDeemedEarnAmt + SpouseSsiOrCaidEarnAmt) < RateSEIEMaxMonthly AND (SeieAmt + SpouseSeieAmt) < (SsiOrCaidEarnAmt + SpouseWhoIsDeemedEarnAmt + SpouseSsiOrCaidEarnAmt)

@CoupleSeieLessThanEarnMaxAnnualLmtReached.display_rules = " 
Student = manager.get_answer_by_question_name('Student')
SpouseStudent = manager.get_answer_by_question_name('SpouseStudent')
SeieAmt = manager.get_answer_by_question_name('SeieAmt')
if SeieAmt != nil then
  SeieAmt = Float(SeieAmt)
else
  SeieAmt = 0
end
SpouseSeieAmt = manager.get_answer_by_question_name('SpouseSeieAmt')
if SpouseSeieAmt != nil then
  SpouseSeieAmt = Float(SpouseSeieAmt)
else
  SpouseSeieAmt = 0
end
SsiOrCaidEarnAmt = manager.get_answer_by_question_name('SsiOrCaidEarnAmt')
if SsiOrCaidEarnAmt != nil then
  SsiOrCaidEarnAmt = Float(SsiOrCaidEarnAmt)
else
  SsiOrCaidEarnAmt = 0
end
SpouseWhoIsDeemedEarnAmt = manager.get_answer_by_question_name('SpouseWhoIsDeemedEarnAmt')
if SpouseWhoIsDeemedEarnAmt != nil then
  SpouseWhoIsDeemedEarnAmt = Float(SpouseWhoIsDeemedEarnAmt)
else
  SpouseWhoIsDeemedEarnAmt = 0
end
SpouseSsiOrCaidEarnAmt = manager.get_answer_by_question_name('SpouseSsiOrCaidEarnAmt')
if SpouseSsiOrCaidEarnAmt != nil then
 SpouseSsiOrCaidEarnAmt = Float(SpouseSsiOrCaidEarnAmt)
else
  SpouseSsiOrCaidEarnAmt = 0
end
 RateSEIEMaxMonthly = 1640
(Student == 'Yes' && SpouseStudent = 'Yes') && (SeieAmt + SpouseSeieAmt > 0) && ((SsiOrCaidEarnAmt + SpouseWhoIsDeemedEarnAmt + SpouseSsiOrCaidEarnAmt) < RateSEIEMaxMonthly) && ((SeieAmt + SpouseSeieAmt) < (SsiOrCaidEarnAmt + SpouseWhoIsDeemedEarnAmt + SpouseSsiOrCaidEarnAmt))
"
@CoupleSeieLessThanEarnMaxAnnualLmtReached.save!

#25	141	The sum of your SEIE exclusion ($SeieAmt) and your spouse's ($SpouseSeieAmt) is less than the SEIE Monthly Maximum ($RateSEIEMaxMonthly).  Have you and your spouse used up your SEIE annual exclusion amount ($RateSEIEMaxYear)?	
#CoupleSeieLessThanSeieMaxAnnualLmtReached			YES:NO		YES	If (Student = Y AND SpouseStudent = Y AND SeieAmt + SpouseSeieAmt > 0 AND (SsiOrCaidEarnAmt + SsiSpouseDeemEarnAmt + SpouseSsiOrCaidEarnAmt) > Maximum Student Earned Income Exclusion (SEIE) per month AND (SeieAmt + SpouseSeieAmt) < (SsiOrCaidEarnAmt + SsiSpouseDeemEarnAmt + SpouseSsiOrCaidEarnAmt)
@CoupleSeieLessThanSeieMaxAnnualLmtReached = Question.new(:display_rules => 'always', :default_answer => 'Yes',                  :reference_id =>   '140',   :question_type => 'select',       :answer_choices => 'Yes, No',                          :order => 8,    :group_id => @Student_Earned_Income_Exclutsion.id)
@CoupleSeieLessThanSeieMaxAnnualLmtReached.name = 'CoupleSeieLessThanSeieMaxAnnualLmtReached'
@CoupleSeieLessThanSeieMaxAnnualLmtReached.text = 'The sum of your SEIE exclusion and your spouse\'s is less than the SEIE Monthly Maximum ($1640).  Have you and your spouse used up your SEIE annual exclusion amount($6600)?'
#If (Student = Y AND SpouseStudent = Y AND SeieAmt + SpouseSeieAmt > 0 AND (SsiOrCaidEarnAmt + SsiSpouseDeemEarnAmt + SpouseSsiOrCaidEarnAmt) > Maximum Student Earned Income Exclusion (SEIE) per month AND (SeieAmt + SpouseSeieAmt) < (SsiOrCaidEarnAmt + SsiSpouseDeemEarnAmt + SpouseSsiOrCaidEarnAmt)
#If (Student = Y AND SpouseStudent = Y AND SeieAmt + SpouseSeieAmt > 0 AND (SsiOrCaidEarnAmt + SpouseWhoIsDeemedEarnAmt + SpouseSsiOrCaidEarnAmt) > Maximum Student Earned Income Exclusion (SEIE) per month AND (SeieAmt + SpouseSeieAmt) < (RateSEIEMaxMonthly)

@CoupleSeieLessThanSeieMaxAnnualLmtReached.display_rules = " 
Student = manager.get_answer_by_question_name('Student')
SpouseStudent = manager.get_answer_by_question_name('SpouseStudent')
SeieAmt = manager.get_answer_by_question_name('SeieAmt')
if SeieAmt != nil then
  SeieAmt = Float(SeieAmt)
else
  SeieAmt = 0
end
SpouseSeieAmt = manager.get_answer_by_question_name('SpouseSeieAmt')
if SpouseSeieAmt != nil then
  SpouseSeieAmt = Float(SpouseSeieAmt)
else
  SpouseSeieAmt = 0
end
SsiOrCaidEarnAmt = manager.get_answer_by_question_name('SsiOrCaidEarnAmt')
if SsiOrCaidEarnAmt != nil then
  SsiOrCaidEarnAmt = Float(SsiOrCaidEarnAmt)
else
  SsiOrCaidEarnAmt = 0
end
SpouseWhoIsDeemedEarnAmt = manager.get_answer_by_question_name('SpouseWhoIsDeemedEarnAmt')
if SpouseWhoIsDeemedEarnAmt != nil then
  SpouseWhoIsDeemedEarnAmt = Float(SpouseWhoIsDeemedEarnAmt)
else
  SpouseWhoIsDeemedEarnAmt = 0
end
SpouseSsiOrCaidEarnAmt = manager.get_answer_by_question_name('SpouseSsiOrCaidEarnAmt')
if SpouseSsiOrCaidEarnAmt != nil then
 SpouseSsiOrCaidEarnAmt = Float(SpouseSsiOrCaidEarnAmt)
else
  SpouseSsiOrCaidEarnAmt = 0
end
 RateSEIEMaxMonthly = 1640
(Student == 'Yes' && SpouseStudent = 'Yes' && (SeieAmt + SpouseSeieAmt > 0) && ((SsiOrCaidEarnAmt + SpouseWhoIsDeemedEarnAmt + SpouseSsiOrCaidEarnAmt) > RateSEIEMaxMonthly) && ((SeieAmt + SpouseSeieAmt) < RateSEIEMaxMonthly))
"
@CoupleSeieLessThanSeieMaxAnnualLmtReached.save!

#1(Student == 'Yes' && SpouseStudent = 'Yes'1) && 2(SeieAmt + SpouseSeieAmt > 02) && 3(4(SsiOrCaidEarnAmt + SpouseWhoIsDeemedEarnAmt + SpouseSsiOrCaidEarnAmt4) > RateSEIEMaxMonthly3) && (5(6SeieAmt + SpouseSeieAmt6) < RateSEIEMaxMonthly5))


#25	142	You and your spouse have no SEIE excluded income. Have you and/or your spouse already excluded in this calendar year enough earned income to reach the maximum annual SEIE limit ($RateSEIEMaxYear)?	
#CoupleSeieAnnualAmtPreviouslyReached			YES:NO		YES	IF Student = Y AND SpouseStudent = Y AND SeieAmt + SpouseSeieAmt = 0 AND SsiOrCaidEarnAmt + SsiSpouseDeemEarnAmt + SpouseSsiOrCaidEarnAmt > 0	no
@CoupleSeieAnnualAmtPreviouslyReached = Question.new(:display_rules => 'always', :default_answer => 'Yes',                  :reference_id =>   '142',   :question_type => 'select',       :answer_choices => 'Yes, No',                          :order => 9,    :group_id => @Student_Earned_Income_Exclutsion.id)
@CoupleSeieAnnualAmtPreviouslyReached.name = 'CoupleSeieAnnualAmtPreviouslyReached'
@CoupleSeieAnnualAmtPreviouslyReached.text = 'You and your spouse have no SEIE excluded income. Have you and/or your spouse already excluded in this calendar year enough earned income to reach the maximum annual SEIE limit?'
#IF Student = Y AND SpouseStudent = Y AND SeieAmt + SpouseSeieAmt = 0 AND SsiOrCaidEarnAmt + SsiSpouseDeemEarnAmt + SpouseSsiOrCaidEarnAmt > 0
#10/22/2010 review
#IF Student = Y AND SpouseStudent = Y AND SeieAmt + SpouseSeieAmt = 0 AND SsiOrCaidEarnAmt + SpouseWhoIsDeemedEarnAmt + SpouseSsiOrCaidEarnAmt > 0

@CoupleSeieAnnualAmtPreviouslyReached.display_rules = " 
Student = manager.get_answer_by_question_name('Student')
SpouseStudent = manager.get_answer_by_question_name('SpouseStudent')
SeieAmt = manager.get_answer_by_question_name('SeieAmt')
if SeieAmt != nil then
  SeieAmt = Float(SeieAmt)
else
  SeieAmt = 0
end
SpouseSeieAmt = manager.get_answer_by_question_name('SpouseSeieAmt')
if SpouseSeieAmt != nil then
  SpouseSeieAmt = Float(SpouseSeieAmt)
else
  SpouseSeieAmt = 0
end
SsiOrCaidEarnAmt = manager.get_answer_by_question_name('SsiOrCaidEarnAmt')
if SsiOrCaidEarnAmt != nil then
  SsiOrCaidEarnAmt = Float(SsiOrCaidEarnAmt)
else
  SsiOrCaidEarnAmt = 0
end
SpouseWhoIsDeemedEarnAmt = manager.get_answer_by_question_name('SpouseWhoIsDeemedEarnAmt')
if SpouseWhoIsDeemedEarnAmt != nil then
  SpouseWhoIsDeemedEarnAmt = Float(SpouseWhoIsDeemedEarnAmt)
else
  SpouseWhoIsDeemedEarnAmt = 0
end
SpouseSsiOrCaidEarnAmt = manager.get_answer_by_question_name('SpouseSsiOrCaidEarnAmt')
if SpouseSsiOrCaidEarnAmt != nil then
 SpouseSsiOrCaidEarnAmt = Float(SpouseSsiOrCaidEarnAmt)
else
  SpouseSsiOrCaidEarnAmt = 0
end
(Student == 'Yes' && SpouseStudent = 'Yes') && ((SeieAmt + SpouseSeieAmt) == 0) && ((SsiOrCaidEarnAmt + SpouseWhoIsDeemedEarnAmt + SpouseSsiOrCaidEarnAmt) > 0)
"
@CoupleSeieAnnualAmtPreviouslyReached.save!
#1(Student == 'Yes' && SpouseStudent = 'Yes'1) && 2(3(SeieAmt + SpouseSeieAmt3) == 02) && 4(5(SsiOrCaidEarnAmt + SpouseWhoIsDeemedEarnAmt + SpouseSsiOrCaidEarnAmt5) > 04)



#Bob has big questions about this display rule that have been sent in email to DR on 9/20/2010 [SsiSpouseDeemEarnAmt + SpouseSsiOrCaidEarnAmt]

#25	143	Your spouse's SEIE exclusion ($SpouseSeieAmt) is less than your spouse's earnings ($SpouseSsiOrCaidEarnAmt).  Has your spouse used up the SEIE annual exclusion amount ($RateSEIEMaxYear)?	
#SpouseSeieLessThanEarnMaxAnnualLmtReached			YES:NO		YES	If (Student <> Y AND SpouseStudent = Y AND SpouseSeieAmt > 0 AND (SsiSpouseDeemEarnAmt + SpouseSsiOrCaidEarnAmt) < Maximum Student Earned Income Exclusion (SEIE) per month AND (SpouseSeieAmt) < (SsiSpouseDeemEarnAmt + SpouseSsiOrCaidEarnAmt)
@SpouseSeieLessThanEarnMaxAnnualLmtReached = Question.new(:display_rules => 'always', :default_answer => 'Yes',                  :reference_id =>   '142',   :question_type => 'select',       :answer_choices => 'Yes, No',                          :order => 10,    :group_id => @Student_Earned_Income_Exclutsion.id)
@SpouseSeieLessThanEarnMaxAnnualLmtReached.name = 'SpouseSeieLessThanEarnMaxAnnualLmtReached'
@SpouseSeieLessThanEarnMaxAnnualLmtReached.text = 'Your spouse\'s SEIE exclusion is less than your spouse\'s earnings. Has your spouse used up the SEIE annual exclusion amount?'
#143 If (Student <> Y AND SpouseStudent = Y AND SpouseSeieAmt > 0 AND (SsiSpouseDeemEarnAmt + SpouseSsiOrCaidEarnAmt) < Maximum Student Earned Income Exclusion (SEIE) per month AND (SpouseSeieAmt) < (SsiSpouseDeemEarnAmt + SpouseSsiOrCaidEarnAmt)
#143 review 10/22/2010
#If (Student <> Y AND SpouseStudent = Y AND SpouseSeieAmt > 0 AND (SpouseWhoIsDeemedEarnAmt + SpouseSsiOrCaidEarnAmt) < Maximum Student Earned Income Exclusion (SEIE) per month AND (SpouseSeieAmt) < (SpouseWhoIsDeemedEarnAmt + SpouseSsiOrCaidEarnAmt)

@SpouseSeieLessThanEarnMaxAnnualLmtReached.display_rules = " 
Student = manager.get_answer_by_question_name('Student')
SpouseStudent = manager.get_answer_by_question_name('SpouseStudent')
SpouseSeieAmt = manager.get_answer_by_question_name('SpouseSeieAmt')
if SpouseSeieAmt != nil then
  SpouseSeieAmt = Float(SpouseSeieAmt)
else
  SpouseSeieAmt = 0
end
SpouseWhoIsDeemedEarnAmt = manager.get_answer_by_question_name('SpouseWhoIsDeemedEarnAmt')
if SpouseWhoIsDeemedEarnAmt != nil then
  SpouseWhoIsDeemedEarnAmt = Float(SpouseWhoIsDeemedEarnAmt)
else
  SpouseWhoIsDeemedEarnAmt = 0
end
SpouseSsiOrCaidEarnAmt = manager.get_answer_by_question_name('SpouseSsiOrCaidEarnAmt')
if SpouseSsiOrCaidEarnAmt != nil then
 SpouseSsiOrCaidEarnAmt = Float(SpouseSsiOrCaidEarnAmt)
else
  SpouseSsiOrCaidEarnAmt = 0
end
 RateSEIEMaxMonthly = 1640
((Student != 'Yes' && SpouseStudent == 'Yes') && (SpouseSeieAmt > 0) && ((SpouseWhoIsDeemedEarnAmt + SpouseSsiOrCaidEarnAmt) < RateSEIEMaxMonthly) && ((SpouseSeieAmt) < (SpouseWhoIsDeemedEarnAmt + SpouseSsiOrCaidEarnAmt)))
"
@SpouseSeieLessThanEarnMaxAnnualLmtReached.save!

#25	144	Your spouse's SEIE exclusion ($SpouseSeieAmt) is less than the SEIE Monthly Maximum Exclusion ($RateSEIEMaxMonthly).  Has your spouse used up the SEIE annual exclusion amount ($RateSEIEMaxYear)?	
#SpouseSeieLessThanSeieMaxAnnualLmtReached			YES:NO		YES	If (Student <> Y AND SpouseStudent = Y AND SpouseSeieAmt > 0 AND (SsiSpouseDeemEarnAmt + SpouseSsiOrCaidEarnAmt) > Maximum Student Earned Income Exclusion (SEIE) per month AND SpouseSeieAmt < RateSEIEMaxMonthly)
@SpouseSeieLessThanSeieMaxAnnualLmtReached = Question.new(:display_rules => 'always', :default_answer => 'Yes',                  :reference_id =>   '144',   :question_type => 'select',       :answer_choices => 'Yes, No',                          :order => 11,    :group_id => @Student_Earned_Income_Exclutsion.id)
@SpouseSeieLessThanSeieMaxAnnualLmtReached.name = 'SpouseSeieLessThanSeieMaxAnnualLmtReached'
@SpouseSeieLessThanSeieMaxAnnualLmtReached.text = 'Your spouse\'s SEIE exclusion is less than the SEIE Monthly Maximum Exclusion.  Has your spouse used up the SEIE annual exclusion amount?'
#144 If (Student <> Y AND SpouseStudent = Y AND SpouseSeieAmt > 0 AND (SsiSpouseDeemEarnAmt + SpouseSsiOrCaidEarnAmt) > Maximum Student Earned Income Exclusion (SEIE) per month AND SpouseSeieAmt < RateSEIEMaxMonthly)
#10/22/2010 review 
#If (Student <> Y AND SpouseStudent = Y AND SpouseSeieAmt > 0 AND (SpouseWhoIsDeemedEarnAmt + SpouseSsiOrCaidEarnAmt) > Maximum Student Earned Income Exclusion (SEIE) per month AND SpouseSeieAmt < RateSEIEMaxMonthly)
@SpouseSeieLessThanSeieMaxAnnualLmtReached.display_rules = " 
Student = manager.get_answer_by_question_name('Student')
SpouseStudent = manager.get_answer_by_question_name('SpouseStudent')
SpouseSeieAmt = manager.get_answer_by_question_name('SpouseSeieAmt')
if SpouseSeieAmt != nil then
  SpouseSeieAmt = Float(SpouseSeieAmt)
else
  SpouseSeieAmt = 0
end
SpouseWhoIsDeemedEarnAmt = manager.get_answer_by_question_name('SpouseWhoIsDeemedEarnAmt')
if SpouseWhoIsDeemedEarnAmt != nil then
  SpouseWhoIsDeemedEarnAmt = Float(SpouseWhoIsDeemedEarnAmt)
else
  SpouseWhoIsDeemedEarnAmt = 0
end
SpouseSsiOrCaidEarnAmt = manager.get_answer_by_question_name('SpouseSsiOrCaidEarnAmt')
if SpouseSsiOrCaidEarnAmt != nil then
 SpouseSsiOrCaidEarnAmt = Float(SpouseSsiOrCaidEarnAmt)
else
  SpouseSsiOrCaidEarnAmt = 0
end
 RateSEIEMaxMonthly = 1640
  ((Student != 'Yes' && SpouseStudent == 'Yes') && (SpouseSeieAmt > 0) && ((SpouseWhoIsDeemedEarnAmt + SpouseSsiOrCaidEarnAmt) > RateSEIEMaxMonthly) && (SpouseSeieAmt < RateSEIEMaxMonthly))
"
@SpouseSeieLessThanSeieMaxAnnualLmtReached.save!

#25	145	Your spouse has no SEIE excluded income. Has your spouse already excluded in this calendar year enough earnings to reach the maximum annual SEIE limit ($RateSEIEMaxYear)?	
#SpouseSeieAnnualAmtPreviouslyReached			YES:NO		YES	If (Student <> Y AND SpouseStudent = Y AND SpouseSeieAmt = 0 AND (SsiSpouseDeemEarnAmt + SpouseSsiOrCaidEarnAmt) > 0
@SpouseSeieAnnualAmtPreviouslyReached = Question.new(:display_rules => 'always', :default_answer => 'Yes',                  :reference_id =>   '145',   :question_type => 'select',       :answer_choices => 'Yes, No',                          :order => 12,    :group_id => @Student_Earned_Income_Exclutsion.id)
@SpouseSeieAnnualAmtPreviouslyReached.name = 'SpouseSeieAnnualAmtPreviouslyReached'
@SpouseSeieAnnualAmtPreviouslyReached.text = 'Your spouse has no SEIE excluded income. Has your spouse already excluded in this calendar year enough earnings to reach the maximum annual SEIE limit?'
#145 If (Student <> Y AND SpouseStudent = Y AND SpouseSeieAmt = 0 AND (SsiSpouseDeemEarnAmt + SpouseSsiOrCaidEarnAmt) > 0
#10/22/2010 review
#If (Student <> Y AND SpouseStudent = Y AND SpouseSeieAmt = 0 AND (SpouseWhoIsDeemedEarnAmt + SpouseSsiOrCaidEarnAmt) > 0

@SpouseSeieAnnualAmtPreviouslyReached.display_rules = " 
Student = manager.get_answer_by_question_name('Student')
SpouseStudent = manager.get_answer_by_question_name('SpouseStudent')
SpouseSeieAmt = manager.get_answer_by_question_name('SpouseSeieAmt')
if SpouseSeieAmt != nil then
  SpouseSeieAmt = Float(SpouseSeieAmt)
else
  SpouseSeieAmt = 0
end
SpouseWhoIsDeemedEarnAmt = manager.get_answer_by_question_name('SpouseWhoIsDeemedEarnAmt')
if SpouseWhoIsDeemedEarnAmt != nil then
  SpouseWhoIsDeemedEarnAmt = Float(SpouseWhoIsDeemedEarnAmt)
else
  SpouseWhoIsDeemedEarnAmt = 0
end
SpouseSsiOrCaidEarnAmt = manager.get_answer_by_question_name('SpouseSsiOrCaidEarnAmt')
if SpouseSsiOrCaidEarnAmt != nil then
 SpouseSsiOrCaidEarnAmt = Float(SpouseSsiOrCaidEarnAmt)
else
  SpouseSsiOrCaidEarnAmt = 0
end
((Student != 'Yes' && SpouseStudent == 'Yes') && ((SpouseSeieAmt) == 0 ) && ((SpouseWhoIsDeemedEarnAmt + SpouseSsiOrCaidEarnAmt) > 0))
"
@SpouseSeieAnnualAmtPreviouslyReached.save!


#25	146	Impairment-Related Work Expense (IRWE)	SubTab6_2_Irwe						Active if any included questions appear and as described in WW-Web Behavior.doc
#25	147	How much of your $DisWorkExpAmt of disability-related work expenses are counted as IRWE to determine SSI benefit amount and/or Medicaid eligibility?	
#SsiCaidIrweAmt			Zero or Positive Number  =<  DisWorkExpAmt	You can not enter an IRWE greater than the amount of your disability-related work expenses (DisWorkExpAmt).  Enter numbers only.  Do not enter $ or decimal point.	EXPRESSION: DisWorkExpAmt	IF SsiGet = Y AND DisWorkExpAmt > 0 AND (SsiOrCaidEarnAmt - SeieAmt) > 0 AND Blind = N
@SsiCaidIrweAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '147',   :question_type => 'text_field',       :answer_choices => '',                          :order => 1,    :group_id => @Impairment_Related_Work_Expense.id)
@SsiCaidIrweAmt.name = 'SsiCaidIrweAmt'
@SsiCaidIrweAmt.text = 'How much of your disability-related work expenses are counted as IRWE to determine SSI benefit amount and/or Medicaid eligibility?'
#147 IF SsiGet = Y AND DisWorkExpAmt > 0 AND (SsiOrCaidEarnAmt - SeieAmt) > 0 AND Blind = N
@SsiCaidIrweAmt.display_rules = " 
SsiGet = manager.get_answer_by_question_name('SsiGet')
Blind = manager.get_answer_by_question_name('Blind')
DisWorkExpAmt = manager.get_answer_by_question_name('DisWorkExpAmt')
if DisWorkExpAmt != nil then
  DisWorkExpAmt = Float(DisWorkExpAmt)
else
  DisWorkExpAmt = 0
end
SsiOrCaidEarnAmt = manager.get_answer_by_question_name('SsiOrCaidEarnAmt')
if SsiOrCaidEarnAmt != nil then
  SsiOrCaidEarnAmt = Float(SsiOrCaidEarnAmt)
else
  SsiOrCaidEarnAmt = 0
end
SeieAmt = manager.get_answer_by_question_name('SeieAmt')
if SeieAmt != nil then
 SeieAmt = Float(SeieAmt)
else
  SeieAmt = 0
end
SsiGet == 'Yes' && (DisWorkExpAmt > 0)  && ((SsiOrCaidEarnAmt - SeieAmt) > 0) && Blind == 'No'
"
#Zero or Positive Number  =<  DisWorkExpAmt

@SsiCaidIrweAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
DisWorkExpAmt = manager.get_answer_by_question_name('DisWorkExpAmt')
if DisWorkExpAmt != nil then
 DisWorkExpAmt = Float(DisWorkExpAmt)
else
  DisWorkExpAmt = 0
end

if answer != nil then
    true if ((Float(answer) >= 0) && Float(answer) <= DisWorkExpAmt ) rescue false
  else 
    true
end
"
#You can not enter an IRWE greater than the amount of your disability-related work expenses (DisWorkExpAmt).  Enter numbers only.  Do not enter $ or decimal point.

@SsiCaidIrweAmt.validation_message = "You can not enter an IRWE greater than the amount of your disability-related work expenses"
@SsiCaidIrweAmt.save!

#25	148	How much of your spouse's $SpouseDisWorkExpAmt of disability-related work expenses are counted as IRWE to determine SSI benefit amount and/or Medicaid eligibility?	
#SpouseSsiCaidIrweAmt			Zero or Positive Number  =< SpouseDisWorkExpAmt	You can not enter an IRWE greater than the amount of your spouse's disability-related work expenses (SpouseDisWorkExpAmt).  Enter numbers only.  Do not enter $ or decimal point.	EXPRESSION: SpouseDisWorkExpAmt	If SpouseSsiGet = Y AND SpouseDisWorkExpAmt > 0 AND (SpouseSsiOrCaidEarnAmt - SpouseSeieAmt) > 0 AND SpouseBlind = NO
@SpouseSsiCaidIrweAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '148',   :question_type => 'text_field',       :answer_choices => '',                          :order => 2,    :group_id => @Impairment_Related_Work_Expense.id)
@SpouseSsiCaidIrweAmt.name = 'SpouseSsiCaidIrweAmt'
@SpouseSsiCaidIrweAmt.text = 'How much of your spouse\'s disability-related work expenses are counted as IRWE to determine SSI benefit amount and/or Medicaid eligibility?'
#148 If SpouseSsiGet = Y AND SpouseDisWorkExpAmt > 0 AND (SpouseSsiOrCaidEarnAmt - SpouseSeieAmt) > 0 AND SpouseBlind = NO
@SpouseSsiCaidIrweAmt.display_rules = " 
SpouseSsiGet = manager.get_answer_by_question_name('SpouseSsiGet')
SpouseBlind = manager.get_answer_by_question_name('SpouseBlind')
SpouseDisWorkExpAmt = manager.get_answer_by_question_name('SpouseDisWorkExpAmt')
if SpouseDisWorkExpAmt != nil then
  SpouseDisWorkExpAmt = Float(SpouseDisWorkExpAmt)
else
  SpouseDisWorkExpAmt = 0
end
SpouseSsiOrCaidEarnAmt = manager.get_answer_by_question_name('SpouseSsiOrCaidEarnAmt')
if SpouseSsiOrCaidEarnAmt != nil then
  SpouseSsiOrCaidEarnAmt = Float(SpouseSsiOrCaidEarnAmt)
else
  SpouseSsiOrCaidEarnAmt = 0
end
SpouseSeieAmt = manager.get_answer_by_question_name('SpouseSeieAmt')
if SpouseSeieAmt != nil then
 SpouseSeieAmt = Float(SpouseSeieAmt)
else
  SpouseSeieAmt = 0
end
SpouseSsiGet == 'Yes' && (SpouseDisWorkExpAmt > 0)  && ((SpouseSsiOrCaidEarnAmt - SpouseSeieAmt) > 0) && SpouseBlind == 'No'
"
#BOB is waiting For DR to respond to SEIE part of the appearance rule /allowable answer discontinuity before adding a rule and message
@SpouseSsiCaidIrweAmt.save!

#25	149	How much of your $DisWorkExpAmt of disability-related work expenses are counted as IRWE to determine if your earnings exceed SGA?	
#SgaIrweAmt			Zero or Positive Number  <= DisWorkExpAmt	You can not enter an IRWE greater than the amount of your disability-related work expenses (DisWorkExpAmt).  Enter numbers only.  Do not enter $ or decimal point.	EXPRESSION: DisWorkExpAmt	IF(DisWorkExpAmt > 0) AND ((Blind = N AND SsdiEarnAmt > RateSgaDisabledAmt) OR (Blind = N AND SsiGetFinalDetermination = N AND SsiOrCaidEarnAmt > RateSgaDisabledAmt) OR (Blind = Y AND SsdiEarnAmt > RateSgaBlindAmt))
@SgaIrweAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '149',   :question_type => 'text_field',       :answer_choices => '',                          :order => 3,    :group_id => @Impairment_Related_Work_Expense.id)
@SgaIrweAmt.name = 'SgaIrweAmt'
@SgaIrweAmt.text = 'How much of your disability-related work expenses are counted as IRWE to determine if your earnings exceed SGA?'
#149 IF(DisWorkExpAmt > 0) AND ((Blind = N AND SsdiEarnAmt > RateSgaDisabledAmt) OR (Blind = N AND SsiGetFinalDetermination = N AND SsiOrCaidEarnAmt > RateSgaDisabledAmt) OR (Blind = Y AND SsdiEarnAmt > RateSgaBlindAmt))
@SgaIrweAmt.display_rules = " 
Blind = manager.get_answer_by_question_name('Blind')
DisWorkExpAmt = manager.get_answer_by_question_name('DisWorkExpAmt')
if DisWorkExpAmt != nil then
  DisWorkExpAmt = Float(DisWorkExpAmt)
else
  DisWorkExpAmt = 0
end
SsdiEarnAmt = manager.get_answer_by_question_name('SsdiEarnAmt')
if SsdiEarnAmt != nil then
  SsdiEarnAmt = Float(SsdiEarnAmt)
else
  SsdiEarnAmt = 0
end
RateSgaDisabledAmt = 980
SsiGetFinalDetermination = manager.get_answer_by_question_name('SsiGetFinalDetermination')
SsiOrCaidEarnAmt = manager.get_answer_by_question_name('SsiOrCaidEarnAmt')
if SsiOrCaidEarnAmt != nil then
 SsiOrCaidEarnAmt = Float(SsiOrCaidEarnAmt)
else
  SsiOrCaidEarnAmt = 0
end
RateSgaBlindAmt = 1640
(DisWorkExpAmt > 0) && (((Blind == 'No' && (SsdiEarnAmt > RateSgaDisabledAmt))) || (Blind == 'No' && SsiGetFinalDetermination == 'No' && (SsiOrCaidEarnAmt > RateSgaDisabledAmt)) || (Blind == 'Yes' && (SsdiEarnAmt > RateSgaBlindAmt)))
"
@SgaIrweAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
DisWorkExpAmt = manager.get_answer_by_question_name('DisWorkExpAmt')
if DisWorkExpAmt != nil then
 DisWorkExpAmt = Float(DisWorkExpAmt)
else
  DisWorkExpAmt = 0
end

if answer != nil then
    true if ((Float(answer) >= 0) && Float(answer) <= DisWorkExpAmt ) rescue false
  else 
    true
end
"
@SgaIrweAmt.validation_message = "You can not enter an IRWE greater than the amount of your disability-related work expenses"
@SgaIrweAmt.save!

#25	150	How much of your spouse's $SpouseDisWorkExpAmt of disability-related work expenses are counted as IRWE to determine if earnings exceed SGA?	
#SpouseSgaIrweAmt			Zero or Positive Number  <= SpouseDisWorkExpAmt	You can not enter an IRWE greater than the amount of your spouse's disability-related work expenses (SpouseDisWorkExpAmt).  Enter numbers only.  Do not enter $ or decimal point.	EXPRESSION: SpouseDisWorkExpAmt	IF(SpouseDisWorkExpAmt > 0) AND ((SpouseBlind = N AND SpouseSsdiEarnAmt > RateSgaDisabledAmt) OR (SpouseBlind = Y AND SpouseSsdiEarnAmt > RateSgaBlindAmt))
@SpouseSgaIrweAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '150',   :question_type => 'text_field',       :answer_choices => '',                          :order => 4,    :group_id => @Impairment_Related_Work_Expense.id)
@SpouseSgaIrweAmt.name = 'SpouseSgaIrweAmt'
@SpouseSgaIrweAmt.text = 'How much of your spouse\'s disability-related work expenses are counted as IRWE to determine if earnings exceed SGA?'
#IF(SpouseDisWorkExpAmt > 0) AND ((SpouseBlind = N AND SpouseSsdiEarnAmt > RateSgaDisabledAmt) OR (SpouseBlind = Y AND SpouseSsdiEarnAmt > RateSgaBlindAmt))
@SpouseSgaIrweAmt.display_rules = " 
SpouseBlind = manager.get_answer_by_question_name('SpouseBlind')
SpouseDisWorkExpAmt = manager.get_answer_by_question_name('SpouseDisWorkExpAmt')
if SpouseDisWorkExpAmt != nil then
  SpouseDisWorkExpAmt = Float(SpouseDisWorkExpAmt)
else
  SpouseDisWorkExpAmt = 0
end
SpouseSsdiEarnAmt = manager.get_answer_by_question_name('SpouseSsdiEarnAmt')
if SpouseSsdiEarnAmt != nil then
  SpouseSsdiEarnAmt = Float(SpouseSsdiEarnAmt)
else
  SpouseSsdiEarnAmt = 0
end
RateSgaDisabledAmt = 980
RateSgaBlindAmt = 1640
(SpouseDisWorkExpAmt > 0) && (((SpouseBlind == 'No' && (SpouseSsdiEarnAmt > RateSgaDisabledAmt)))  || (SpouseBlind == 'Yes' && (SpouseSsdiEarnAmt > RateSgaBlindAmt)))
"
#Zero or Positive Number  <= SpouseDisWorkExpAmt
@SpouseSgaIrweAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
SpouseDisWorkExpAmt = manager.get_answer_by_question_name('SpouseDisWorkExpAmt')
if SpouseDisWorkExpAmt != nil then
 SpouseDisWorkExpAmt = Float(SpouseDisWorkExpAmt)
else
  SpouseDisWorkExpAmt = 0
end

if answer != nil then
    true if ((Float(answer) >= 0) && Float(answer) <= SpouseDisWorkExpAmt) rescue false
  else 
    true
end
"
#You can not enter an IRWE greater than the amount of your spouse's disability-related work expenses (SpouseDisWorkExpAmt).  Enter positive numbers only.  Do not enter $.

@SpouseSgaIrweAmt.validation_message = "You can not enter an IRWE greater than the amount of your spouse's disability-related work expenses"
@SpouseSgaIrweAmt.save!

#25	151	Blind Work Expense (BWE)	SubTab6_3_Bwe						Active if any included questions appear and as described in WW-Web Behavior.doc
#26	152	How much of your $DisWorkExpAmt of disability-related work expenses and $OthWorkExpAmt of other work expenses are counted as BWE?	
#BweAmt			Zero or Positive Number  =<  DisWorkExpAmt + EstEarnTaxAmt + OthWorkExpAmt	You can not enter a BWE greater than the sum of your work expenses (DisWorkExpAmt + EstEarnTaxAmt + OthWorkExpAmt).  Enter numbers only.  Do not enter $ or decimal point.	EXPRESSION: DisWorkExpAmt + EstEarnTaxAmt + OthWorkExpAmt	If (Blind = Y AND (SsiGet = Y OR CaidGet = Y) AND (EXPRESSION: DisWorkExpAmt + EstEarnTaxAmt + OthWorkExpAmt) > 0 AND (SsiOrCaidEarnAmt - SeieAmt) > 0)
@BweAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '152',   :question_type => 'text_field',       :answer_choices => '',                          :order => 1,    :group_id => @Blind_Work_Expense.id)
@BweAmt.name = 'BweAmt'
@BweAmt.text = 'How much of your disability-related work expenses and other work expenses are counted as BWE?'
#152 If (Blind = Y AND (SsiGet = Y OR CaidGet = Y) AND (EXPRESSION: DisWorkExpAmt + EstEarnTaxAmt + OthWorkExpAmt ) > 0 AND (SsiOrCaidEarnAmt - SeieAmt) > 0) 
@BweAmt.display_rules = " 
Blind = manager.get_answer_by_question_name('Blind')
SsiGet = manager.get_answer_by_question_name('SsiGet')
CaidGet = manager.get_answer_by_question_name('CaidGet')
DisWorkExpAmt = manager.get_answer_by_question_name('DisWorkExpAmt')
if DisWorkExpAmt != nil then
  DisWorkExpAmt = Float(DisWorkExpAmt)
else
  DisWorkExpAmt = 0
end
EstEarnTaxAmt = manager.get_answer_by_question_name('EstEarnTaxAmt')
if EstEarnTaxAmt != nil then
  EstEarnTaxAmt = Float(EstEarnTaxAmt)
else
  EstEarnTaxAmt = 0
end
OthWorkExpAmt = manager.get_answer_by_question_name('OthWorkExpAmt')
if OthWorkExpAmt != nil then
  OthWorkExpAmt = Float(OthWorkExpAmt)
else
  OthWorkExpAmt = 0
end
SsiOrCaidEarnAmt = manager.get_answer_by_question_name('SsiOrCaidEarnAmt')
if SsiOrCaidEarnAmt != nil then
  SsiOrCaidEarnAmt = Float(SsiOrCaidEarnAmt)
else
  SsiOrCaidEarnAmt = 0
end
SeieAmt = manager.get_answer_by_question_name('SeieAmt')
if SeieAmt != nil then
  SeieAmt = Float(SeieAmt)
else
  SeieAmt = 0
end
Blind == 'Yes' && (SsiGet == 'Yes' || CaidGet == 'Yes') && ((DisWorkExpAmt + EstEarnTaxAmt + OthWorkExpAmt) > 0) && ((SsiOrCaidEarnAmt - SeieAmt) > 0) 
"
#Zero or Positive Number  =<  DisWorkExpAmt + EstEarnTaxAmt + OthWorkExpAmt
@BweAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
DisWorkExpAmt = manager.get_answer_by_question_name('DisWorkExpAmt')
EstEarnTaxAmt = manager.get_answer_by_question_name('EstEarnTaxAmt')
OthWorkExpAmt = manager.get_answer_by_question_name('OthWorkExpAmt')

if DisWorkExpAmt != nil then
 DisWorkExpAmt = Float(DisWorkExpAmt)
else
  DisWorkExpAmt = 0
end

if EstEarnTaxAmt != nil then
 EstEarnTaxAmt = Float(EstEarnTaxAmt)
else
  EstEarnTaxAmt = 0
end

if OthWorkExpAmt != nil then
 OthWorkExpAmt = Float(OthWorkExpAmt)
else
  OthWorkExpAmt = 0
end



if answer != nil then
    true if ((Float(answer) >= 0) && Float(answer) <= (DisWorkExpAmt + EstEarnTaxAmt + OthWorkExpAmt)) rescue false
  else 
    true
end
"
#You can not enter a BWE greater than the sum of your work expenses (DisWorkExpAmt + EstEarnTaxAmt + OthWorkExpAmt).  Enter positive numbers only.  Do not enter $.
@BweAmt.validation_message = "You can not enter a BWE greater than the sum of your work expenses"
@BweAmt.save!

#26	153	How much of your spouse's $SpouseDisWorkExpAmt of disability-related work expenses and $SpouseOthWorkExpAmt of other work expenses are counted as BWE?	
#SpouseBweAmt			Zero or Positive Number  =<  SpouseDisWorkExpAmt + SpouseEstEarnTaxAmt + SpouseOthWorkExpAmt	You can not enter a BWE greater than the sum of your spouse's work expenses (SpouseDisWorkExpAmt + SpouseEstEarnTaxAmt + SpouseOthWorkExpAmt).  Enter numbers only.  Do not enter $ or decimal point.	EXPRESSION: SpouseDisWorkExpAmt + SpouseEstEarnTaxAmt + SpouseOthWorkExpAmt	 (SpouseBlind = Y AND (SpouseSsiGet = Y OR CaidSpouseGet) AND ( SpouseDisWorkExpAmt + SpouseEstEarnTaxAmt + SpouseOthWorkExpAmt) > 0 AND (SpouseSsiOrCaidEarnAmt - SpouseSeieAmt) > 0)
@SpouseBweAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '153',   :question_type => 'text_field',       :answer_choices => '',                          :order => 2,    :group_id => @Blind_Work_Expense.id)
@SpouseBweAmt.name = 'SpouseBweAmt'
@SpouseBweAmt.text = 'How much of your spouse\'s disability-related work expenses and other work expenses are counted as BWE?'
#153 (SpouseBlind = Y AND (SpouseSsiGet = Y OR CaidSpouseGet) AND ( SpouseDisWorkExpAmt + SpouseEstEarnTaxAmt + SpouseOthWorkExpAmt) > 0 AND (SpouseSsiOrCaidEarnAmt - SpouseSeieAmt) > 0)
@SpouseBweAmt.display_rules = " 
SpouseBlind = manager.get_answer_by_question_name('SpouseBlind')
SpouseSsiGet = manager.get_answer_by_question_name('SpouseSsiGet')
CaidSpouseGet = manager.get_answer_by_question_name('CaidSpouseGet')
SpouseDisWorkExpAmt = manager.get_answer_by_question_name('SpouseDisWorkExpAmt')
if SpouseDisWorkExpAmt != nil then
  SpouseDisWorkExpAmt = Float(SpouseDisWorkExpAmt)
else
  SpouseDisWorkExpAmt = 0
end
SpouseEstEarnTaxAmt = manager.get_answer_by_question_name('SpouseEstEarnTaxAmt')
if SpouseEstEarnTaxAmt != nil then
  SpouseEstEarnTaxAmt = Float(SpouseEstEarnTaxAmt)
else
  SpouseEstEarnTaxAmt = 0
end
SpouseOthWorkExpAmt = manager.get_answer_by_question_name('SpouseOthWorkExpAmt')
if SpouseOthWorkExpAmt != nil then
  SpouseOthWorkExpAmt = Float(SpouseOthWorkExpAmt)
else
  SpouseOthWorkExpAmt = 0
end
SpouseSsiOrCaidEarnAmt = manager.get_answer_by_question_name('SpouseSsiOrCaidEarnAmt')
if SpouseSsiOrCaidEarnAmt != nil then
  SpouseSsiOrCaidEarnAmt = Float(SpouseSsiOrCaidEarnAmt)
else
  SsiOrCaidEarnAmt = 0
end
SpouseSeieAmt = manager.get_answer_by_question_name('SpouseSeieAmt')
if SpouseSeieAmt != nil then
  SpouseSeieAmt = Float(SpouseSeieAmt)
else
  SpouseSeieAmt = 0
end
SpouseBlind == 'Yes' && (SpouseSsiGet == 'Yes' || CaidSpouseGet == 'Yes') && ((SpouseDisWorkExpAmt + SpouseEstEarnTaxAmt + SpouseOthWorkExpAmt) > 0) && ((SpouseSsiOrCaidEarnAmt - SpouseSeieAmt) > 0) 
"
#Zero or Positive Number  =<  SpouseDisWorkExpAmt + SpouseEstEarnTaxAmt + SpouseOthWorkExpAmt
@SpouseBweAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
SpouseDisWorkExpAmt = manager.get_answer_by_question_name('DisWorkExpAmt')
SpouseEstEarnTaxAmt = manager.get_answer_by_question_name('SpouseEstEarnTaxAmt')
SpouseOthWorkExpAmt = manager.get_answer_by_question_name('SpouseOthWorkExpAmt')

if SpouseDisWorkExpAmt != nil then
 SpouseDisWorkExpAmt = Float(SpouseDisWorkExpAmt)
else
  SpouseDisWorkExpAmt = 0
end

if SpouseEstEarnTaxAmt != nil then
 SpouseEstEarnTaxAmt = Float(SpouseEstEarnTaxAmt)
else
  SpouseEstEarnTaxAmt = 0
end

if SpouseOthWorkExpAmt != nil then
 SpouseOthWorkExpAmt = Float(SpouseOthWorkExpAmt)
else
  SpouseOthWorkExpAmt = 0
end


if answer != nil then
    true if ((Float(answer) >= 0) && Float(answer) <= (SpouseDisWorkExpAmt + SpouseEstEarnTaxAmt + SpouseOthWorkExpAmt)) rescue false
  else 
    true
end
"
#You can not enter a BWE greater than the sum of your spouse's work expenses (SpouseDisWorkExpAmt + SpouseEstEarnTaxAmt + SpouseOthWorkExpAmt).  Enter positive numbers only.  Do not enter $.
@SpouseBweAmt.validation_message = "You can not enter a BWE greater than the sum of your spouse's work expenses."
@SpouseBweAmt.save!


#25	154	Plan for Achieving Self-Support (PASS)	SubTab6_4_Pass						Active if any included questions appear and as described in WW-Web Behavior.doc
#26	155	What monthly amount are you including in a PASS?  (You are making employability investments of $EmployInvestAmt. You may also be able to include work expenses not already counted as IRWE or BWE.)	
#PassAmt			Zero or Positive Number =< EmployInvestAmt + DisWorkExpAmt + EstEarnTaxAmt + OthWorkExpAmt - SsiCaidIrweAmt - BweAmt	You can not enter a monthly PASS amount greater than the total amount of work expenses you have after subtracting any money you have already included in an IRWE or BWE ($ EmployInvestAmt + DisWorkExpAmt + EstEarnTaxAmt + OthWorkExpAmt - SsiCaidIrweAmt - BweAmt).  Enter numbers only.  Do not enter $ or a decimal point. 	EXPRESSION:  Smaller of (EmployInvestAmt + DisWorkExpAmt + EstEarnTaxAmt + OthWorkExpAmt - SsiCaidIrweAmt - BweAmt) OR ((SsdiAmtSelfFull + SsdiAmtOtherFull +UnearnAmt +SpouseDiAmtSelfFull + SpouseDiAmtOtherFull + SpouseUnEarnAmt + SsiOrCaidEarnAmt + SpouseSsiOrCaidEarnAmt+ InKindPMVAmt + SsiParDeemAmt + SsiSpouseDeemUnearnAmt + SsiSpouseDeemEarnAmt) - (SeieAmt + SpouseSeieAmt + SsiCaidIrweAmt + BweAmt + SpouseSsiCaidIrweAmt + SpouseBweAmt))	IF SsiGet = Y AND ((EmployInvestAmt + DisWorkExpAmt + EstEarnTaxAmt + OthWorkExpAmt - SsiCaidIrweAmt - BweAmt) > 0) AND ((SsdiAmtSelfFull + SsdiAmtOtherFull +UnearnAmt +SpouseDiAmtSelfFull + SpouseDiAmtOtherFull + SpouseUnEarnAmt + SsiOrCaidEarnAmt + SpouseSsiOrCaidEarnAmt+ InKindPMVAmt + SsiParDeemAmt + SsiSpouseDeemUnearnAmt + SsiSpouseDeemEarnAmt) - (SeieAmt + SpouseSeieAmt + SsiCaidIrweAmt + BweAmt + SpouseSsiCaidIrweAmt + SpouseBweAmt) > 0))
@PassAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '155',   :question_type => 'text_field',       :answer_choices => '',                          :order => 1,    :group_id => @Plan_for_Achieving_Self_Support.id)
@PassAmt.name = 'PassAmt'
@PassAmt.text = 'What monthly amount are you including in a PASS? (You can use employability investments and work expenses not already counted as IRWE or BWE.)'
#155 IF SsiGet = Y AND ((EmployInvestAmt + DisWorkExpAmt + EstEarnTaxAmt + OthWorkExpAmt - SsiCaidIrweAmt - BweAmt) > 0) 
#   AND ((SsdiAmtSelfFull + SsdiAmtOtherFull +UnearnAmt +SpouseDiAmtSelfFull + SpouseDiAmtOtherFull + SpouseUnEarnAmt + SsiOrCaidEarnAmt + SpouseSsiOrCaidEarnAmt+ InKindPMVAmt + SsiParDeemAmt + SsiSpouseDeemUnearnAmt + SsiSpouseDeemEarnAmt) 
# - (SeieAmt + SpouseSeieAmt + SsiCaidIrweAmt + BweAmt + SpouseSsiCaidIrweAmt + SpouseBweAmt) > 0))

@PassAmt.display_rules = " 
SsiGet = manager.get_answer_by_question_name('SsiGet')
EmployInvestAmt = manager.get_answer_by_question_name('EmployInvestAmt')
if EmployInvestAmt != nil then
  EmployInvestAmt = Float(EmployInvestAmt)
else
  EmployInvestAmt = 0
end
DisWorkExpAmt = manager.get_answer_by_question_name('DisWorkExpAmt')
if DisWorkExpAmt != nil then
  DisWorkExpAmt = Float(DisWorkExpAmt)
else
  DisWorkExpAmt = 0
end
EstEarnTaxAmt = manager.get_answer_by_question_name('EstEarnTaxAmt')
if EstEarnTaxAmt != nil then
  EstEarnTaxAmt = Float(EstEarnTaxAmt)
else
  EstEarnTaxAmt = 0
end
OthWorkExpAmt = manager.get_answer_by_question_name('OthWorkExpAmt')
if OthWorkExpAmt != nil then
  OthWorkExpAmt = Float(OthWorkExpAmt)
else
  OthWorkExpAmt = 0
end
SsiCaidIrweAmt = manager.get_answer_by_question_name('SsiCaidIrweAmt')
if SsiCaidIrweAmt != nil then
  SsiCaidIrweAmt = Float(SsiCaidIrweAmt)
else
  SsiCaidIrweAmt = 0
end
BweAmt = manager.get_answer_by_question_name('BweAmt')
if BweAmt != nil then
  BweAmt = Float(BweAmt)
else
  BweAmt = 0
end
SsdiAmtSelfFull = manager.get_answer_by_question_name('SsdiAmtSelfFull')
if SsdiAmtSelfFull != nil then
  SsdiAmtSelfFull = Float(SsdiAmtSelfFull)
else
  SsdiAmtSelfFull = 0
end
SsdiAmtOtherFull = manager.get_answer_by_question_name('SsdiAmtOtherFull')
if SsdiAmtOtherFull != nil then
  SsdiAmtOtherFull = Float(SsdiAmtOtherFull)
else
  SsdiAmtOtherFull = 0
end
UnearnAmt = manager.get_answer_by_question_name('UnearnAmt')
if UnearnAmt != nil then
  UnearnAmt = Float(UnearnAmt)
else
  UnearnAmt = 0
end
SpouseDiAmtSelfFull = manager.get_answer_by_question_name('SpouseDiAmtSelfFull')
if SpouseDiAmtSelfFull != nil then
  SpouseDiAmtSelfFull = Float(SpouseDiAmtSelfFull)
else
  SpouseDiAmtSelfFull = 0
end
SpouseDiAmtOtherFull = manager.get_answer_by_question_name('SpouseDiAmtOtherFull')
if SpouseDiAmtOtherFull != nil then
  SpouseDiAmtOtherFull = Float(SpouseDiAmtOtherFull)
else
  SpouseDiAmtOtherFull = 0
end
SpouseUnEarnAmt = manager.get_answer_by_question_name('SpouseUnEarnAmt')
if SpouseUnEarnAmt != nil then
  SpouseUnEarnAmt = Float(SpouseUnEarnAmt)
else
  SpouseUnEarnAmt = 0
end
SsiOrCaidEarnAmt = manager.get_answer_by_question_name('SsiOrCaidEarnAmt')
if SsiOrCaidEarnAmt != nil then
  SsiOrCaidEarnAmt = Float(SsiOrCaidEarnAmt)
else
  SsiOrCaidEarnAmt = 0
end
SpouseSsiOrCaidEarnAmt = manager.get_answer_by_question_name('SpouseSsiOrCaidEarnAmt')
if SpouseSsiOrCaidEarnAmt != nil then
  SpouseSsiOrCaidEarnAmt = Float(SpouseSsiOrCaidEarnAmt)
else
  SpouseSsiOrCaidEarnAmt = 0
end
InKindPMVAmt = manager.get_answer_by_question_name('InKindPMVAmt')
if InKindPMVAmt != nil then
  InKindPMVAmt = Float(InKindPMVAmt)
else
  InKindPMVAmt = 0
end
SsiParDeemAmt = manager.get_answer_by_question_name('SsiParDeemAmt')
if SsiParDeemAmt != nil then
  SsiParDeemAmt = Float(SsiParDeemAmt)
else
  SsiParDeemAmt = 0
end
SsiSpouseDeemUnearnAmt = manager.get_answer_by_question_name('SsiSpouseDeemUnearnAmt')
if SsiSpouseDeemUnearnAmt != nil then
  SsiSpouseDeemUnearnAmt = Float(SsiSpouseDeemUnearnAmt)
else
  SsiSpouseDeemUnearnAmt = 0
end
SsiSpouseDeemEarnAmt = manager.get_answer_by_question_name('SsiSpouseDeemEarnAmt')
if SsiSpouseDeemEarnAmt != nil then
  SsiSpouseDeemEarnAmt = Float(SsiSpouseDeemEarnAmt)
else
  SsiSpouseDeemEarnAmt = 0
end
SeieAmt = manager.get_answer_by_question_name('SeieAmt')
if SeieAmt != nil then
  SeieAmt = Float(SeieAmt)
else
 SeieAmt = 0
end

SpouseSeieAmt = manager.get_answer_by_question_name('SpouseSeieAmt')
if SpouseSeieAmt != nil then
  SpouseSeieAmt = Float(SpouseSeieAmt)
else
  SpouseSeieAmt = 0
end

SpouseSsiCaidIrweAmt = manager.get_answer_by_question_name('SpouseSsiCaidIrweAmt')
if SpouseSsiCaidIrweAmt != nil then
  SpouseSsiCaidIrweAmt = Float(SpouseSsiCaidIrweAmt)
else
  SpouseSsiCaidIrweAmt = 0
end
SpouseBweAmt = manager.get_answer_by_question_name('SpouseBweAmt')
if SpouseBweAmt != nil then
  SpouseBweAmt = Float(SpouseBweAmt)
else
  SpouseBweAmt = 0
end
SsiGet == 'Yes' && ((EmployInvestAmt + DisWorkExpAmt + EstEarnTaxAmt + OthWorkExpAmt - SsiCaidIrweAmt - BweAmt) > 0)  \
   && ((SsdiAmtSelfFull + SsdiAmtOtherFull + UnearnAmt + SpouseDiAmtSelfFull + SpouseDiAmtOtherFull + SpouseUnEarnAmt + SsiOrCaidEarnAmt + SpouseSsiOrCaidEarnAmt + InKindPMVAmt + SsiParDeemAmt + SsiSpouseDeemUnearnAmt + SsiSpouseDeemEarnAmt) \
   - (SeieAmt + SpouseSeieAmt + SsiCaidIrweAmt + BweAmt + SpouseSsiCaidIrweAmt + SpouseBweAmt) > 0)
"

#Zero or Positive Number =< EmployInvestAmt + DisWorkExpAmt + EstEarnTaxAmt + OthWorkExpAmt - SsiCaidIrweAmt - BweAmt
@PassAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
EmployInvestAmt = manager.get_answer_by_question_name('EmployInvestAmt')
DisWorkExpAmt = manager.get_answer_by_question_name('DisWorkExpAmt')
EstEarnTaxAmt = manager.get_answer_by_question_name('EstEarnTaxAmt')
OthWorkExpAmt = manager.get_answer_by_question_name('OthWorkExpAmt')
SsiCaidIrweAmt = manager.get_answer_by_question_name('SsiCaidIrweAmt')
BweAmt = manager.get_answer_by_question_name('BweAmt')


if EmployInvestAmt != nil then
 EmployInvestAmt = Float(EmployInvestAmt)
else
  EmployInvestAmt = 0
end

if DisWorkExpAmt != nil then
 DisWorkExpAmt = Float(DisWorkExpAmt)
else
  DisWorkExpAmt = 0
end

if EstEarnTaxAmt != nil then
 EstEarnTaxAmt = Float(EstEarnTaxAmt)
else
  EstEarnTaxAmt = 0
end

if OthWorkExpAmt != nil then
 OthWorkExpAmt = Float(OthWorkExpAmt)
else
  OthWorkExpAmt = 0
end

if SsiCaidIrweAmt != nil then
 SsiCaidIrweAmt = Float(SsiCaidIrweAmt)
else
  SsiCaidIrweAmt = 0
end

if BweAmt != nil then
 BweAmt = Float(BweAmt)
else
  BweAmt = 0
end

if answer != nil then
    true if ((Float(answer) >= 0) && Float(answer) <= (EmployInvestAmt + DisWorkExpAmt + EstEarnTaxAmt + OthWorkExpAmt - SsiCaidIrweAmt - BweAmt)) rescue false
  else 
    true
end
"
#You can not enter a monthly PASS amount greater than the total amount of work expenses you have after subtracting any money you have already included in an IRWE or BWE ($ EmployInvestAmt + DisWorkExpAmt + EstEarnTaxAmt + OthWorkExpAmt - SsiCaidIrweAmt - BweAmt).  Enter numbers only.  Do not enter $ or a decimal point. 
@PassAmt.validation_message = "You can not enter a monthly PASS amount greater than the total amount of work expenses you have after subtracting any money you have already included in an IRWE or BWE"
@PassAmt.save!

#25	156	How much of the $SpouseEmployInvestAmt your spouse is spending or setting aside monthly to improve future financial self sufficiency is your spouse including in a PASS? (It may also be possible to include work expenses not already counted as IRWE or BWE.)	
#SpousePassAmt			Zero or Positive Number <= SpouseEmployInvestAmt + SpouseDisWorkExpAmt + SpouseOthWorkExpAmt - SpouseSsiCaidIrweAmt - SpouseBweAmt	You can not enter a monthly PASS amount greater than the total amount of work expenses your spouse has after subtracting any money already included in an IRWE or BWE ($ EmployInvestAmt + DisWorkExpAmt + EstEarnTaxAmt + OthWorkExpAmt - SsiCaidIrweAmt - BweAmt).  Enter numbers only.  Do not enter $ or a decimal point. 	EXPRESSION: Smaller of (SpouseEmployInvestAmt + SpouseDisWorkExpAmt + SpouseEstEarnTaxAmt + SpouseOthWorkExpAmt - SpouseSsiCaidIrweAmt - SpouseBweAmt) OR (SsdiAmtSelfFull + SsdiAmtOtherFull + SsdiUnderPayIncreaseAmt - SsdiOverPayDecreaseAmt + UnearnAmt + SpouseDiAmtSelfFull + SpouseDiAmtOtherFull + SpouseUnEarnAmt+ SsiOrCaidEarnAmt + SpouseSsiOrCaidEarnAmt + SsiParDeemAmt +  SsiSpouseDeemUnearnAmt + SsiSpouseDeemEarnAmt + InKindPMVAmt) - (SsiCaidIrweAmt + BweAmt + SpouseSsiCaidIrweAmt + SpouseBweAmt + PassAmt)	IF SpouseSsiGet = Y AND ((SpouseEmployInvestAmt + SpouseDisWorkExpAmt + SpouseEstEarnTaxAmt + SpouseOthWorkExpAmt - SpouseSsiCaidIrweAmt - SpouseBweAmt) > 0) AND ((SsdiAmtSelfFull + SsdiAmtOtherFull +UnearnAmt +SpouseDiAmtSelfFull + SpouseDiAmtOtherFull + SpouseUnEarnAmt + SsiOrCaidEarnAmt + SpouseSsiOrCaidEarnAmt+ InKindPMVAmt + SsiParDeemAmt + SsiSpouseDeemUnearnAmt + SsiSpouseDeemEarnAmt) - (SeieAmt + SpouseSeieAmt + SsiCaidIrweAmt + BweAmt + SpouseSsiCaidIrweAmt + SpouseBweAmt + PassAmt) > 0))
@SpousePassAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '156',   :question_type => 'text_field',       :answer_choices => '',                          :order => 2,    :group_id => @Plan_for_Achieving_Self_Support.id)
@SpousePassAmt.name = 'SpousePassAmt'
@SpousePassAmt.text = 'How much is your spouse including in a PASS? (It may also be possible to include work expenses not already counted as IRWE or BWE.)	'
#156 IF SpouseSsiGet = Y AND ((SpouseEmployInvestAmt + SpouseDisWorkExpAmt + SpouseEstEarnTaxAmt + SpouseOthWorkExpAmt - SpouseSsiCaidIrweAmt - SpouseBweAmt) > 0) 
#AND ((SsdiAmtSelfFull + SsdiAmtOtherFull +UnearnAmt +SpouseDiAmtSelfFull + SpouseDiAmtOtherFull + SpouseUnEarnAmt + SsiOrCaidEarnAmt + SpouseSsiOrCaidEarnAmt+ InKindPMVAmt + SsiParDeemAmt + SsiSpouseDeemUnearnAmt + SsiSpouseDeemEarnAmt) 
#- (SeieAmt + SpouseSeieAmt + SsiCaidIrweAmt + BweAmt + SpouseSsiCaidIrweAmt + SpouseBweAmt + PassAmt) > 0))

@SpousePassAmt.display_rules = " 
SpouseSsiGet = manager.get_answer_by_question_name('SpouseSsiGet')
SpouseEmployInvestAmt = manager.get_answer_by_question_name('SpouseEmployInvestAmt')
if SpouseEmployInvestAmt != nil then
  SpouseEmployInvestAmt = Float(SpouseEmployInvestAmt)
else
  SpouseEmployInvestAmt = 0
end
SpouseDisWorkExpAmt = manager.get_answer_by_question_name('SpouseDisWorkExpAmt')
if SpouseDisWorkExpAmt != nil then
  SpouseDisWorkExpAmt = Float(SpouseDisWorkExpAmt)
else
  SpouseDisWorkExpAmt = 0
end
SpouseEstEarnTaxAmt = manager.get_answer_by_question_name('SpouseEstEarnTaxAmt')
if SpouseEstEarnTaxAmt != nil then
  SpouseEstEarnTaxAmt = Float(SpouseEstEarnTaxAmt)
else
  SpouseEstEarnTaxAmt = 0
end
SpouseOthWorkExpAmt = manager.get_answer_by_question_name('SpouseOthWorkExpAmt')
if SpouseOthWorkExpAmt != nil then
  SpouseOthWorkExpAmt = Float(SpouseOthWorkExpAmt)
else
  SpouseOthWorkExpAmt = 0
end
SpouseSsiCaidIrweAmt = manager.get_answer_by_question_name('SpouseSsiCaidIrweAmt')
if SpouseSsiCaidIrweAmt != nil then
  SpouseSsiCaidIrweAmt = Float(SpouseSsiCaidIrweAmt)
else
  SpouseSsiCaidIrweAmt = 0
end
SpouseBweAmt = manager.get_answer_by_question_name('SpouseBweAmt')
if SpouseBweAmt != nil then
  SpouseBweAmt = Float(SpouseBweAmt)
else
  SpouseBweAmt = 0
end
SsdiAmtSelfFull = manager.get_answer_by_question_name('SsdiAmtSelfFull')
if SsdiAmtSelfFull != nil then
  SsdiAmtSelfFull = Float(SsdiAmtSelfFull)
else
  SsdiAmtSelfFull = 0
end
SsdiAmtOtherFull = manager.get_answer_by_question_name('SsdiAmtOtherFull')
if SsdiAmtOtherFull != nil then
  SsdiAmtOtherFull = Float(SsdiAmtOtherFull)
else
  SsdiAmtOtherFull = 0
end
UnearnAmt = manager.get_answer_by_question_name('UnearnAmt')
if UnearnAmt != nil then
  UnearnAmt = Float(UnearnAmt)
else
  UnearnAmt = 0
end
SpouseDiAmtSelfFull = manager.get_answer_by_question_name('SpouseDiAmtSelfFull')
if SpouseDiAmtSelfFull != nil then
  SpouseDiAmtSelfFull = Float(SpouseDiAmtSelfFull)
else
  SpouseDiAmtSelfFull = 0
end
SpouseDiAmtOtherFull = manager.get_answer_by_question_name('SpouseDiAmtOtherFull')
if SpouseDiAmtOtherFull != nil then
  SpouseDiAmtOtherFull = Float(SpouseDiAmtOtherFull)
else
  SpouseDiAmtOtherFull = 0
end
SpouseUnEarnAmt = manager.get_answer_by_question_name('SpouseUnEarnAmt')
if SpouseUnEarnAmt != nil then
  SpouseUnEarnAmt = Float(SpouseUnEarnAmt)
else
  SpouseUnEarnAmt = 0
end
SsiOrCaidEarnAmt = manager.get_answer_by_question_name('SsiOrCaidEarnAmt')
if SsiOrCaidEarnAmt != nil then
  SsiOrCaidEarnAmt = Float(SsiOrCaidEarnAmt)
else
  SsiOrCaidEarnAmt = 0
end
SpouseSsiOrCaidEarnAmt = manager.get_answer_by_question_name('SpouseSsiOrCaidEarnAmt')
if SpouseSsiOrCaidEarnAmt != nil then
  SpouseSsiOrCaidEarnAmt = Float(SpouseSsiOrCaidEarnAmt)
else
  SpouseSsiOrCaidEarnAmt = 0
end
InKindPMVAmt = manager.get_answer_by_question_name('InKindPMVAmt')
if InKindPMVAmt != nil then
  InKindPMVAmt = Float(InKindPMVAmt)
else
  InKindPMVAmt = 0
end
SsiParDeemAmt = manager.get_answer_by_question_name('SsiParDeemAmt')
if SsiParDeemAmt != nil then
  SsiParDeemAmt = Float(SsiParDeemAmt)
else
  SsiParDeemAmt = 0
end
SsiSpouseDeemUnearnAmt = manager.get_answer_by_question_name('SsiSpouseDeemUnearnAmt')
if SsiSpouseDeemUnearnAmt != nil then
  SsiSpouseDeemUnearnAmt = Float(SsiSpouseDeemUnearnAmt)
else
  SsiSpouseDeemUnearnAmt = 0
end
SsiSpouseDeemEarnAmt = manager.get_answer_by_question_name('SsiSpouseDeemEarnAmt')
if SsiSpouseDeemEarnAmt != nil then
  SsiSpouseDeemEarnAmt = Float(SsiSpouseDeemEarnAmt)
else
  SsiSpouseDeemEarnAmt = 0
end
SeieAmt = manager.get_answer_by_question_name('SeieAmt')
if SeieAmt != nil then
  SeieAmt = Float(SeieAmt)
else
 SeieAmt = 0
end

SpouseSeieAmt = manager.get_answer_by_question_name('SpouseSeieAmt')
if SpouseSeieAmt != nil then
  SpouseSeieAmt = Float(SpouseSeieAmt)
else
  SpouseSeieAmt = 0
end

SpouseSsiCaidIrweAmt = manager.get_answer_by_question_name('SpouseSsiCaidIrweAmt')
if SpouseSsiCaidIrweAmt != nil then
  SpouseSsiCaidIrweAmt = Float(SpouseSsiCaidIrweAmt)
else
  SpouseSsiCaidIrweAmt = 0
end
SpouseBweAmt = manager.get_answer_by_question_name('SpouseBweAmt')
if SpouseBweAmt != nil then
  SpouseBweAmt = Float(SpouseBweAmt)
else
  SpouseBweAmt = 0
end
PassAmt = manager.get_answer_by_question_name('PassAmt')
if PassAmt != nil then
  PassAmt = Float(PassAmt)
else
  PassAmt = 0
end
SpouseSsiGet == 'Yes'  && ((SpouseEmployInvestAmt + SpouseDisWorkExpAmt + SpouseEstEarnTaxAmt + SpouseOthWorkExpAmt - SpouseSsiCaidIrweAmt - SpouseBweAmt) > 0)  \
  && ((SsdiAmtSelfFull + SsdiAmtOtherFull + UnearnAmt + SpouseDiAmtSelfFull + SpouseDiAmtOtherFull + SpouseUnEarnAmt + SsiOrCaidEarnAmt + SpouseSsiOrCaidEarnAmt + InKindPMVAmt + SsiParDeemAmt + SsiSpouseDeemUnearnAmt + SsiSpouseDeemEarnAmt)  \
    - (SeieAmt + SpouseSeieAmt + SsiCaidIrweAmt + BweAmt + SpouseSsiCaidIrweAmt + SpouseBweAmt + PassAmt) > 0)
"

#Zero or Positive Number <= SpouseEmployInvestAmt + SpouseDisWorkExpAmt + SpouseOthWorkExpAmt - SpouseSsiCaidIrweAmt - SpouseBweAmt
@SpousePassAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
SpouseEmployInvestAmt = manager.get_answer_by_question_name('SpouseEmployInvestAmt')
SpouseDisWorkExpAmt = manager.get_answer_by_question_name('SpouseDisWorkExpAmt')
SpouseOthWorkExpAmt = manager.get_answer_by_question_name('SpouseOthWorkExpAmt')
SpouseSsiCaidIrweAmt = manager.get_answer_by_question_name('SpouseSsiCaidIrweAmt')
SpouseBweAmt = manager.get_answer_by_question_name('SpouseBweAmt')

if SpouseEmployInvestAmt != nil then
 SpouseEmployInvestAmt = Float(SpouseEmployInvestAmt)
else
  SpouseEmployInvestAmt = 0
end

if SpouseDisWorkExpAmt != nil then
 SpouseDisWorkExpAmt = Float(SpouseDisWorkExpAmt)
else
  SpouseDisWorkExpAmt = 0
end

if EstEarnTaxAmt != nil then
 EstEarnTaxAmt = Float(EstEarnTaxAmt)
else
  EstEarnTaxAmt = 0
end

if SpouseOthWorkExpAmt != nil then
 SpouseOthWorkExpAmt = Float(SpouseOthWorkExpAmt)
else
  SpouseOthWorkExpAmt = 0
end

if SpouseSsiCaidIrweAmt != nil then
 SpouseSsiCaidIrweAmt = Float(SpouseSsiCaidIrweAmt)
else
  SsiCaidIrweAmt = 0
end

if SpouseBweAmt != nil then
 SpouseBweAmt = Float(SpouseBweAmt)
else
  SpouseBweAmt = 0
end

if answer != nil then
    true if ((Float(answer) >= 0) && Float(answer) <= (SpouseEmployInvestAmt + SpouseDisWorkExpAmt + SpouseOthWorkExpAmt - SpouseSsiCaidIrweAmt - SpouseBweAmt)) rescue false
  else 
    true
end
"

#NOTE to Bob can inputs ever align so that this question shows and then previous answers do not allow any ansser to validate?
#You can not enter a monthly PASS amount greater than the total amount of work expenses your spouse has after subtracting any money already included in an IRWE or BWE ($ EmployInvestAmt + DisWorkExpAmt + EstEarnTaxAmt + OthWorkExpAmt - SsiCaidIrweAmt - BweAmt).  Enter numbers only.  Do not enter $ or a decimal point. 
@SpousePassAmt.validation_message = "You can not enter a monthly PASS amount greater than the total amount of work expenses your spouse has after subtracting any money already included in an IRWE or BWE."
@SpousePassAmt.save!


#156 IF SpouseSsiGet = Y AND ((SpouseEmployInvestAmt + SpouseDisWorkExpAmt + SpouseEstEarnTaxAmt + SpouseOthWorkExpAmt - SpouseSsiCaidIrweAmt - SpouseBweAmt) > 0) 
#AND ((SsdiAmtSelfFull + SsdiAmtOtherFull +UnearnAmt +SpouseDiAmtSelfFull + SpouseDiAmtOtherFull + SpouseUnEarnAmt + SsiOrCaidEarnAmt + SpouseSsiOrCaidEarnAmt+ InKindPMVAmt + SsiParDeemAmt + SsiSpouseDeemUnearnAmt + SsiSpouseDeemEarnAmt) 
#- (SeieAmt + SpouseSeieAmt + SsiCaidIrweAmt + BweAmt + SpouseSsiCaidIrweAmt + SpouseBweAmt + PassAmt) > 0))

#25	157	Trial Work Period (TWP)	SubTab6_5_Twp						Active if any included questions appear and as described in WW-Web Behavior.doc
#25	158	Have you completed your Trial Work Period and Grace Period?	
#TwpComplete			YES:NO		YES	IF (Blind = N AND SsdiEarnAmt > RateSgaDisabledAmt) OR (Blind = Y AND SsdiEarnAmt > RateSgaBlindAmt)
@TwpComplete = Question.new(:display_rules => 'always', :default_answer => 'Yes',                  :reference_id =>   '158',   :question_type => 'select',       :answer_choices => 'Yes, No',                          :order => 1,    :group_id => @Trial_Work_Period.id)
@TwpComplete.name = 'TwpComplete'
@TwpComplete.text = 'Have you completed your Trial Work Period and Grace Period?'
#158 IF (Blind = N AND SsdiEarnAmt > RateSgaDisabledAmt) OR (Blind = Y AND SsdiEarnAmt > RateSgaBlindAmt)
@TwpComplete.display_rules = " 
Blind = manager.get_answer_by_question_name('Blind')
SsdiEarnAmt = manager.get_answer_by_question_name('SsdiEarnAmt')
if SsdiEarnAmt != nil then
  SsdiEarnAmt = Float(SsdiEarnAmt)
else
  SsdiEarnAmt = 0
end
RateSgaDisabledAmt = 1000
RateSgaBlindAmt = 1640
(Blind == 'No' && SsdiEarnAmt > RateSgaDisabledAmt) || (Blind == 'Yes' && SsdiEarnAmt > RateSgaBlindAmt)
"
@TwpComplete.save!

#25	159	Has your spouse completed the Trial Work Period and Grace Period?	
#SpouseTwpComplete			YES:NO		YES	IF (SpouseBlind = N AND SpouseSsdiEarnAmt > RateSgaDisabledAmt) OR (SpouseBlind = Y AND SpouseSsdiEarnAmt > RateSgaBlindAmt)
@SpouseTwpComplete = Question.new(:display_rules => 'always', :default_answer => 'Yes',                  :reference_id =>   '159',   :question_type => 'select',       :answer_choices => 'Yes, No',                          :order => 2,    :group_id => @Trial_Work_Period.id)
@SpouseTwpComplete.name = 'SpouseTwpComplete'
@SpouseTwpComplete.text = 'Has your spouse completed the Trial Work Period and Grace Period?'
#159 IF (SpouseBlind = N AND SpouseSsdiEarnAmt > RateSgaDisabledAmt) OR (SpouseBlind = Y AND SpouseSsdiEarnAmt > RateSgaBlindAmt)
@SpouseTwpComplete.display_rules = " 
SpouseBlind = manager.get_answer_by_question_name('SpouseBlind')
SpouseSsdiEarnAmt = manager.get_answer_by_question_name('SpouseSsdiEarnAmt')
if SpouseSsdiEarnAmt != nil then
  SpouseSsdiEarnAmt = Float(SpouseSsdiEarnAmt)
else
  SpouseSsdiEarnAmt = 0
end
RateSgaDisabledAmt = 1000
RateSgaBlindAmt = 1640
(SpouseBlind == 'No' && SpouseSsdiEarnAmt > RateSgaDisabledAmt) || (SpouseBlind == 'Yes' && SpouseSsdiEarnAmt > RateSgaBlindAmt)
"
@SpouseTwpComplete.save!

#25	160	Subsidies (SSDI)	SubTab6_6_Subsidy						Active if any included questions appear and as described in WW-Web Behavior.doc
#25	161	What is the dollar value (per month) of any subsidy you get for additonal supervision or special conditions provided to you because of your disability?	
#SubsidyEmpSupAmt			Zero or Positive Number <= SsdiEarnAmt	You can not enter an amount greater than the amount you earn (SsdiEarnAmt).  Enter numbers only.  Do not enter $ or decimal point.	0.00	IF TwpComplete = Y
@SubsidyEmpSupAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '161',   :question_type => 'text_field',       :answer_choices => '',                          :order => 1,    :group_id => @SubTab6_6_Subsidy.id)
@SubsidyEmpSupAmt.name = 'SubsidyEmpSupAmt'
@SubsidyEmpSupAmt.text = 'What is the dollar value (per month) of any subsidy you get for additonal supervision or special conditions provided to you because of your disability?'
#161 IF TwpComplete = Y
@SubsidyEmpSupAmt.display_rules = " 
TwpComplete = manager.get_answer_by_question_name('TwpComplete')
TwpComplete == 'Yes'
"
#Zero or Positive Number <= SsdiEarnAmt
@SubsidyEmpSupAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
SsdiEarnAmt = manager.get_answer_by_question_name('SsdiEarnAmt')

if SsdiEarnAmt != nil then
 SsdiEarnAmt = Float(SsdiEarnAmt)
else
  SsdiEarnAmt = 0
end
if answer != nil then
    true if ((Float(answer) >= 0) && (Float(answer) <= SsdiEarnAmt))  rescue false
  else 
    true
end
"
#You can not enter an amount greater than the amount you earn (SsdiEarnAmt).  Enter positive numbers only.  Do not enter $.
@SubsidyEmpSupAmt.validation_message = "You can not enter an amount greater than the amount you earn."
@SubsidyEmpSupAmt.save!

#25	162	What is the dollar value (per month) of any subsidy you get in for reduced work duties because of your disabiliy?	
#SubsidyWkDutiesReducAmt			Zero or Positive Number <= SsdiEarnAmt	You can not enter an amount greater than the amount you earn (SsdiEarnAmt).  Enter numbers only.  Do not enter $ or decimal point.	0.00	IF TwpComplete = Y
@SubsidyWkDutiesReducAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '162',   :question_type => 'text_field',       :answer_choices => '',                          :order => 2,    :group_id => @SubTab6_6_Subsidy.id)
@SubsidyWkDutiesReducAmt.name = 'SubsidyWkDutiesReducAmt'
@SubsidyWkDutiesReducAmt.text = 'What is the dollar value (per month) of any subsidy you get in for reduced work duties because of your disabiliy?'
#162 IF TwpComplete = Y
@SubsidyWkDutiesReducAmt.display_rules = " 
TwpComplete = manager.get_answer_by_question_name('TwpComplete')
TwpComplete == 'Yes'
"
@SubsidyWkDutiesReducAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
SsdiEarnAmt = manager.get_answer_by_question_name('SsdiEarnAmt')
if SsdiEarnAmt != nil then
 SsdiEarnAmt = Float(SsdiEarnAmt)
else
  SsdiEarnAmt = 0
end
if answer != nil then
    true if ((Float(answer) >= 0) && (Float(answer) <= SsdiEarnAmt))  rescue false
  else 
    true
end
"
#You can not enter an amount greater than the amount you earn (SsdiEarnAmt).  Enter positive numbers only.  Do not enter $.
@SubsidyWkDutiesReducAmt.validation_message = "You can not enter an amount greater than the amount you earn."
@SubsidyWkDutiesReducAmt.save!

#25	163	What is the dollar value (per month) of any subsidy your spouse gets for additonal supervision or special conditions provided because of your spouse's disability?	
#SpouseSubsidyEmpSupAmt			Zero or Positive Number <= SpouseSsdiEarnAmt	You can not enter an amount greater than the amount your spouse earns (SpouseSsdiEarnAmt).  Enter numbers only.  Do not enter $ or decimal point.	0.00	IF SpouseTwpComplete = Y
@SpouseSubsidyEmpSupAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '163',   :question_type => 'text_field',       :answer_choices => '',                          :order => 3,    :group_id => @SubTab6_6_Subsidy.id)
@SpouseSubsidyEmpSupAmt.name = 'SpouseSubsidyEmpSupAmt'
@SpouseSubsidyEmpSupAmt.text = 'What is the dollar value (per month) of any subsidy your spouse gets for additonal supervision or special conditions provided because of your spouse\'s disability?'
#163 IF SpouseTwpComplete = Y
@SpouseSubsidyEmpSupAmt.display_rules = " 
SpouseTwpComplete = manager.get_answer_by_question_name('SpouseTwpComplete')
SpouseTwpComplete == 'Yes'
"
#Zero or Positive Number <= SpouseSsdiEarnAmt
@SpouseSubsidyEmpSupAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
SpouseSsdiEarnAmt = manager.get_answer_by_question_name('SpouseSsdiEarnAmt')
if SpouseSsdiEarnAmt != nil then
 SpouseSsdiEarnAmt = Float(SpouseSsdiEarnAmt)
else
  SpouseSsdiEarnAmt = 0
end
if answer != nil then
    true if ((Float(answer) >= 0) && (Float(answer) <= SpouseSsdiEarnAmt))  rescue false
  else 
    true
end
"
#You can not enter an amount greater than the amount your spouse earns (SpouseSsdiEarnAmt).  Enter positive numbers only.  Do not enter $.
@SpouseSubsidyEmpSupAmt.validation_message = "You can not enter an amount greater than the amount your spouse earns."
@SpouseSubsidyEmpSupAmt.save!

#25	164	What is the dollar value (per month) of any subsidy your spouse gets in for reduced work duties because of your spouse's disabiliy?	
#SpouseSubsidyWkDutiesReducAmt			Zero or Positive Number <= SpouseSsdiEarnAmt	You can not enter an amount greater than the amount your spouse earns (SpouseSsdiEarnAmt).  Enter numbers only.  Do not enter $ or decimal point.	0.00	IF SpouseTwpComplete = Y
@SpouseSubsidyWkDutiesReducAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '164',   :question_type => 'text_field',       :answer_choices => '',                          :order => 4,    :group_id => @SubTab6_6_Subsidy.id)
@SpouseSubsidyWkDutiesReducAmt.name = 'SpouseSubsidyWkDutiesReducAmt'
@SpouseSubsidyWkDutiesReducAmt.text = 'What is the dollar value (per month) of any subsidy your spouse gets in for reduced work duties because of your spouse\'s disabiliy?'
#164 IF SpouseTwpComplete = Y
@SpouseSubsidyWkDutiesReducAmt.display_rules = " 
SpouseTwpComplete = manager.get_answer_by_question_name('SpouseTwpComplete')
SpouseTwpComplete == 'Yes'
"
@SpouseSubsidyWkDutiesReducAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
SpouseSsdiEarnAmt = manager.get_answer_by_question_name('SpouseSsdiEarnAmt')
if SpouseSsdiEarnAmt != nil then
 SpouseSsdiEarnAmt = Float(SpouseSsdiEarnAmt)
else
  SpouseSsdiEarnAmt = 0
end
if answer != nil then
    true if ((Float(answer) >= 0) && (Float(answer) <= SpouseSsdiEarnAmt))  rescue false
  else 
    true
end
"
#You can not enter an amount greater than the amount your spouse earns (SpouseSsdiEarnAmt).  Enter positive numbers only.  Do not enter $.
@SpouseSubsidyWkDutiesReducAmt.validation_message = "You can not enter an amount greater than the amount your spouse earns."
@SpouseSubsidyWkDutiesReducAmt.save!

#25	165	Benefit Amount Adjustments	Tab7_BenefitAdjust						Active if any included Sub-tabs are active and as described in WW-Web Behavior.doc
#25	166	Own SSDI Benefit Adjustments	SubTab7_1_OwnDiBenefitAdjust						Active if any included questions appear and as described in WW-Web Behavior.doc

#Bob NOTE we have a "if Sit is current"  display rule that will need some help later, for now everything is current
#25	167	What is the actual amount of the monthly SSDI payment that you receive? (Do not count payment amounts to other family members, if any.)	
#167 new name SsdiActualAmt
#SsdiActualAmt			Zero or Positive Number 	Enter numbers only.  Do not enter $ or decimal point.	EXPRESSION: (SsdiAmtSelfFull OR SsdiAmtOtherFull) - (Medicare Part B Premium of 45.50 in 2000 if CareBDeduct NOT = N)  - DIOverAmt + DIUnderAmt	If Current/What-If Button = Current AND DiGet = Y
@SsdiActualAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '167',   :question_type => 'text_field',       :answer_choices => '',                          :order => 1,    :group_id => @SubTab7_1_OwnDiBenefitAdjust.id)
@SsdiActualAmt.name = 'SsdiActualAmt'
@SsdiActualAmt.text = 'What is the actual amount of the monthly SSDI payment that you receive? (Do not count payment amounts to other family members, if any.)'
#167 If Current/What-If Button = Current AND DiGet = Y
@SsdiActualAmt.display_rules = " 
DiGet = manager.get_answer_by_question_name('DiGet')
DiGet == 'Yes'
"
@SsdiActualAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
if answer != nil then
    true if (Float(answer) >= 0) rescue false
  else 
    true
end
"
@SsdiActualAmt.validation_message = "Enter positive numbers only.  Do not enter $."
@SsdiActualAmt.save!

#note this appearance rule refers to a calculation, skip some of the appearance rule for now  WebCalc.find_by_name('name')
#25	168	How much is being subtracted from your SSDI award amount because of Workers Compensation or a Public Disability Benefit?	
#New name SsdiWcOrPdbDecreaseAmt
#SsdiWcOrPdbDecreaseAmt			Zero or Positive Number 	Enter numbers only.  Do not enter $ or decimal point.	0.00	If (R_ActualSsdiPayNotEqualCareBAdjust = TRUE) OR (Current/What-If Button = What-If AND DiGet = Y) 
@SsdiWcOrPdbDecreaseAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '168',   :question_type => 'text_field',       :answer_choices => '',                          :order => 2,    :group_id => @SubTab7_1_OwnDiBenefitAdjust.id)
@SsdiWcOrPdbDecreaseAmt.name = 'SsdiWcOrPdbDecreaseAmt'
@SsdiWcOrPdbDecreaseAmt.text = 'How much is being subtracted from your SSDI award amount because of Workers Compensation or a Public Disability Benefit?  Note display rule relates to numeric calcs not complete'
#168 If (R_ActualSsdiPayNotEqualCareBAdjust = TRUE) OR (Current/What-If Button = What-If AND DiGet = Y) 
@SsdiWcOrPdbDecreaseAmt.display_rules = " 
DiGet = manager.get_answer_by_question_name('DiGet')
DiGet == 'Yes'
"
@SsdiWcOrPdbDecreaseAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
if answer != nil then
    true if (Float(answer) >= 0) rescue false
  else 
    true
end
"
@SsdiWcOrPdbDecreaseAmt.validation_message = "Enter positive numbers only.  Do not enter $."
@SsdiWcOrPdbDecreaseAmt.save!

#25	169	How much is being added monthly to your SSDI check because of a previous underpayment?	
#New name SsdiUnderPayIncreaseAmt
#SsdiUnderPayIncreaseAmt			Zero or Positive Number	Enter numbers only.  Do not enter $ or decimal point.	0.00	If (R_ActualSsdiPayNotEqualCareBAdjust = TRUE) OR (Current/What-If Button = What-If AND DiGet = Y) 
@SsdiUnderPayIncreaseAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '169',   :question_type => 'text_field',       :answer_choices => '',                          :order => 3,    :group_id => @SubTab7_1_OwnDiBenefitAdjust.id)
@SsdiUnderPayIncreaseAmt.name = 'SsdiUnderPayIncreaseAmt'
@SsdiUnderPayIncreaseAmt.text = 'How much is being added monthly to your SSDI check because of a previous underpayment?  Note display rule relates to numeric calcs not complete'
#169 If (R_ActualSsdiPayNotEqualCareBAdjust = TRUE) OR (Current/What-If Button = What-If AND DiGet = Y) 
@SsdiUnderPayIncreaseAmt.display_rules = " 
DiGet = manager.get_answer_by_question_name('DiGet')
DiGet == 'Yes'
"
@SsdiUnderPayIncreaseAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
if answer != nil then
    true if (Float(answer) >= 0) rescue false
  else 
    true
end
"
@SsdiUnderPayIncreaseAmt.validation_message = "Enter positive numbers only.  Do not enter $."
@SsdiUnderPayIncreaseAmt.save!


#25	170	During the time you were underpaid SSDI, did you receive an increased SSI check because of the underpayment?
#new name SsiWhileSsdiUnderPay	
#SsiWhileSsdiUnderPay			YES:NO		NO	IF SsdiUnderPayIncreaseAmt > 0.00 AND SsiGet = Y
@SsiWhileSsdiUnderPay = Question.new(:display_rules => 'always', :default_answer => 'No',                  :reference_id =>   '170',   :question_type => 'select',       :answer_choices => 'Yes, No',                          :order => 4,    :group_id => @SubTab7_1_OwnDiBenefitAdjust.id)
@SsiWhileSsdiUnderPay.name = 'SsiWhileSsdiUnderPay'
@SsiWhileSsdiUnderPay.text = 'During the time you were underpaid SSDI, did you receive an increased SSI check because of the underpayment?'
#170 IF SsdiUnderPayIncreaseAmt > 0.00 AND SsiGet = Y
@SsiWhileSsdiUnderPay.display_rules = " 
SsdiUnderPayIncreaseAmt = manager.get_answer_by_question_name('SsdiUnderPayIncreaseAmt')
 if SsdiUnderPayIncreaseAmt != nil then
   SsdiUnderPayIncreaseAmt = Float(SsdiUnderPayIncreaseAmt)
 else
   SsdiUnderPayIncreaseAmt = 0
 end
SsiGet = manager.get_answer_by_question_name('SsiGet')
(SsdiUnderPayIncreaseAmt > 0.00) && SsiGet == 'Yes'
"
@SsiWhileSsdiUnderPay.save!

#25	171	How much is being deducted monthly from your SSDI check because of a previous overpayment?
#new name SsdiOverPayDecreaseAmt	
#SsdiOverPayDecreaseAmt			Zero or Positive Number	Enter numbers only.  Do not enter $ or decimal point.	0.00	If (R_ActualSsdiPayNotEqualCareBAdjust = TRUE) OR (Current/What-If Button = What-If AND DiGet = Y) 
@SsdiOverPayDecreaseAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '171',   :question_type => 'text_field',       :answer_choices => '',                          :order => 5,    :group_id => @SubTab7_1_OwnDiBenefitAdjust.id)
@SsdiOverPayDecreaseAmt.name = 'SsdiOverPayDecreaseAmt'
@SsdiOverPayDecreaseAmt.text = 'How much is being deducted monthly from your SSDI check because of a previous overpayment?  Note display rule relates to numeric calcs not complete'
#171 If (R_ActualSsdiPayNotEqualCareBAdjust = TRUE) OR (Current/What-If Button = What-If AND DiGet = Y) 

@SsdiOverPayDecreaseAmt.display_rules = " 
DiGet = manager.get_answer_by_question_name('DiGet')
DiGet == 'Yes'
"
#Bob has note to DR about stiffining up this display rule
@SsdiOverPayDecreaseAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
if answer != nil then
    true if (Float(answer) >= 0) rescue false
  else 
    true
end
"
@SsdiOverPayDecreaseAmt.validation_message = "Enter positive numbers only.  Do not enter $."
@SsdiOverPayDecreaseAmt.save!

#25	172	During the time you were overpaid SSDI, did you receive a reduced SSI check because of the overpayment?	
#new SsiWhileSsdiOverPay
#SsiWhileSsdiOverPay			YES:NO		NO	If SsdiOverPayDecreaseAmt > 0 AND SsiGet = Y
@SsiWhileSsdiOverPay = Question.new(:display_rules => 'always', :default_answer => 'No',                  :reference_id =>   '172',   :question_type => 'select',       :answer_choices => 'Yes, No',                          :order => 6,    :group_id => @SubTab7_1_OwnDiBenefitAdjust.id)
@SsiWhileSsdiOverPay.name = 'SsiWhileSsdiOverPay'
@SsiWhileSsdiOverPay.text = 'During the time you were overpaid SSDI, did you receive a reduced SSI check because of the overpayment?'
#172 If SsdiOverPayDecreaseAmt > 0 AND SsiGet = Y
@SsiWhileSsdiOverPay.display_rules = " 
SsdiOverPayDecreaseAmt = manager.get_answer_by_question_name('SsdiOverPayDecreaseAmt')
 if SsdiOverPayDecreaseAmt != nil then
   SsdiOverPayDecreaseAmt = Float(SsdiOverPayDecreaseAmt)
 else
   SsdiOverPayDecreaseAmt = 0
 end
SsiGet = manager.get_answer_by_question_name('SsiGet')
(SsdiOverPayDecreaseAmt > 0.00) && SsiGet == 'Yes'
"
@SsiWhileSsdiOverPay.save!

#25	173	Spouse SSDI Benefit Adjustments	SubTab7_2_SpouseSsdiBenefitAdjust		Active if any included questions appear and as described in WW-Web Behavior.doc
#25	174	What is the actual amount of the monthly SSDI payment that your spouse receives?	
#new SpouseSsdiActualAmt
#SpouseSsdiActualAmt			Zero or Positive Number 	Enter numbers only.  Do not enter $ or decimal point.	0.00	IF Current/What-If Button = Current AND SpouseSsdiGet = Y
@SpouseSsdiActualAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '174',   :question_type => 'text_field',       :answer_choices => '',                          :order => 1,    :group_id => @SubTab7_2_SpouseSsdiBenefitAdjust.id)
@SpouseSsdiActualAmt.name = 'SpouseSsdiActualAmt'
@SpouseSsdiActualAmt.text = 'What is the actual amount of the monthly SSDI payment that your spouse receives?'
#174 IF Current/What-If Button = Current AND SpouseSsdiGet = Y
@SpouseSsdiActualAmt.display_rules = " 
SpouseSsdiGet = manager.get_answer_by_question_name('SpouseSsdiGet')
SpouseSsdiGet == 'Yes'
"
@SpouseSsdiActualAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
if answer != nil then
    true if (Float(answer) >= 0) rescue false
  else 
    true
end
"
@SpouseSsdiActualAmt.validation_message = "Enter positive numbers only.  Do not enter $."
@SpouseSsdiActualAmt.save!

#25	175	How much is being subtracted monthly from your spouse's SSDI award amount because of Workers Compensation or a Public Disability Benefit?	
#new SpouseSsdiWcOrPdbDecreaseAmt
#SpouseSsdiWcOrPdbDecreaseAmt			Zero or Positive Number 	Enter numbers only.  Do not enter $ or decimal point.	0.00	If (R_SpouseActualSsdiPayNotEqualCareBAdjust = TRUE) OR (Current/What-If Button = What-If AND SpouseSsdiGet = Y) 
@SpouseSsdiWcOrPdbDecreaseAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '175',   :question_type => 'text_field',       :answer_choices => '',                          :order => 2,    :group_id => @SubTab7_2_SpouseSsdiBenefitAdjust.id)
@SpouseSsdiWcOrPdbDecreaseAmt.name = 'SpouseSsdiWcOrPdbDecreaseAmt'
@SpouseSsdiWcOrPdbDecreaseAmt.text = 'How much is being subtracted monthly from your spouse\'s SSDI award amount because of Workers Compensation or a Public Disability Benefit?  Note display rule relates to numeric calcs not complete'
#175 If (R_SpouseActualSsdiPayNotEqualCareBAdjust = TRUE) OR (Current/What-If Button = What-If AND SpouseSsdiGet = Y) 
@SpouseSsdiWcOrPdbDecreaseAmt.display_rules = " 
SpouseSsdiGet = manager.get_answer_by_question_name('SpouseSsdiGet')
SpouseSsdiGet == 'Yes'
"
@SpouseSsdiWcOrPdbDecreaseAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
if answer != nil then
    true if (Float(answer) >= 0) rescue false
  else 
    true
end
"
@SpouseSsdiWcOrPdbDecreaseAmt.validation_message = "Enter positive numbers only.  Do not enter $."
@SpouseSsdiWcOrPdbDecreaseAmt.save!

#25	176	How much is being added to your spouse's SSDI check because of a previous underpayment?	
#new SpouseSsdiUnderPayIncreaseAmt
#SpouseSsdiUnderPayIncreaseAmt			Zero or Positive Number	Enter numbers only.  Do not enter $ or decimal point.	0.00	If (R_SpouseActualSsdiPayNotEqualCareBAdjust = TRUE) OR (Current/What-If Button = What-If AND DiGet = Y) 
@SpouseSsdiUnderPayIncreaseAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '169',   :question_type => 'text_field',       :answer_choices => '',                          :order => 3,    :group_id => @SubTab7_2_SpouseSsdiBenefitAdjust.id)
@SpouseSsdiUnderPayIncreaseAmt.name = 'SpouseSsdiUnderPayIncreaseAmt'
@SpouseSsdiUnderPayIncreaseAmt.text = 'How much is being added to your spouse\'s SSDI check because of a previous underpayment?  Note display rule relates to numeric calcs not complete'
#176 If (R_SpouseActualSsdiPayNotEqualCareBAdjust = TRUE) OR (Current/What-If Button = What-If AND DiGet = Y) 
# 10/19/2010 display rule review
#If (R_SpouseActualSsdiPayNotEqualCareBAdjust = TRUE) OR (Current/What-If Button = What-If AND SpouseSsdiGet = Y) 
## This needs fixing
@SpouseSsdiUnderPayIncreaseAmt.display_rules = " 
SpouseSsdiGet = manager.get_answer_by_question_name('SpouseSsdiGet')
R_SpouseActualSsdiPayNotEqualCareBAdjust = false
R_SpouseActualSsdiPayNotEqualCareBAdjust = true && SpouseSsdiGet == 'Yes'
"
@SpouseSsdiUnderPayIncreaseAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
if answer != nil then
    true if (Float(answer) >= 0) rescue false
  else 
    true
end
"
@SpouseSsdiUnderPayIncreaseAmt.validation_message = "Enter positive numbers only.  Do not enter $."
@SpouseSsdiUnderPayIncreaseAmt.save!

#25	177	During the time your spouse was underpaid SSDI, did your spouse receive an increased SSI check because of the underpayment?	
#New SpouseSsiWhileSsdiUnderPay
#SpouseSsiWhileSsdiUnderPay			YES:NO		NO	IF SpouseSsdiUnderPayIncreaseAmt > 0.00 AND SpouseSsiGet = Y
@SpouseSsiWhileSsdiUnderPay = Question.new(:display_rules => 'always', :default_answer => 'No',                  :reference_id =>   '177',   :question_type => 'select',       :answer_choices => 'Yes, No',                          :order => 4,    :group_id => @SubTab7_2_SpouseSsdiBenefitAdjust.id)
@SpouseSsiWhileSsdiUnderPay.name = 'SpouseSsiWhileSsdiUnderPay'
@SpouseSsiWhileSsdiUnderPay.text = 'During the time your spouse was underpaid SSDI, did your spouse receive an increased SSI check because of the underpayment?'
#177 IF SpouseSsdiUnderPayIncreaseAmt > 0.00 AND SpouseSsiGet = Y
@SpouseSsiWhileSsdiUnderPay.display_rules = " 
SpouseSsdiUnderPayIncreaseAmt = manager.get_answer_by_question_name('SpouseSsdiUnderPayIncreaseAmt')
 if SpouseSsdiUnderPayIncreaseAmt != nil then
   SpouseSsdiUnderPayIncreaseAmt = Float(SpouseSsdiUnderPayIncreaseAmt)
 else
   SpouseSsdiUnderPayIncreaseAmt = 0
 end
SpouseSsiGet = manager.get_answer_by_question_name('SpouseSsiGet')
(SpouseSsdiUnderPayIncreaseAmt > 0) && SpouseSsiGet == 'Yes'
"
@SpouseSsiWhileSsdiUnderPay.save!


#25	178	How much is being deducted from your spouse's SSDI check because of a previous overpayment?	
#new SpouseSsdiOverPayDecreaseAmt
#SpouseSsdiOverPayDecreaseAmt			Zero or Positive Number	Enter numbers only.  Do not enter $ or decimal point.	0.00	If (R_SpouseActualSsdiPayNotEqualCareBAdjust = TRUE) OR (Current/What-If Button = What-If AND SpouseSsdiGet = Y) 
@SpouseSsdiOverPayDecreaseAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '178',   :question_type => 'text_field',       :answer_choices => '',                          :order => 5,    :group_id => @SubTab7_2_SpouseSsdiBenefitAdjust.id)
@SpouseSsdiOverPayDecreaseAmt.name = 'SpouseSsdiOverPayDecreaseAmt'
@SpouseSsdiOverPayDecreaseAmt.text = 'How much is being deducted from your spouse\'s SSDI check because of a previous overpayment?  Note display rule relates to numeric calcs not complete'
#178 If (R_SpouseActualSsdiPayNotEqualCareBAdjust = TRUE) OR (Current/What-If Button = What-If AND SpouseSsdiGet = Y) 
@SpouseSsdiOverPayDecreaseAmt.display_rules = " 
SpouseSsdiGet = manager.get_answer_by_question_name('SpouseSsdiGet')
SpouseSsdiGet == 'Yes'
"
@SpouseSsdiOverPayDecreaseAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
if answer != nil then
    true if (Float(answer) >= 0) rescue false
  else 
    true
end
"
@SpouseSsdiOverPayDecreaseAmt.validation_message = "Enter positive numbers only.  Do not enter $."
@SpouseSsdiOverPayDecreaseAmt.save!


#25	179	During the time your spouse was overpaid SSDI, did your spouse receive a reduced SSI check because of the overpayment?
#New SpouseSsiWhileSsdiOverPay	
#SpouseSsiWhileSsdiOverPay			YES:NO		NO	If SpouseSsdiOverPayDecreaseAmt > 0 AND SpouseSsiGet = Y
@SpouseSsiWhileSsdiOverPay = Question.new(:display_rules => 'always', :default_answer => 'No',                  :reference_id =>   '179',   :question_type => 'select',       :answer_choices => 'Yes, No',                          :order => 6,    :group_id => @SubTab7_2_SpouseSsdiBenefitAdjust.id)
@SpouseSsiWhileSsdiOverPay.name = 'SpouseSsiWhileSsdiOverPay'
@SpouseSsiWhileSsdiOverPay.text = 'During the time your spouse was overpaid SSDI, did your spouse receive a reduced SSI check because of the overpayment?'
#179 If SpouseSsdiOverPayDecreaseAmt > 0 AND SpouseSsiGet = Y
@SpouseSsiWhileSsdiOverPay.display_rules = " 
SpouseSsdiOverPayDecreaseAmt = manager.get_answer_by_question_name('SpouseSsdiOverPayDecreaseAmt')
 if SpouseSsdiOverPayDecreaseAmt != nil then
   SpouseSsdiOverPayDecreaseAmt = Float(SpouseSsdiOverPayDecreaseAmt)
 else
   SpouseSsdiOverPayDecreaseAmt = 0
 end
SpouseSsiGet = manager.get_answer_by_question_name('SpouseSsiGet')
(SpouseSsdiOverPayDecreaseAmt > 0.00) && SpouseSsiGet == 'Yes'
"
@SpouseSsiWhileSsdiOverPay.save!

#25	180	SSI Benefit Adjustments	SubTab7_3_SsiBenefitAdjust						Active if any included questions appear and as described in WW-Web Behavior.doc
#25	181	What is the actual amount of your monthly SSI Check?	
#SsiUserActualAmt			Zero or Positive Number 	Enter numbers only.  Do not enter $ or decimal point.	0.00	If Current/What-If Button = Current AND SsiGet = Y AND SpouseSsiGet <> Y
@SsiUserActualAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '181',   :question_type => 'text_field',       :answer_choices => '',                          :order => 1,    :group_id => @SubTab7_3_SsiBenefitAdjust.id)
@SsiUserActualAmt.name = 'SsiUserActualAmt'
@SsiUserActualAmt.text = 'What is the actual amount of your monthly SSI Check?'
#181 If Current/What-If Button = Current AND SsiGet = Y AND SpouseSsiGet <> Y
@SsiUserActualAmt.display_rules = " 
SsiGet = manager.get_answer_by_question_name('SsiGet')
SpouseSsiGet = manager.get_answer_by_question_name('SpouseSsiGet')
SsiGet == 'Yes' && SpouseSsiGet != 'Yes'
"
@SsiUserActualAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
if answer != nil then
    true if (Float(answer) >= 0) rescue false
  else 
    true
end
"
@SsiUserActualAmt.validation_message = "Enter positive numbers only.  Do not enter $."
@SsiUserActualAmt.save!

#25	182	What is the actual total amount of the SSI Checks that you and your spouse receive?	
#SsiCoupleActualAmt			Zero or Positive Number 	Enter numbers only.  Do not enter $ or decimal point.	0.00	If Current/What-If Button = Current AND SsiGet = Y AND SpouseSsiGet = Y
@SsiCoupleActualAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '182',   :question_type => 'text_field',       :answer_choices => '',                          :order => 2,    :group_id => @SubTab7_3_SsiBenefitAdjust.id)
@SsiCoupleActualAmt.name = 'SsiCoupleActualAmt'
@SsiCoupleActualAmt.text = 'What is the actual total amount of the SSI Checks that you and your spouse receive?'
#182 If Current/What-If Button = Current AND SsiGet = Y AND SpouseSsiGet = Y
@SsiCoupleActualAmt.display_rules = " 
SsiGet = manager.get_answer_by_question_name('SsiGet')
SpouseSsiGet = manager.get_answer_by_question_name('SpouseSsiGet')
SsiGet == 'Yes' && SpouseSsiGet == 'Yes'
"
@SsiCoupleActualAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
if answer != nil then
    true if (Float(answer) >= 0) rescue false
  else 
    true
end
"
@SsiCoupleActualAmt.validation_message = "Enter positive numbers only.  Do not enter $."
@SsiCoupleActualAmt.save!

#25	183	How much is being added to your SSI benefit because of a previous underpayment?	
#SsiUserUnderPayAddAmt			Zero or Positive Number	Enter numbers only.  Do not enter $ or decimal point.	0.00	If SpouseSsiGet <> Y AND ((Current/What-If Button = What-If AND SsiGet = Y) OR R_ActualSsiGreaterThanCalcSsiNoOverUnderAdjust = TRUE)
@SsiUserUnderPayAddAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '183',   :question_type => 'text_field',       :answer_choices => '',                          :order => 3,    :group_id => @SubTab7_3_SsiBenefitAdjust.id)
@SsiUserUnderPayAddAmt.name = 'SsiUserUnderPayAddAmt'
@SsiUserUnderPayAddAmt.text = 'How much is being added to your SSI benefit because of a previous underpayment?  NOTE Display rule incomplete'
#183 If SpouseSsiGet <> Y AND ((Current/What-If Button = What-If AND SsiGet = Y) OR R_ActualSsiGreaterThanCalcSsiNoOverUnderAdjust = TRUE)
@SsiUserUnderPayAddAmt.display_rules = " 
SsiGet = manager.get_answer_by_question_name('SsiGet')
SpouseSsiGet = manager.get_answer_by_question_name('SpouseSsiGet')
SsiGet == 'Yes' && SpouseSsiGet != 'Yes'
"
@SsiUserUnderPayAddAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
if answer != nil then
    true if (Float(answer) >= 0) rescue false
  else 
    true
end
"
@SsiUserUnderPayAddAmt.validation_message = "Enter positive numbers only.  Do not enter $."
@SsiUserUnderPayAddAmt.save!

#25	184	How much is being deducted from your SSI benefit because of a previous overpayment?	
#SsiUserOverPayDeductAmt			Zero or Positive Number	Enter numbers only.  Do not enter $ or decimal point.	0.00	If SpouseSsiGet <> Y AND ((Current/What-If Button = What-If AND SsiGet = Y) OR R_ActualSsiLessThanCalcSsiNoOverUnderAdjust = TRUE)
@SsiUserOverPayDeductAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '184',   :question_type => 'text_field',       :answer_choices => '',                          :order => 4,    :group_id => @SubTab7_3_SsiBenefitAdjust.id)
@SsiUserOverPayDeductAmt.name = 'SsiUserOverPayDeductAmt'
@SsiUserOverPayDeductAmt.text = 'How much is being deducted from your SSI benefit because of a previous overpayment?  NOTE Display rule incomplete'
#184 If SpouseSsiGet <> Y AND ((Current/What-If Button = What-If AND SsiGet = Y) OR R_ActualSsiLessThanCalcSsiNoOverUnderAdjust = TRUE)
#Note this display rule has a calc not yet implemnted and not included
@SsiUserOverPayDeductAmt.display_rules = " 
SsiGet = manager.get_answer_by_question_name('SsiGet')
SpouseSsiGet = manager.get_answer_by_question_name('SpouseSsiGet')
SsiGet == 'Yes' && SpouseSsiGet != 'Yes'
"
@SsiUserOverPayDeductAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
if answer != nil then
    true if (Float(answer) >= 0) rescue false
  else 
    true
end
"
@SsiUserOverPayDeductAmt.validation_message = "Enter positive numbers only.  Do not enter $."

@SsiUserOverPayDeductAmt.save!

#25	185	How much is being added to your spouse's and your SSI benefit because of a previous underpayment?	
#SsiCoupleUnderPayAddAmt			Zero or Positive Number	Enter numbers only.  Do not enter $ or decimal point.	0.00	If SpouseSsiGet = Y AND ((Current/What-If Button = What-If AND SsiGet = Y) OR R_ActualSsiGreaterThanCalcSsiNoOverUnderAdjust = TRUE)
@SsiCoupleUnderPayAddAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '185',   :question_type => 'text_field',       :answer_choices => '',                          :order => 5,    :group_id => @SubTab7_3_SsiBenefitAdjust.id)
@SsiCoupleUnderPayAddAmt.name = 'SsiCoupleUnderPayAddAmt'
@SsiCoupleUnderPayAddAmt.text = 'How much is being added to your spouse\'s and your SSI benefit because of a previous underpayment?  NOTE Display rule incomplete'
#185 If SpouseSsiGet = Y AND ((Current/What-If Button = What-If AND SsiGet = Y) OR R_ActualSsiGreaterThanCalcSsiNoOverUnderAdjust = TRUE)
@SsiCoupleUnderPayAddAmt.display_rules = " 
SsiGet = manager.get_answer_by_question_name('SsiGet')
SpouseSsiGet = manager.get_answer_by_question_name('SpouseSsiGet')
SsiGet == 'Yes' && SpouseSsiGet == 'Yes'
"
@SsiCoupleUnderPayAddAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
if answer != nil then
    true if (Float(answer) >= 0) rescue false
  else 
    true
end
"
@SsiCoupleUnderPayAddAmt.validation_message = "Enter positive numbers only.  Do not enter $."

@SsiCoupleUnderPayAddAmt.save!

#25	186	How much is being deducted from your SSI check because of a previous overpayment?	  Note sent to DR about wording change needed 
#SsiCoupleOverPayDeductAmt			Zero or Positive Number	Enter numbers only.  Do not enter $ or decimal point.	0.00	If SpouseSsiGet = Y AND ((Current/What-If Button = What-If AND SsiGet = Y) OR R_ActualSsiLessThanCalcSsiNoOverUnderAdjust = TRUE)
@SsiCoupleOverPayDeductAmt = Question.new(:display_rules => 'always', :default_answer => '0.00',                  :reference_id =>   '186',   :question_type => 'text_field',       :answer_choices => '',                          :order => 6,    :group_id => @SubTab7_3_SsiBenefitAdjust.id)
@SsiCoupleOverPayDeductAmt.name = 'SsiCoupleOverPayDeductAmt'
@SsiCoupleOverPayDeductAmt.text = 'How much is being deducted from your spouse\'s and your SSI benefit because of a previous overpayment?'
# NOTE Display rule incomplete'
#186 If SpouseSsiGet = Y AND ((Current/What-If Button = What-If AND SsiGet = Y) OR R_ActualSsiLessThanCalcSsiNoOverUnderAdjust = TRUE)
@SsiCoupleOverPayDeductAmt.display_rules = " 
SsiGet = manager.get_answer_by_question_name('SsiGet')
SpouseSsiGet = manager.get_answer_by_question_name('SpouseSsiGet')
SsiGet == 'Yes' && SpouseSsiGet == 'Yes'
"
@SsiCoupleOverPayDeductAmt.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
if answer != nil then
    true if (Float(answer) >= 0) rescue false
  else 
    true
end
"
@SsiCoupleOverPayDeductAmt.validation_message = "Enter positive numbers only.  Do not enter $."
@SsiCoupleOverPayDeductAmt.save!


####                                                     Web Tips
# Create web tips
WebTip.delete_all
WebTip.create!( :identifier => 'CSI-1a',          :display_rules => 'always',   :group_id => @startup.id ,  :question_id => nil,     :text => 'You must first answer questions about your current situation.  Once you enter your birth date, you can select (click on or tab into) the answers to any of the other questions on this page if you want to change them from the default answers. ')
WebTip.create!( :identifier => 'CSI-1b',          :display_rules => 'always',   :group_id => @startup.id ,  :question_id => nil,     :text => 'You must first answer questions about your current situation.  You can select (click on or tab into) the answers to any of the other questions on this page if you want to change them from the default answers. ')
WebTip.create!( :identifier => 'CSI-2',          :display_rules => 'always',   :group_id => @startup.id ,  :question_id => nil,     :text => 'When all of the answers are correct for your current situation, you can select the Accept button on the bottom left.  New tips, warnings or recommendations based on your answers will then appear in this space.  You can then select the Continue button to go on to the next set of questions.  (Very experienced users may want to skip the Accept button and select Continue without waiting to see the tips and recommendations.)')
WebTip.create!( :identifier => 'CSI-3',          :display_rules => 'always',   :group_id => @startup.id ,  :question_id => nil,     :text => 'If, however, you change your mind about one or more of your previous answers, you can select any of the answers and make changes, or you can select the Cancel Changes button to go back to the default answers.')
WebTip.create!( :identifier => 'CSA-BirthDate-2',          :display_rules => 'always',   :group_id => @startup.id ,  :question_id => nil,     :text => 'Choose a Situation Date when you will be at least 15 years old.  WW-Web does not calculate results for those who have not reached age 15.')
WebTip.create!( :identifier => 'CSA-BirthDate-3',          :display_rules => 'always',   :group_id => @startup.id ,  :question_id => nil,     :text => 'The current version of WW-Web does not calculate results for those who are 66 years old or older.')
WebTip.create!( :identifier => 'CSA-SitDate-1',          :display_rules => 'always',   :group_id => @startup.id ,  :question_id => nil,     :text => 'Since your "Situation Date" is one or more months in the future, you should be aware that some benefit rates may change by then.  WW-Web uses current rates to calculate results.  The actual results may therefore be off by a few dollars.')
WebTip.create!( :identifier => 'CSA-State-1',          :display_rules => 'always',   :group_id => @startup.id ,  :question_id => nil,     :text => 'This version of WW-Web calculates results only for residents of the Commonwealth of Virginia.  If you would like WW-Web to work for your state, let your state disability agencies know.  They can visit www.workworld.org for information and contact us.')
WebTip.create!( :identifier => 'CSA-Disability-1',     :display_rules => 'always',   :group_id => @startup.id ,  :question_id => nil,     :text => 'This version of WW-Web gives correct results only for those who are blind or who have another type of disability according to the Social Security Administration\'s rules.')
#Note this tip does not show, need to identify the correct sub group
WebTip.create!( :identifier => 'CSA-Disability2',      :display_rules => 'always',   :group_id => @EXPENSES.id ,  :question_id => nil,     :text => 'This is a test to see if web tips show up in numeric results ')
WebTip.create!( :identifier => 'CSA-Disability2',      :display_rules => 'always',   :group_id => @EXPENSES.id ,  :question_id => nil,     :text => 'This is a test to see if web tips show up in numeric results ')


#well we have expenses in inputs nad outputs
#not lower caseWebTip.create!( :identifier => 'CSA-Disability2',      :display_rules => 'always',   :group_id => @Expenses.id ,  :question_id => nil,     :text => 'This is a test to see if web tips show up in numeric results ')

WebTip.create!( :identifier => '7',          :display_rules => 'always',   :group_id => @startup.id ,  :question_id => nil,     :text => '')
WebTip.create!( :identifier => '8',          :display_rules => 'always',   :group_id => @startup.id ,  :question_id => nil,     :text => '')

WebTip.create!( :identifier => 'CSA-BirthDate-1', :display_rules => 'always',   :group_id => nil,           :question_id => @BirthDate.id,  :text => 'The next time you start a case in WW-Web, the birth date in your last previously saved case will be the default birth date.')
#Total Gross Income


#note we need a better date start than this



####   Start of Web Calcs
##   These need a LOT of work because shortcuts were taken, hardwiring in question answers instead of laborious nil checking

#This is a test to see if we can convert a question to a number and then reference it again later
@NSsdiEarnAmt  = WebCalc.new(:name => 'nSsdiEarnAmt')
@NSsdiEarnAmt.operation = "
SsdiEarnAmt = manager.get_answer_by_question_name('SsdiEarnAmt')
if SsdiEarnAmt != nil then
  return Float(SsdiEarnAmt)
else
  return 0
end
"
@NSsdiEarnAmt.save!


## Well i can't remember how to reference previously done calcs so i'll hardwire them in to make progress and 
#will need to come back later and fix
@R_SsdiSgaExceeded  = WebCalc.new(:name => 'R_SsdiSgaExceeded')
##=IF((E20-E21-E22-E23)>E24;TRUE();FALSE())
##20 SsdiEarnAmt
##21 SgaIrweAmt
##22 SubsidyEmpSupAmt
##23 SubsidyWkDutiesReducAmt
##24 R_SgaAmt
#SsdiEarnAmt = (WebCalc.find_by_name(manager.'nSsdiEarnAmt'))
@R_SsdiSgaExceeded.operation = "
SsdiEarnAmt = 200  #This is bad, really bad and it is not going to be the only time.  Check all assignment statements from here down.
SgaIrweAmt= 0
SubsidyEmpSupAmt = 0
SubsidyWkDutiesReducAmt = 0
R_SgaAmt = 1000
workVar = (SsdiEarnAmt - SgaIrweAmt - SubsidyEmpSupAmt - SubsidyWkDutiesReducAmt)
if (workVar > R_SgaAmt) then
  return true
else
  return 0
end
"
@R_SsdiSgaExceeded.save!
## bah the -return  0- above should say return false but it does not comile and i can not figure out why

#320	Calculate if SSDI Cash Payment Stops	
#330	R_SsdiBenefitStops = IF R_SsdiSgaExceeded = TRUE AND TwpComplete = Y, THEN TRUE, ELSE FALSE	R_SsdiBenefitStops
#=IF(AND(E32=TRUE();E31="YES");TRUE();FALSE())
#e32 R_SsdiSgaExceeded
#e31 TwpComplete
#R_SsdiBenefitStops
@R_SsdiBenefitStops  = WebCalc.new(:name => 'R_SsdiBenefitStops')
@R_SsdiBenefitStops.operation = "
R_SsdiSgaExceeded = true
TwpComplete = manager.get_answer_by_question_name('TwpComplete')

if (R_SsdiSgaExceeded == true) && (TwpComplete == 'No') then 
  true
else
  false
end
"
@R_SsdiBenefitStops.save!

#25	350	R_SsdiEseCeases 
#= IF R_SsdiSgaExceeded = TRUE AND TwpComplete = Y AND BlindSkillsBefore55 <> Y AND BlindSkillsBeforeOnset <> Y, THEN TRUE, ELSE FALSE	
#=IF(AND(E32=TRUE();E31="YES";E30<>"YES";E29<>"YES");TRUE();FALSE())
#32 R_SsdiSgaExceeded
#31 TwpComplete
#30 BlindSkillsBeforeOnset
#29 BlindSkillsBefore55

@R_SsdiEseCeases  = WebCalc.new(:name => 'R_SsdiEseCeases')
@R_SsdiEseCeases.operation = "
R_SsdiSgaExceeded = false
TwpComplete = manager.get_answer_by_question_name('TwpComplete')
BlindSkillsBeforeOnset = 'No'
BlindSkillsBefore55 = 'No'

if (R_SsdiSgaExceeded == false && TwpComplete == 'Yes' && BlindSkillsBeforeOnset != 'Yes' && BlindSkillsBefore55 != 'Yes') then
    true
  else
    false
end  
"
@R_SsdiEseCeases.save!

#25	470	R_SsdiPayNoAdjustAmt = IF R_SsdiBenefitStops = TRUE, THEN 0.00, ELSE MAX of (SsdiAmtSelfFull OR SsdiAmtOtherFull)	
#=IF(E46=TRUE();0;MAX(E39;E40))
#e46 R_SsdiBenefitStops
#e39 SsdiAmtSelfFull
#e40 SsdiAmtOtherFull

@R_SsdiPayNoAdjustAmt  = WebCalc.new(:name => 'R_SsdiPayNoAdjustAmt')
@R_SsdiPayNoAdjustAmt.operation = "
R_SsdiBenefitStops = false
SsdiAmtSelfFull = 777
SsdiAmtOtherFull = 0
if R_SsdiBenefitStops == true then
  return 0
else
  return (SsdiAmtSelfFull + SsdiAmtOtherFull)
end
"
@R_SsdiPayNoAdjustAmt.save!

#25	480	R_SsdiPayCareBAdjustAmt = 
#IF R_SsdiBenefitStops = TRUE, THEN 0.00, ELSE IF CareBDeduct = Y, THEN R_SsdiPayNoAdjustAmt - RateCareBPremium, ELSE R_SsdiPayNoAdjustAmt	

@R_SsdiPayCareBAdjustAmt  = WebCalc.new(:name => 'R_SsdiPayCareBAdjustAmt')
#=IF(E46=TRUE();0;IF(E41="YES";E48-E42;E48))
#e46 R_SsdiBenefitStops
#41 CareBDeduct
#48 R_SsdiPayNoAdjustAmt
#42 RateCareBPremium

@R_SsdiPayCareBAdjustAmt.operation = "
R_SsdiBenefitStops = false
CareBDeduct = manager.get_answer_by_question_name('CareBDeduct')
R_SsdiPayNoAdjustAmt = 1111
RateCareBPremium = FederalRate.first.care_b_premium
if (R_SsdiBenefitStops == true)  then
  return 0
elsif (CareBDeduct == 'Yes') then
  return (R_SsdiPayNoAdjustAmt - RateCareBPremium)
else
  return R_SsdiPayNoAdjustAmt
end
"
@R_SsdiPayCareBAdjustAmt.save!


#25	490	R_SsdiPayWcOrPdbAdjustAmt = IF R_SsdiBenefitStops = TRUE, 0, ELSE R_SsdiPayCareBAdjustAmt - SsdiWcOrPdbDecreaseAmt	
# =IF(E46=TRUE();0;E49-E43)
#46 R_SsdiBenefitStops
#49 R_SsdiPayCareBAdjustAmt
#43 SsdiWcOrPdbDecreaseAmt SsdiWcOrPdbDecreaseAmt = manager.get_answer_by_question_name('SsdiWcOrPdbDecreaseAmt')  can't use need to convert to float if not nill Hoping to do this in one spot once
@R_SsdiPayWcOrPdbAdjustAmt  = WebCalc.new(:name => 'R_SsdiPayWcOrPdbAdjustAmt')
@R_SsdiPayWcOrPdbAdjustAmt.operation = "
R_SsdiBenefitStops = false
R_SsdiPayCareBAdjustAmt = 777
SsdiWcOrPdbDecreaseAmt = 0
if R_SsdiBenefitStops == true then
  return 0
else
  return (R_SsdiPayCareBAdjustAmt - SsdiWcOrPdbDecreaseAmt)
end
"
@R_SsdiPayWcOrPdbAdjustAmt.save!

#25 500	R_SsdiPayOverUnderAdjustAmt = IF R_SsdiBenefitStops = TRUE, THEN 0.00, ELSE R_SsdiPayCareBAdjustAmt + SsdiUnderPayIncreaseAmt - SsdiOverPayDecreaseAmt	
#=IF(E46=TRUE();0;E49+E44-E45)
#46 R_SsdiBenefitStops
#49 R_SsdiPayCareBAdjustAmt
#44 SsdiUnderPayIncreaseAmt
#45 SsdiOverPayDecreaseAmt
@R_SsdiPayOverUnderAdjustAmt  = WebCalc.new(:name => 'R_SsdiPayOverUnderAdjustAmt')
@R_SsdiPayOverUnderAdjustAmt.operation = "
R_SsdiBenefitStops = false
R_SsdiPayCareBAdjustAmt = 777
SsdiUnderPayIncreaseAmt = 0
SsdiOverPayDecreaseAmt = 0
if R_SsdiBenefitStops == true then
  return 0
else
  return (R_SsdiPayCareBAdjustAmt + SsdiUnderPayIncreaseAmt - SsdiOverPayDecreaseAmt)
end
"
@R_SsdiPayOverUnderAdjustAmt.save!

# 25 510	R_SsdiPayAllAdjustAmt = IF R_SsdiBenefitStops = TRUE, THEN 0.00, ELSE R_SsdiPayCareBAdjustAmt - SsdiWcOrPdbDecreaseAmt + SsdiUnderPayIncreaseAmt - SsdiOverPayDecreaseAmt	
#=IF(E46=TRUE();0;E49-E43+E44-E45)
#46 R_SsdiBenefitStops
#49 R_SsdiPayCareBAdjustAmt
#43 SsdiWcOrPdbDecreaseAmt = manager.get_answer_by_question_name('SsdiWcOrPdbDecreaseAmt')  can't use need to convert to float if not nill Hoping to do this in one spot once
#44 SsdiUnderPayIncreaseAmt
#45 SsdiOverPayDecreaseAmt
@R_SsdiPayAllAdjustAmt  = WebCalc.new(:name => 'R_SsdiPayAllAdjustAmt')
@R_SsdiPayAllAdjustAmt.operation = "
R_SsdiBenefitStops = false
R_SsdiPayCareBAdjustAmt = 777
SsdiWcOrPdbDecreaseAmt = 0
SsdiUnderPayIncreaseAmt = 0
SsdiOverPayDecreaseAmt = 0
if R_SsdiBenefitStops == true then
  return 0
else
  return (R_SsdiPayCareBAdjustAmt - SsdiWcOrPdbDecreaseAmt + SsdiUnderPayIncreaseAmt - SsdiOverPayDecreaseAmt)
end
"
@R_SsdiPayAllAdjustAmt.save!

#25 515	R_SsdiPayAllAdjustAmt = IF R_SsdiBenefitStops = TRUE, THEN 0.00, ELSE R_SsdiPayNoAdjustAmt - SsdiWcOrPdbDecreaseAmt + SsdiUnderPayIncreaseAmt - SsdiOverPayDecreaseAmt	
#=IF(E46=TRUE();0;E48-E43+E44-E45)
#46 R_SsdiBenefitStops
#48 R_SsdiPayNoAdjustAmt
#43 SsdiWcOrPdbDecreaseAmt = manager.get_answer_by_question_name('SsdiWcOrPdbDecreaseAmt')  can't use need to convert to float if not nill Hoping to do this in one spot once
#44 SsdiUnderPayIncreaseAmt
#45 SsdiOverPayDecreaseAmt
@R_SsdiPayAllAdjustButCareBAmt  = WebCalc.new(:name => 'R_SsdiPayAllAdjustButCareBAmt')
@R_SsdiPayAllAdjustButCareBAmt.operation = "
R_SsdiBenefitStops = false
R_SsdiPayNoAdjustAmt = 888
SsdiWcOrPdbDecreaseAmt = 0
SsdiUnderPayIncreaseAmt = 0
SsdiOverPayDecreaseAmt = 0
if R_SsdiBenefitStops == true then
  return 0
else
  return (R_SsdiPayNoAdjustAmt - SsdiWcOrPdbDecreaseAmt + SsdiUnderPayIncreaseAmt - SsdiOverPayDecreaseAmt)
end
"
@R_SsdiPayAllAdjustButCareBAmt.save!

# 25 610	 R_ActualSsdiPayNotEqualNoAdjust = IF Current/What-If Button = Current AND SsdiActualAmt <> R_SsdiPayNoAdjustAmt THEN TRUE, ELSE FALSE	
#R_ActualSsdiPayNotEqualNoAdjust
#=IF(AND(E56="Current";E57<>E58);TRUE();FALSE())
#56 Current/What-If Button
#57 SsdiActualAmt  manager.get_answer_by_question_name('SsdiActualAmt') 
#58 R_SsdiPayNoAdjustAmt
#Bob is ignoring whatIf/current distinctions for now
@R_ActualSsdiPayNotEqualNoAdjust  = WebCalc.new(:name => 'R_ActualSsdiPayNotEqualNoAdjust')
@R_ActualSsdiPayNotEqualNoAdjust.operation = "
SsdiActualAmt = 1111
R_SsdiPayNoAdjustAmt = 1111
if (SsdiActualAmt != R_SsdiPayNoAdjustAmt) then
  true
else
  false
end
"
@R_ActualSsdiPayNotEqualNoAdjust.save!

#25	620	R_ActualSsdiPayNotEqualCareBAdjust = IF Current/What-If Button = Current AND SsdiActualAmt <> R_SsdiPayCareBAdjustAmt, THEN TRUE, ELSE FALSE	
#R_ActualSsdiPayNotEqualCareBAdjust
#=IF(AND(E56="Current";E57<>E59);TRUE();FALSE())
#56 Current/What-If Button  Bob again ignores current/WhatIf implications
#57 SsdiActualAmt  manager.get_answer_by_question_name('SsdiActualAmt') 
#59 R_SsdiPayCareBAdjustAmt
@R_ActualSsdiPayNotEqualCareBAdjust  = WebCalc.new(:name => 'R_ActualSsdiPayNotEqualCareBAdjust')
@R_ActualSsdiPayNotEqualCareBAdjust.operation = "
SsdiActualAmt = 1111
R_SsdiPayCareBAdjustAmt = 1111
if (SsdiActualAmt != R_SsdiPayCareBAdjustAmt) then
  true
else
  false
end
"
@R_ActualSsdiPayNotEqualCareBAdjust.save!


#25	630	 R_ActualSsdiPayNotEqualWcOrPbdAdjust = IF Current/What-If Button = Current AND SsdiActualAmt <> R_SsdiPayWcOrPdbAdjustAmt, THEN TRUE, ELSE FALSE	
#R_ActualSsdiPayNotEqualWcOrPbdAdjust
#=IF(AND(E56="Current";E57<>E60);TRUE();FALSE())
#56 Current/What-If Button  Bob again ignores current/WhatIf implications
#57 SsdiActualAmt  manager.get_answer_by_question_name('SsdiActualAmt')
#60 R_SsdiPayWcOrPdbAdjustAmt
@R_ActualSsdiPayNotEqualWcOrPbdAdjust  = WebCalc.new(:name => 'R_ActualSsdiPayNotEqualWcOrPbdAdjust')
@R_ActualSsdiPayNotEqualWcOrPbdAdjust.operation = "
SsdiActualAmt = 1111
R_SsdiPayWcOrPdbAdjustAmt = 1111
if (SsdiActualAmt != R_SsdiPayWcOrPdbAdjustAmt) then
   true
else
  false
end
"
@R_ActualSsdiPayNotEqualWcOrPbdAdjust.save!

#25	640	R_ActualSsdiPayNotEqualAllAdjust = IF Current/What-If Button = Current AND SsdiActualAmt <> R_SsdiPayAllAdjustAmt, THEN TRUE, ELSE FALSE	
#R_ActualSsdiPayNotEqualAllAdjust
#=IF(AND(E56="Current";E57<>E62);TRUE();FALSE())
#56 Current/What-If Button  Bob again ignores current/WhatIf implications
#57 SsdiActualAmt  manager.get_answer_by_question_name('SsdiActualAmt')
#62 R_SsdiPayAllAdjustAmt
@R_ActualSsdiPayNotEqualAllAdjust  = WebCalc.new(:name => 'R_ActualSsdiPayNotEqualAllAdjust')
@R_ActualSsdiPayNotEqualAllAdjust.operation = "
SsdiActualAmt = 1111
R_SsdiPayAllAdjustAmt = 1111
if (SsdiActualAmt != R_SsdiPayAllAdjustAmt) then
  true
else
  false
end
"
@R_ActualSsdiPayNotEqualAllAdjust.save!


#25	730	R_SpouseSgaAmt = IF SpouseDisability = Y AND SpouseBlind = Y, THEN RateSgaBlindAmt, ELSE IF R_SpouseSgaAmt = IF SpouseDisability = Y AND SpouseBlind = N, THEN RateSgaDisabledAmt, ELSE 0	
#R_SpouseSgaAmt
#=IF(AND(E73="YES";E71="YES");E72;IF(AND(E73="YES";E71="NO");E74;0))
#e73 SpouseDisability
#e71 SpouseBlind
#e72 RateSgaBlindAmt
#e74 RateSgaDisabledAmt
#Note Bob is not following the workbook due to a hicup, need to review afrer DR makes a corrections
# NOte 2 need to adjust reading of rate table to reflect correct sit date rate
@R_SpouseSgaAmt  = WebCalc.new(:name => 'R_SpouseSgaAmt')
@R_SpouseSgaAmt.operation = "
SpouseBlind = manager.get_answer_by_question_name('SpouseBlind')
SpouseDisability = manager.get_answer_by_question_name('SpouseDisability')
RateSgaBlindAmt = FederalRate.first.sga_blind_amount
RateSgaDisabledAmt = FederalRate.first.sga_disabled_amount
if SpouseBlind == 'Yes' then
  return RateSgaBlindAmt
elsif 
  SpouseDisability == 'Yes' then
  return RateSgaDisabledAmt
else
  return 0
end
"
@R_SpouseSgaAmt.save!


#820	R_SpouseSsdiSgaExceeded = IF (SpouseSsdiEarnAmt - SpouseSgaIrweAmt - SpouseSubsidyEmpSupAmt - SpouseSubsidyWkDutiesReducAmt) > R_SpouseSgaAmt, THEN TRUE, ELSE FALSE	
#R_SpouseSsdiSgaExceeded
#=IF((E79-E80-E81-E82)>E83;TRUE();FALSE())
#E79 SpouseSsdiEarnAmt  NOte again these numerics are being hardwired until we can figure out how to convert to currency once
#e80 SpouseSgaIrweAmt
#e81 SpouseSubsidyEmpSupAmt
#e82 SpouseSubsidyWkDutiesReducAmt
#e83 R_SpouseSgaAmt
@R_SpouseSsdiSgaExceeded  = WebCalc.new(:name => 'R_SpouseSsdiSgaExceeded')
@R_SpouseSsdiSgaExceeded.operation = "
SpouseSsdiEarnAmt = 2222
SpouseSgaIrweAmt = 0
SpouseSubsidyEmpSupAmt = 0
SpouseSubsidyWkDutiesReducAmt = 0
R_SpouseSgaAmt = 1000
if ((SpouseSsdiEarnAmt - SpouseSgaIrweAmt - SpouseSubsidyEmpSupAmt - SpouseSubsidyWkDutiesReducAmt) > R_SpouseSgaAmt) then
  true
else
  false
end
"
@R_SpouseSsdiSgaExceeded.save!

#25	900	R_SpouseSsdiBenefitStops = IF R_SpouseSsdiSgaExceeded = TRUE AND SpouseTwpComplete = Y, THEN TRUE, ELSE FALSE	
#R_SpouseSsdiBenefitStops
#=IF(AND(E91=TRUE();E90="YES");TRUE();FALSE())
#91 R_SpouseSsdiSgaExceeded  Note ref hardwire among many
#90 SpouseTwpComplete
@R_SpouseSsdiBenefitStops  = WebCalc.new(:name => 'R_SpouseSsdiBenefitStops')
@R_SpouseSsdiBenefitStops.operation = "
R_SpouseSsdiSgaExceeded = true
SpouseTwpComplete = manager.get_answer_by_question_name('SpouseTwpComplete')
if R_SpouseSsdiSgaExceeded == true && SpouseTwpComplete == 'Yes' then
  true
else
  false
end
"
@R_SpouseSsdiBenefitStops.save!

#25	920	R_SpouseSsdiEseCeases = IF R_SpouseSsdiSgaExceeded = TRUE AND SpouseTwpComplete = Y AND SpouseBlindSkillsBefore55 <> Y AND SpouseBlindSkillsBeforeOnset <> Y, THEN TRUE, ELSE FALSE	
#R_SpouseSsdiEseCeases
#=IF(AND(E91=TRUE();E90="YES";E89<>"YES";E88<>"YES");TRUE();FALSE())
#91 R_SpouseSsdiSgaExceeded  Note ref hardwire among many
#90 SpouseTwpComplete
#89 SpouseBlindSkillsBeforeOnset
#88 SpouseBlindSkillsBefore55
#=IF(AND(E91=TRUE();E90="YES";E89<>"YES";E88<>"YES");TRUE();FALSE())   
@R_SpouseSsdiEseCeases  = WebCalc.new(:name => 'R_SpouseSsdiEseCeases')
@R_SpouseSsdiEseCeases.operation = "
R_SpouseSsdiSgaExceeded = true
SpouseTwpComplete = manager.get_answer_by_question_name('SpouseTwpComplete')
SpouseBlindSkillsBeforeOnset = manager.get_answer_by_question_name('SpouseBlindSkillsBeforeOnset')
SpouseBlindSkillsBefore55 = manager.get_answer_by_question_name('SpouseBlindSkillsBefore55')
if R_SpouseSsdiSgaExceeded == true && SpouseTwpComplete == 'Yes' && SpouseBlindSkillsBefore55 != 'Yes' && SpouseBlindSkillsBeforeOnset != 'Yes' then
  true
else
  false
end
"
@R_SpouseSsdiEseCeases.save!

#25	1040	R_SpouseSsdiPayNoAdjustAmt = IF R_SpouseSsdiBenefitStops = TRUE, THEN 0.00, ELSE MAX of (SpouseDiAmtSelfFull OR SpouseDiAmtOtherFull)	
#R_SpouseSsdiPayNoAdjustAmt
#=IF(E105=TRUE();0;MAX(E98;E99))
#105 R_SpouseSsdiBenefitStops
#98 SpouseDiAmtSelfFull
#99 SpouseDiAmtOtherFull  Note bob adds these together thinking they are mutually exclusive but could be wrong  The max function might be better but i'm not sure how to do this within the seed file
@R_SpouseSsdiPayNoAdjustAmt  = WebCalc.new(:name => 'R_SpouseSsdiPayNoAdjustAmt')
@R_SpouseSsdiPayNoAdjustAmt.operation = "
R_SpouseSsdiBenefitStops = false
SpouseDiAmtSelfFull = 1112
SpouseDiAmtOtherFull = 0
if (R_SpouseSsdiBenefitStops == true) then 
  return 0
else 
  return (SpouseDiAmtSelfFull + SpouseDiAmtOtherFull)	
end
"
@R_SpouseSsdiPayNoAdjustAmt.save!

#25	1050	R_SpouseSsdiPayCareBAdjustAmt = IF R_SpouseSsdiBenefitStops = TRUE, ELSE IF SpouseCareBDeduct = Y, THEN R_SpouseSsdiPayNoAdjustAmt - RateCareBPremium, ELSE R_SpouseSsdiPayNoAdjustAmt	
#R_SpouseSsdiPayCareBAdjustAmt
#=IF(E105=TRUE();0;IF(E100="YES";E107-E101;E107))
#105 R_SpouseSsdiBenefitStops
#100 SpouseCareBDeduct
#107 R_SpouseSsdiPayNoAdjustAmt
#101 RateCareBPremium  NOte will bee are changing this from using the rate to using how they answer a new question 
@R_SpouseSsdiPayCareBAdjustAmt  = WebCalc.new(:name => 'R_SpouseSsdiPayCareBAdjustAmt')
@R_SpouseSsdiPayCareBAdjustAmt.operation = "
R_SpouseSsdiBenefitStops = 0
SpouseCareBDeduct = #105 R_SpouseSsdiBenefitStops
#108 R_SpouseSsdiPayCareBAdjustAmt
#103 SpouseSsdiUnderPayIncreaseAmt
#104 SpouseSsdiOverPayDecreaseAmt
R_SpouseSsdiPayNoAdjustAmt = 1234
RateCareBPremium = FederalRate.first.care_b_premium
if R_SpouseSsdiBenefitStops == true then
  return 0
elsif SpouseCareBDeduct == 'Yes' then
    return R_SpouseSsdiPayNoAdjustAmt - RateCareBPremium
else 
    return R_SpouseSsdiPayNoAdjustAmt	
end
"
@R_SpouseSsdiPayCareBAdjustAmt.save!

#25	1060	R_SpouseSsdiPayWcOrPdbAdjustAmt = IF R_SpouseSsdiBenefitStops = TRUE, THEN 0.00, ELSE R_SpouseSsdiPayCareBAdjustAmt - SpouseSsdiWcOrPdbDecreaseAmt	
#R_SpouseSsdiPayWcOrPdbAdjustAmt
#=IF(E105=TRUE();0;E108-E102)
#105 R_SpouseSsdiBenefitStops
#108 R_SpouseSsdiPayCareBAdjustAmt
#102 SpouseSsdiWcOrPdbDecreaseAmt
@R_SpouseSsdiPayWcOrPdbAdjustAmt  = WebCalc.new(:name => 'R_SpouseSsdiPayWcOrPdbAdjustAmt')
@R_SpouseSsdiPayWcOrPdbAdjustAmt.operation = "
R_SpouseSsdiBenefitStops = false
R_SpouseSsdiPayCareBAdjustAmt = 1111
SpouseSsdiWcOrPdbDecreaseAmt = 0
if R_SpouseSsdiBenefitStops == true then
  return 0
else 
  return (R_SpouseSsdiPayCareBAdjustAmt - SpouseSsdiWcOrPdbDecreaseAmt)
end	
"
@R_SpouseSsdiPayWcOrPdbAdjustAmt.save!

#1070	R_SpouseSsdiPayOverUnderAdjustAmt = IF R_SpouseSsdiBenefitStops = TRUE, THEN 0.00, ELSE R_SpouseSsdiPayCareBAdjustAmt + SpouseSsdiUnderPayIncreaseAmt - SpouseSsdiOverPayDecreaseAmt	
#R_SpouseSsdiPayOverUnderAdjustAmt
#=IF(E105=TRUE();0;E108+E103-E104)
#105 R_SpouseSsdiBenefitStops
#108 R_SpouseSsdiPayCareBAdjustAmt
#103 SpouseSsdiUnderPayIncreaseAmt  More hardwire bad
#104 SpouseSsdiOverPayDecreaseAmt
@R_SpouseSsdiPayOverUnderAdjustAmt  = WebCalc.new(:name => 'R_SpouseSsdiPayOverUnderAdjustAmt')
@R_SpouseSsdiPayOverUnderAdjustAmt.operation = "
R_SpouseSsdiBenefitStops = false
R_SpouseSsdiPayCareBAdjustAmt = 1111
SpouseSsdiUnderPayIncreaseAmt = 0
SpouseSsdiOverPayDecreaseAmt = 0
if R_SpouseSsdiBenefitStops == true then
  return 0
else 
  return (R_SpouseSsdiPayCareBAdjustAmt + SpouseSsdiUnderPayIncreaseAmt - SpouseSsdiOverPayDecreaseAmt)
end
"
@R_SpouseSsdiPayOverUnderAdjustAmt.save!

#1080	R_SpouseSsdiPayAllAdjustAmt = IF R_SpouseSsdiBenefitStops = TRUE, THEN 0.00, ELSE R_SpouseSsdiPayCareBAdjustAmt - SpouseSsdiWcOrPdbDecreaseAmt + SpouseSsdiUnderPayIncreaseAmt - SpouseSsdiOverPayDecreaseAmt	
#R_SpouseSsdiPayAllAdjustAmt
#=IF(E105=TRUE();0;E108-E102+E103-E104)
#105 R_SpouseSsdiBenefitStops
#108 R_SpouseSsdiPayCareBAdjustAmt
#102 SpouseSsdiWcOrPdbDecreaseAmt
#103 SpouseSsdiUnderPayIncreaseAmt  More hardwire bad
#104 SpouseSsdiOverPayDecreaseAmt
@R_SpouseSsdiPayAllAdjustAmt  = WebCalc.new(:name => 'R_SpouseSsdiPayAllAdjustAmt')
@R_SpouseSsdiPayAllAdjustAmt.operation = "
R_SpouseSsdiBenefitStops = false
R_SpouseSsdiPayCareBAdjustAmt = 1111
SpouseSsdiWcOrPdbDecreaseAmt = 0
SpouseSsdiUnderPayIncreaseAmt = 0
SpouseSsdiOverPayDecreaseAmt = 0
if R_SpouseSsdiBenefitStops == true then
    return 0 
else 
  return (R_SpouseSsdiPayCareBAdjustAmt - SpouseSsdiWcOrPdbDecreaseAmt + SpouseSsdiUnderPayIncreaseAmt - SpouseSsdiOverPayDecreaseAmt)
end
"
@R_SpouseSsdiPayAllAdjustAmt.save!

#26	1085	R_SpouseSsdiPayAllAdjustAmt = IF R_SpouseSsdiBenefitStops = TRUE, THEN 0.00, ELSE R_SpouseSsdiPayNoAdjustAmt - SpouseSsdiWcOrPdbDecreaseAmt + SpouseSsdiUnderPayIncreaseAmt - SpouseSsdiOverPayDecreaseAmt
#R_SpouseSsdiPayAllAdjustButCareBAmt
#=IF(E105=TRUE();0;E107-E102+E103-E104)
#105 R_SpouseSsdiBenefitStops
#107 R_SpouseSsdiPayNoAdjustAmt
#102 SpouseSsdiWcOrPdbDecreaseAmt
#103 SpouseSsdiUnderPayIncreaseAmt  More hardwire bad
#104 SpouseSsdiOverPayDecreaseAmt
@R_SpouseSsdiPayAllAdjustButCareBAmt  = WebCalc.new(:name => 'R_SpouseSsdiPayAllAdjustButCareBAmt')
@R_SpouseSsdiPayAllAdjustButCareBAmt.operation = "
R_SpouseSsdiBenefitStops = false
R_SpouseSsdiPayNoAdjustAmt = 1222
SpouseSsdiWcOrPdbDecreaseAmt = 0
SpouseSsdiUnderPayIncreaseAmt = 0
SpouseSsdiOverPayDecreaseAmt = 0
if R_SpouseSsdiBenefitStops == true then
    return 0 
else
  return (R_SpouseSsdiPayNoAdjustAmt - SpouseSsdiWcOrPdbDecreaseAmt + SpouseSsdiUnderPayIncreaseAmt - SpouseSsdiOverPayDecreaseAmt)
end  
  "
@R_SpouseSsdiPayAllAdjustButCareBAmt.save!

#25	1180	R_SpouseActualSsdiPayNotEqualNoAdjust = IF Current/What-If Button = Current AND SpouseSsdiActualAmt <> R_SpouseSsdiPayNoAdjustAmt THEN TRUE, ELSE FALSE
#R_SpouseActualSsdiPayNotEqualNoAdjust
#=IF(AND(E114="Current";E115<>E116);TRUE();FALSE())
#114 Current/What-If Button
#115 SpouseSsdiActualAmt
#116 R_SpouseSsdiPayNoAdjustAmt
@R_SpouseActualSsdiPayNotEqualNoAdjust  = WebCalc.new(:name => 'R_SpouseActualSsdiPayNotEqualNoAdjust')
@R_SpouseActualSsdiPayNotEqualNoAdjust.operation = "
SpouseSsdiActualAmt = 1234
R_SpouseSsdiPayNoAdjustAmt = 1234
if SpouseSsdiActualAmt != R_SpouseSsdiPayNoAdjustAmt then
   true
else
  false
end
"
@R_SpouseActualSsdiPayNotEqualNoAdjust.save!
#1190	R_SpouseActualSsdiPayNotEqualCareBAdjust = IF Current/What-If Button = Current AND SpouseSsdiActualAmt <> R_SpouseSsdiPayCareBAdjustAmt, THEN TRUE, ELSE FALSE	
#R_SpouseActualSsdiPayNotEqualCareBAdjust
#=IF(AND(E114="Current";E115<>E117);TRUE();FALSE())
#114 Current/What-If Button
#115 SpouseSsdiActualAmt
#117 R_SpouseSsdiPayCareBAdjustAmt

@R_SpouseActualSsdiPayNotEqualCareBAdjust  = WebCalc.new(:name => 'R_SpouseActualSsdiPayNotEqualCareBAdjust')
@R_SpouseActualSsdiPayNotEqualCareBAdjust.operation = "
SpouseSsdiActualAmt = 1234
R_SpouseSsdiPayCareBAdjustAmt = 1234
if SpouseSsdiActualAmt != R_SpouseSsdiPayCareBAdjustAmt then 
  true
else
  false
end
"
@R_SpouseActualSsdiPayNotEqualCareBAdjust.save!

#25	1200	R_SpouseActualSsdiPayNotEqualWcOrPbdAdjust = IF Current/What-If Button = Current AND SpouseSsdiActualAmt <> R_SpouseSsdiPayWcOrPdbAdjustAmt, THEN TRUE, ELSE FALSE	
#R_SpouseActualSsdiPayNotEqualWcOrPbdAdjust
#=IF(AND(E114="Current";E115<>E118);TRUE();FALSE())
#114 Current/What-If Button
#115 SpouseSsdiActualAmt
#118 R_SpouseSsdiPayWcOrPdbAdjustAmt
@R_SpouseActualSsdiPayNotEqualWcOrPbdAdjust  = WebCalc.new(:name => 'R_SpouseActualSsdiPayNotEqualWcOrPbdAdjust')
@R_SpouseActualSsdiPayNotEqualWcOrPbdAdjust.operation = "
SpouseSsdiActualAmt = 1234
R_SpouseSsdiPayWcOrPdbAdjustAmt = 1234
if SpouseSsdiActualAmt != R_SpouseSsdiPayWcOrPdbAdjustAmt then 
  true
else
  false
end
"
@R_SpouseActualSsdiPayNotEqualWcOrPbdAdjust.save!


#1210	R_SpouseActualSsdiPayNotEqualAllAdjust = IF Current/What-If Button = Current AND SpouseSsdiActualAmt <> R_SpouseSsdiPayAllAdjustAmt, THEN TRUE, ELSE FALSE	
#R_SpouseActualSsdiPayNotEqualAllAdjust
#=IF(AND(E114="Current";E115<>E120);TRUE();FALSE())
#114 Current/What-If Button
#115 SpouseSsdiActualAmt
#120 R_SpouseSsdiPayAllAdjustAmt
@R_SpouseActualSsdiPayNotEqualAllAdjust  = WebCalc.new(:name => 'R_SpouseActualSsdiPayNotEqualAllAdjust')
@R_SpouseActualSsdiPayNotEqualAllAdjust.operation = "
SpouseSsdiActualAmt = 1234
R_SpouseSsdiPayAllAdjustAmt = 1234
if SpouseSsdiActualAmt != R_SpouseSsdiPayAllAdjustAmt then 
  true
else
  false
end
"
@R_SpouseActualSsdiPayNotEqualAllAdjust.save!

#25	1330	R_SsdiForSsiCalcAmt = IF SsiGet = Y, THEN (R_SsdiPayNoAdjustAmt - SsdiWcOrPdbDecreaseAmt 
#     + (IF SsiWhileSsdiUnderPay = Y THEN SsdiUnderPayIncreaseAmt, ELSE 0)
#     - (IF SsiWhileSsdiOverPay = Y, THEN SsdiOverPayDecreaseAmt, ELSE 0)), ELSE 0	
#R_SsdiForSsiCalcAmt
#=IF(E129="YES";E130-E131+IF(E133="YES";E132;0)-IF(E135="YES";E134;0);0)
#129 SsiGet
#130 R_SsdiPayNoAdjustAmt
#131 SsdiWcOrPdbDecreaseAmt can't do this because of nil possibility manager.get_answer_by_question_name('SsdiWcOrPdbDecreaseAmt')
#133 SsiWhileSsdiUnderPay
#132 SsdiUnderPayIncreaseAmt
#135 SsiWhileSsdiOverPay
#134 SsdiOverPayDecreaseAmt

@R_SsdiForSsiCalcAmt  = WebCalc.new(:name => 'R_SsdiForSsiCalcAmt')
@R_SsdiForSsiCalcAmt.operation = "
SsiGet = manager.get_answer_by_question_name('SsiGet')
R_SsdiPayNoAdjustAmt = 1111
SsdiWcOrPdbDecreaseAmt = 0
SsiWhileSsdiUnderPay = manager.get_answer_by_question_name('SsiWhileSsdiUnderPay')
SsdiUnderPayIncreaseAmt = 0
SsiWhileSsdiOverPay = manager.get_answer_by_question_name('SsiWhileSsdiOverPay')
SsdiOverPayDecreaseAmt = 0
if (SsiGet == 'Yes') then 
  workVar = (R_SsdiPayNoAdjustAmt - SsdiWcOrPdbDecreaseAmt)
   if (SsiWhileSsdiUnderPay == 'Yes') then
     workVar = workVar + SsdiUnderPayIncreaseAmt
   end
   if (SsiWhileSsdiOverPay == 'Yes') then
     workVar = workVar - SsdiOverPayDecreaseAmt
   end

   return workVar

else
  return 0
end
"
@R_SsdiForSsiCalcAmt.save!

#25	1440	R_SpouseSsdiForSsiCalcAmt = IF SpouseSsiGet = Y, THEN (R_SpouseSsdiPayNoAdjustAmt - SpouseSsdiWcOrPdbDecreaseAmt + (IF SpouseSsiWhileSsdiUnderPay = Y THEN SpouseSsdiUnderPayIncreaseAmt, ELSE 0) - (IF SpouseSsiWhileSsdiOverPay = Y, THEN SpouseSsdiOverPayDecreaseAmt, ELSE 0)), ELSE 0	
#R_SpouseSsdiForSsiCalcAmt
#=IF(E140="YES";E141-E142+IF(E144="YES";E143;0)-IF(E146="YES";E145;0);0)
#140 SpouseSsiGet
#141 R_SpouseSsdiPayNoAdjustAmt
#142 SpouseSsdiWcOrPdbDecreaseAmt
#144 SpouseSsiWhileSsdiUnderPay
#143 SpouseSsdiUnderPayIncreaseAmt
#146 SpouseSsiWhileSsdiOverPay
#145 SpouseSsdiOverPayDecreaseAmt

@R_SpouseSsdiForSsiCalcAmt  = WebCalc.new(:name => 'R_SpouseSsdiForSsiCalcAmt')
@R_SpouseSsdiForSsiCalcAmt.operation = "
SpouseSsiGet = manager.get_answer_by_question_name('SpouseSsiGet')
R_SpouseSsdiPayNoAdjustAmt = 1111
SpouseSsdiWcOrPdbDecreaseAmt = 0
SpouseSsiWhileSsdiUnderPay = manager.get_answer_by_question_name('SpouseSsiWhileSsdiUnderPay')
SpouseSsdiUnderPayIncreaseAmt = 0
SpouseSsiWhileSsdiOverPay = manager.get_answer_by_question_name('SpouseSsiWhileSsdiOverPay')
SpouseSsdiOverPayDecreaseAmt = 0
if (SpouseSsiGet == 'Yes') then 
  workVar = (R_SpouseSsdiPayNoAdjustAmt - SpouseSsdiWcOrPdbDecreaseAmt)
   if (SpouseSsiWhileSsdiUnderPay == 'Yes') then
     workVar = workVar + SpouseSsdiUnderPayIncreaseAmt
   end
   if (SpouseSsiWhileSsdiOverPay == 'Yes') then
     workVar = workVar - SpouseSsdiOverPayDecreaseAmt
   end

   return workVar

else
  return 0
end

"
@R_SpouseSsdiForSsiCalcAmt.save!

#25	1580	R_SsiUnearnNoSpouseDeemAmt = IF SsiGet = Y THEN (R_SsdiForSsiCalcAmt + R_SpouseSsdiForSsiCalcAmt + InKindPMVAmt+ SsiParDeemAmt  + UnearnAmt  + SpouseUnEarnAmt), ELSE 0.00	
#R_SsiUnearnNoSpouseDeemAmt
#=IF(E160="YES";E156+E157+E151+E152+E153+E158+E159;0)  Note 153 deleted CoupleParSsiDeemAmt
#160 SsiGet
#156 R_SsdiForSsiCalcAmt
#157 R_SpouseSsdiForSsiCalcAmt
#151 InKindPMVAmt
#152 SsiParDeemAmt
#158 UnearnAmt
#159 SpouseUnEarnAmt
@R_SsiUnearnNoSpouseDeemAmt  = WebCalc.new(:name => 'R_SsiUnearnNoSpouseDeemAmt')
@R_SsiUnearnNoSpouseDeemAmt.operation = "
SsiGet = manager.get_answer_by_question_name('SsiGet')
R_SsdiForSsiCalcAmt =  1111
R_SpouseSsdiForSsiCalcAmt = 1234
InKindPMVAmt = 0
SsiParDeemAmt = 0
UnearnAmt = 0
SpouseUnEarnAmt = 0
if SsiGet == 'Yes' then
  return (R_SsdiForSsiCalcAmt + R_SpouseSsdiForSsiCalcAmt + InKindPMVAmt+ SsiParDeemAmt +  UnearnAmt  + SpouseUnEarnAmt)
else 
  return 0
end  
"
@R_SsiUnearnNoSpouseDeemAmt.save!

#25	1600	R_SsiUnearnSpouseDeemAmt = If SsiSpouseDeemUnearnAmt + SsiSpouseDeemEarnAmt > 0, THEN R_SsiUnearnNoSpouseDeemAmt + SsiSpouseDeemUnearnAmt, ELSE 0.00	
#R_SsiUnearnSpouseDeemAmt
#=IF(E154+E155>0;E162+E154;0)
#154 SsiSpouseDeemUnearnAmt
#155 SsiSpouseDeemEarnAmt
#162 R_SsiUnearnNoSpouseDeemAmt

@R_SsiUnearnSpouseDeemAmt  = WebCalc.new(:name => 'R_SsiUnearnSpouseDeemAmt')
@R_SsiUnearnSpouseDeemAmt.operation = "
SsiSpouseDeemUnearnAmt = 0
SsiSpouseDeemEarnAmt = 0
R_SsiUnearnNoSpouseDeemAmt = 0
if (SsiSpouseDeemUnearnAmt + SsiSpouseDeemEarnAmt > 0) then
  return (R_SsiUnearnNoSpouseDeemAmt + SsiSpouseDeemUnearnAmt)
else 
  return 0
end
"
@R_SsiUnearnSpouseDeemAmt.save!

#25	1730	R_SsiUnearnMinusInfreqAndNeedBasedNoSpouseDeemAmt = R_SsiUnearnNoSpouseDeemAmt - UnearnInfrequentAmt 
#   - UnearnAssistanceBasedOnNeedAmt - up to $60 of SpouseUnearnInfrequentAmt 
#   - SpouseUnearnAssistanceBasedOnNeedAmt - UnearnIncomeBasedOnNeedAmt - SpouseUnearnIncomeBasedOnNeedAmt (not < 0)	
#R_SsiUnearnMinusInfreqAndNeedBasedNoSpouseDeemAmt
#=MAX(0;E167-E169-E170-MIN(60;E171)-E172-E174-E175)
#167 R_SsiUnearnNoSpouseDeemAmt
#169 UnearnInfrequentAmt
#170 UnearnAssistanceBasedOnNeedAmt
#171 SpouseUnearnInfrequentAmt
#172 SpouseUnearnAssistanceBasedOnNeedAmt
#174 UnearnIncomeBasedOnNeedAmt
#175 SpouseUnearnIncomeBasedOnNeedAmt

@R_SsiUnearnMinusInfreqAndNeedBasedNoSpouseDeemAmt  = WebCalc.new(:name => 'R_SsiUnearnMinusInfreqAndNeedBasedNoSpouseDeemAmt')
@R_SsiUnearnMinusInfreqAndNeedBasedNoSpouseDeemAmt.operation = "
R_SsiUnearnNoSpouseDeemAmt = 500
UnearnInfrequentAmt = 0
UnearnAssistanceBasedOnNeedAmt = 0
SpouseUnearnInfrequentAmt = 0
SpouseUnearnAssistanceBasedOnNeedAmt = 0
UnearnIncomeBasedOnNeedAmt = 0
SpouseUnearnIncomeBasedOnNeedAmt = 0
rate60 = 60
CountableSpouseUnearnInfrequentAmt = [rate60,SpouseUnearnInfrequentAmt].min
workVar = (R_SsiUnearnNoSpouseDeemAmt - UnearnInfrequentAmt - UnearnAssistanceBasedOnNeedAmt - CountableSpouseUnearnInfrequentAmt \
 - SpouseUnearnAssistanceBasedOnNeedAmt - UnearnIncomeBasedOnNeedAmt - SpouseUnearnIncomeBasedOnNeedAmt)

workVar = [workVar,0].max
return workVar
"
@R_SsiUnearnMinusInfreqAndNeedBasedNoSpouseDeemAmt.save!

#25	1750	R_SsiUnearnMinusGenExcludeNoSpouseDeemAmt = R_SsiUnearnMinusInfreqAndNeedBasedNoSpouseDeemAmt - RateGenExcludeAmt (Not < 0)	
#R_SsiUnearnMinusGenExcludeNoSpouseDeemAmt
#=MAX(0;E177-E173)
#177 R_SsiUnearnMinusInfreqAndNeedBasedNoSpouseDeemAmt
#173 RateGenExcludeAmt

@R_SsiUnearnMinusGenExcludeNoSpouseDeemAmt  = WebCalc.new(:name => 'R_SsiUnearnMinusGenExcludeNoSpouseDeemAmt')
@R_SsiUnearnMinusGenExcludeNoSpouseDeemAmt.operation = "
R_SsiUnearnMinusInfreqAndNeedBasedNoSpouseDeemAmt = 0
RateGenExcludeAmt = 20
return [R_SsiUnearnMinusInfreqAndNeedBasedNoSpouseDeemAmt, RateGenExcludeAmt].max
"
@R_SsiUnearnMinusGenExcludeNoSpouseDeemAmt.save!

#25	1770	R_UnearnForSsiCalcNoSpouseDeemAmt = R_SsiUnearnMinusGenExcludeNoSpouseDeemAmt + UnearnIncomeBasedOnNeedAmt + SpouseUnearnIncomeBasedOnNeedAmt	
#R_UnearnForSsiCalcNoSpouseDeemAmt
#=E179+E$174+E175
#179 R_SsiUnearnMinusGenExcludeNoSpouseDeemAmt
#174 UnearnIncomeBasedOnNeedAmt
#175 SpouseUnearnIncomeBasedOnNeedAmt

@R_UnearnForSsiCalcNoSpouseDeemAmt  = WebCalc.new(:name => 'R_UnearnForSsiCalcNoSpouseDeemAmt')
@R_UnearnForSsiCalcNoSpouseDeemAmt.operation = "
R_SsiUnearnMinusGenExcludeNoSpouseDeemAmt = 0
UnearnIncomeBasedOnNeedAmt = 0
SpouseUnearnIncomeBasedOnNeedAmt = 0
return (R_SsiUnearnMinusGenExcludeNoSpouseDeemAmt + UnearnIncomeBasedOnNeedAmt + SpouseUnearnIncomeBasedOnNeedAmt)
"
@R_UnearnForSsiCalcNoSpouseDeemAmt.save!

#25	1790	R_SsiUnusedGenExcludeNoSpouseDeemAmt = RateGenExcludeAmt - R_SsiUnearnMinusInfreqAndNeedBasedNoSpouseDeemAmt (Cannot be < 0)	
#R_SsiUnusedGenExcludeNoSpouseDeemAmt
#=MAX(0;E$173-E177)
#173 RateGenExcludeAmt
#177 R_SsiUnearnMinusInfreqAndNeedBasedNoSpouseDeemAmt

@R_SsiUnusedGenExcludeNoSpouseDeemAmt  = WebCalc.new(:name => 'R_SsiUnusedGenExcludeNoSpouseDeemAmt')
@R_SsiUnusedGenExcludeNoSpouseDeemAmt.operation = "
RateGenExcludeAmt = 20
R_SsiUnearnMinusInfreqAndNeedBasedNoSpouseDeemAmt = 0
return [(RateGenExcludeAmt - R_SsiUnearnMinusInfreqAndNeedBasedNoSpouseDeemAmt),0].max
"
@R_SsiUnusedGenExcludeNoSpouseDeemAmt.save!

#25	1810	R_SsiUnearnMinusInfreqAndNeedBasedSpouseDeemAmt = R_SsiUnearnSpouseDeemAmt 
# - up to $60 of UnearnInfrequentAmt - UnearnAssistanceBasedOnNeedAmt - UnearnIncomeBasedOnNeedAmt (not < 0)	
#R_SsiUnearnMinusInfreqAndNeedBasedSpouseDeemAmt
#=MAX(0;E168-MIN(60;E169)-E170-E174)
#168 R_SsiUnearnSpouseDeemAmt
#    Rate60
#169 UnearnInfrequentAmt
#170 UnearnAssistanceBasedOnNeedAmt
#174 UnearnIncomeBasedOnNeedAmt
@R_SsiUnearnMinusInfreqAndNeedBasedSpouseDeemAmt  = WebCalc.new(:name => 'R_SsiUnearnMinusInfreqAndNeedBasedSpouseDeemAmt')
@R_SsiUnearnMinusInfreqAndNeedBasedSpouseDeemAmt.operation = "
R_SsiUnearnSpouseDeemAmt = 0
Rate60 = 60
UnearnInfrequentAmt = 0
UnearnAssistanceBasedOnNeedAmt = 0
UnearnIncomeBasedOnNeedAmt = 0
Upto60ofUnearnInfrequentAmt = [Rate60, UnearnInfrequentAmt].max
return [(R_SsiUnearnSpouseDeemAmt - Upto60ofUnearnInfrequentAmt - UnearnAssistanceBasedOnNeedAmt - UnearnIncomeBasedOnNeedAmt), 0].max
"
@R_SsiUnearnMinusInfreqAndNeedBasedSpouseDeemAmt.save!

#25	1830	R_SsiUnearnMinusGenExcludeSpouseDeemAmt = R_SsiUnearnMinusInfreqAndNeedBasedSpouseDeemAmt - RateGenExcludeAmt (Not < 0)	
#R_SsiUnearnMinusGenExcludeSpouseDeemAmt
#=MAX(0;E185-E173)
#185 R_SsiUnearnMinusInfreqAndNeedBasedSpouseDeemAmt
#173 RateGenExcludeAmt
@R_SsiUnearnMinusGenExcludeSpouseDeemAmt  = WebCalc.new(:name => 'R_SsiUnearnMinusGenExcludeSpouseDeemAmt')
@R_SsiUnearnMinusGenExcludeSpouseDeemAmt.operation = "
R_SsiUnearnMinusInfreqAndNeedBasedSpouseDeemAmt = 0
RateGenExcludeAmt = 20
return [0, (R_SsiUnearnMinusInfreqAndNeedBasedSpouseDeemAmt - RateGenExcludeAmt)].max
"
@R_SsiUnearnMinusGenExcludeSpouseDeemAmt.save!

#25	1850	R_UnearnForSsiCalcSpouseDeemAmt = R_SsiUnearnMinusGenExcludeSpouseDeemAmt + UnearnIncomeBasedOnNeedAmt	
#R_UnearnForSsiCalcSpouseDeemAmt
#=E187+E$174
#187 R_SsiUnearnMinusGenExcludeSpouseDeemAmt
#174 UnearnIncomeBasedOnNeedAmt

@R_UnearnForSsiCalcSpouseDeemAmt  = WebCalc.new(:name => 'R_UnearnForSsiCalcSpouseDeemAmt')
@R_UnearnForSsiCalcSpouseDeemAmt.operation = "
R_SsiUnearnMinusGenExcludeSpouseDeemAmt = 0
UnearnIncomeBasedOnNeedAmt = 0
return (R_SsiUnearnMinusGenExcludeSpouseDeemAmt + UnearnIncomeBasedOnNeedAmt)
"
@R_UnearnForSsiCalcSpouseDeemAmt.save!

#25	1870	R_SsiUnusedGenExcludeSpouseDeemAmt = RateGenExcludeAmt - R_SsiUnearnMinusInfreqAndNeedBasedSpouseDeemAmt (Cannot be < 0)	
#R_SsiUnusedGenExcludeSpouseDeemAmt
#=MAX(0;E$173-E185)
#173 RateGenExcludeAmt
#185 R_SsiUnearnMinusInfreqAndNeedBasedSpouseDeemAmt
@R_SsiUnusedGenExcludeSpouseDeemAmt  = WebCalc.new(:name => 'R_SsiUnusedGenExcludeSpouseDeemAmt')
@R_SsiUnusedGenExcludeSpouseDeemAmt.operation = "
RateGenExcludeAmt = 20
R_SsiUnearnMinusInfreqAndNeedBasedSpouseDeemAmt = 0
return [0, (RateGenExcludeAmt - R_SsiUnearnMinusInfreqAndNeedBasedSpouseDeemAmt)].max
"
@R_SsiUnusedGenExcludeSpouseDeemAmt.save!


#25	2030	R_SeiePlusIrweAmt = Minimum of (SsiOrCaidEarnAmt OR (SeieAmt + SsiCaidIrweAmt))	
#R_SeiePlusIrweAmt
#=MIN(E197;E202+E204)
#197 SsiOrCaidEarnAmt
#202 SeieAmt
#204 SsiCaidIrweAmt
@R_SeiePlusIrweAmt  = WebCalc.new(:name => 'R_SeiePlusIrweAmt')
@R_SeiePlusIrweAmt.operation = "
SsiOrCaidEarnAmt = 1111
SeieAmt = 0
SsiCaidIrweAmt = 0
return [SsiCaidIrweAmt, (SeieAmt + SsiCaidIrweAmt)].min
"
@R_SeiePlusIrweAmt.save!

#25	2050	R_SpouseSeiePlusIrweAmt = Minimum of (SpouseSsiOrCaidEarnAmt OR (SpouseSeieAmt + SpouseSsiCaidIrweAmt))	
#R_SpouseSeiePlusIrweAmt
#=MIN(E198;E203+E205)
#198 SpouseSsiOrCaidEarnAmt
#203 SpouseSeieAmt
#205 SpouseSsiCaidIrweAmt
@R_SpouseSeiePlusIrweAmt  = WebCalc.new(:name => 'R_SpouseSeiePlusIrweAmt')
@R_SpouseSeiePlusIrweAmt.operation = "
SpouseSsiOrCaidEarnAmt = 1111
SpouseSeieAmt = 0
SpouseSsiCaidIrweAmt = 0
return [SpouseSsiOrCaidEarnAmt, (SpouseSeieAmt + SpouseSsiCaidIrweAmt)].min
"
@R_SpouseSeiePlusIrweAmt.save!

#25	2070	R_EarnMinusGenAndEarnExcludeNoSpouseDeemAmt = IF SsiGet = Y, 
#THEN SsiOrCaidEarnAmt + SpouseSsiOrCaidEarnAmt - R_SsiUnusedGenExcludeNoSpouseDeemAmt - RateEarnedIncDisregardAmt, ELSE 0 (not < 0)	
#R_EarnMinusGenAndEarnExcludeNoSpouseDeemAmt
#=MAX(0;IF(E194="YES";E197+E198-E199-E201;0))
#194 SsiGet
#197 SsiOrCaidEarnAmt
#198 SpouseSsiOrCaidEarnAmt
#199 R_SsiUnusedGenExcludeNoSpouseDeemAmt
#201 RateEarnedIncDisregardAmt
@R_EarnMinusGenAndEarnExcludeNoSpouseDeemAmt  = WebCalc.new(:name => 'R_EarnMinusGenAndEarnExcludeNoSpouseDeemAmt')
@R_EarnMinusGenAndEarnExcludeNoSpouseDeemAmt.operation = "
SsiGet = manager.get_answer_by_question_name('SsiGet')
SsiOrCaidEarnAmt = 1111
SpouseSsiOrCaidEarnAmt = 0
R_SsiUnusedGenExcludeNoSpouseDeemAmt = 0
RateEarnedIncDisregardAmt = 65
if SsiGet == 'Yes' then
  return [(SsiOrCaidEarnAmt + SpouseSsiOrCaidEarnAmt - R_SsiUnusedGenExcludeNoSpouseDeemAmt - RateEarnedIncDisregardAmt) , 0].max
else
  return 0
end
"
@R_EarnMinusGenAndEarnExcludeNoSpouseDeemAmt.save!

#25	2090	R_EarnBeforeDivideNoSpouseDeemAmt = R_EarnMinusGenAndEarnExcludeNoSpouseDeemAmt - R_SeiePlusIrweAmt - R_SpouseSeiePlusIrweAmt (Not < 0)	
#R_EarnBeforeDivideNoSpouseDeemAmt
#=MAX(0;E211-E207-E209)
#211 R_EarnMinusGenAndEarnExcludeNoSpouseDeemAmt
#207 R_SeiePlusIrweAmt
#209 R_SpouseSeiePlusIrweAmt
@R_EarnBeforeDivideNoSpouseDeemAmt  = WebCalc.new(:name => 'R_EarnBeforeDivideNoSpouseDeemAmt')
@R_EarnBeforeDivideNoSpouseDeemAmt.operation = "
R_EarnMinusGenAndEarnExcludeNoSpouseDeemAmt =  1111
R_SeiePlusIrweAmt = 0
R_SpouseSeiePlusIrweAmt = 0
return [0, (R_EarnMinusGenAndEarnExcludeNoSpouseDeemAmt - R_SeiePlusIrweAmt - R_SpouseSeiePlusIrweAmt)].max
"
@R_EarnBeforeDivideNoSpouseDeemAmt.save!

#25	2110	R_EarnAfterDivideNoSpouseDeemAmt = R_EarnBeforeDivideNoSpouseDeemAmt divided by 2	
#R_EarnAfterDivideNoSpouseDeemAmt
#=E213/2
#213 R_EarnBeforeDivideNoSpouseDeemAmt
#do i get an error dividing into zero?
@R_EarnAfterDivideNoSpouseDeemAmt  = WebCalc.new(:name => 'R_EarnAfterDivideNoSpouseDeemAmt')
@R_EarnAfterDivideNoSpouseDeemAmt.operation = "
R_EarnBeforeDivideNoSpouseDeemAmt = 1234

return (R_EarnBeforeDivideNoSpouseDeemAmt/2)
"
@R_EarnAfterDivideNoSpouseDeemAmt.save!

#25	2130	R_EarnMinusGenAndEarnExcludeSpouseDeemAmt = IF SsiSpouseDeemEarnAmt + SsiSpouseDeemUnearnAmt > 0, THEN SsiOrCaidEarnAmt + SsiSpouseDeemEarnAmt - R_SsiUnusedGenExcludeSpouseDeemAmt - RateEarnedIncDisregardAmt, ELSE 0 (not < 0)	
#R_EarnMinusGenAndEarnExcludeSpouseDeemAmt
#=IF(E195+E196>0;MAX(0;E197+E195-E200-E201);0)
#195 SsiSpouseDeemEarnAmt
#196 SsiSpouseDeemUnearnAmt
#197 SsiOrCaidEarnAmt
#200 R_SsiUnusedGenExcludeSpouseDeemAmt
#201 RateEarnedIncDisregardAmt
@R_EarnMinusGenAndEarnExcludeSpouseDeemAmt  = WebCalc.new(:name => 'R_EarnMinusGenAndEarnExcludeSpouseDeemAmt')
@R_EarnMinusGenAndEarnExcludeSpouseDeemAmt.operation = "
SsiSpouseDeemEarnAmt = 0
SsiSpouseDeemUnearnAmt = 0
SsiOrCaidEarnAmt = 1111
R_SsiUnusedGenExcludeSpouseDeemAmt = 0
RateEarnedIncDisregardAmt= 65
if (SsiSpouseDeemEarnAmt + SsiSpouseDeemUnearnAmt > 0) then 
  return [(SsiOrCaidEarnAmt + SsiSpouseDeemEarnAmt - R_SsiUnusedGenExcludeSpouseDeemAmt - RateEarnedIncDisregardAmt), 0].max
else 
  return 0
end
"
@R_EarnMinusGenAndEarnExcludeSpouseDeemAmt.save!

#25	2150	R_EarnBeforeDivideSpouseDeemAmt = R_EarnMinusGenAndEarnExcludeSpouseDeemAmt - R_SeiePlusIrweAmt (not < 0)	
#R_EarnBeforeDivideSpouseDeemAmt
#=MAX(0;E217-E207)
#217 R_EarnMinusGenAndEarnExcludeSpouseDeemAmt
#207 R_SeiePlusIrweAmt
@R_EarnBeforeDivideSpouseDeemAmt  = WebCalc.new(:name => 'R_EarnBeforeDivideSpouseDeemAmt')
@R_EarnBeforeDivideSpouseDeemAmt.operation = "
R_EarnMinusGenAndEarnExcludeSpouseDeemAmt = 0
R_SeiePlusIrweAmt = 0
return [0, (R_EarnMinusGenAndEarnExcludeSpouseDeemAmt - R_SeiePlusIrweAmt)].max
"
@R_EarnBeforeDivideSpouseDeemAmt.save!

#25	2170	R_EarnAfterDivideSpouseDeemAmt = R_EarnBeforeDivideSpouseDeemAmt divided by 2	
#R_EarnAfterDivideSpouseDeemAmt
#=E219/2
#219 R_EarnBeforeDivideSpouseDeemAmt
@R_EarnAfterDivideSpouseDeemAmt  = WebCalc.new(:name => 'R_EarnAfterDivideSpouseDeemAmt')
@R_EarnAfterDivideSpouseDeemAmt.operation = "
R_EarnBeforeDivideSpouseDeemAmt = 0
return (R_EarnBeforeDivideSpouseDeemAmt/2)
"
@R_EarnAfterDivideSpouseDeemAmt.save!

#25	2260	IF Blind = N AND SsiGetFinalDetermination = N AND (SsiOrCaidEarnAmt - SgaIrweAmt) > RateSgaDisabledAmt, THEN TRUE. ELSE FALSE	
#R_SgaExceededNotSsiElig
#=IF(AND(E224="NO";E225="NO";(E227-E228)>E226);TRUE();FALSE())
#224 Blind
#225 SsiGetFinalDetermination
#227 SsiOrCaidEarnAmt
#228 SgaIrweAmt
#226 RateSgaDisabledAmt
@R_SgaExceededNotSsiElig  = WebCalc.new(:name => 'R_SgaExceededNotSsiElig')
@R_SgaExceededNotSsiElig.operation = "
Blind = manager.get_answer_by_question_name('Blind')
SsiGetFinalDetermination = manager.get_answer_by_question_name('SsiGetFinalDetermination')
SsiOrCaidEarnAmt = 1111
SgaIrweAmt = 0
RateSgaDisabledAmt = 0
if Blind == 'No' && SsiGetFinalDetermination == 'No' && ((SsiOrCaidEarnAmt - SgaIrweAmt) > RateSgaDisabledAmt) then
  return true
else 
  false
end
"
@R_SgaExceededNotSsiElig.save!

#25	2380	R_TotalIncMinusBweNoSpouseDeemAmt = R_UnearnForSsiCalcNoSpouseDeemAmt + R_EarnAfterDivideNoSpouseDeemAmt - BweAmt - SpouseBweAmt (not < 0)	
#R_TotalIncMinusBweNoSpouseDeemAmt
#=MAX(0;E233+E235-E237-E238)
#233 R_UnearnForSsiCalcNoSpouseDeemAmt
#235 R_EarnAfterDivideNoSpouseDeemAmt
#237 BweAmt
#238 SpouseBweAmt
@R_TotalIncMinusBweNoSpouseDeemAmt  = WebCalc.new(:name => 'R_TotalIncMinusBweNoSpouseDeemAmt')
@R_TotalIncMinusBweNoSpouseDeemAmt.operation = "
R_UnearnForSsiCalcNoSpouseDeemAmt = 0
R_EarnAfterDivideNoSpouseDeemAmt = 0
BweAmt = 0
SpouseBweAmt = 0
return [0, (R_UnearnForSsiCalcNoSpouseDeemAmt + R_EarnAfterDivideNoSpouseDeemAmt - BweAmt - SpouseBweAmt)].max
"
@R_TotalIncMinusBweNoSpouseDeemAmt.save!

#25	2400	R_TotalIncMinusBweSpouseDeemAmt = R_UnearnForSsiCalcSpouseDeemAmt + R_EarnAfterDivideSpouseDeemAmt - BweAmt (not < 0)	
#R_TotalIncMinusBweSpouseDeemAmt
#=MAX(0;E234+E236-E237)
#234 R_UnearnForSsiCalcSpouseDeemAmt
#236 R_EarnAfterDivideSpouseDeemAmt
#237 BweAmt
@R_TotalIncMinusBweSpouseDeemAmt  = WebCalc.new(:name => 'R_TotalIncMinusBweSpouseDeemAmt')
@R_TotalIncMinusBweSpouseDeemAmt.operation = "
R_UnearnForSsiCalcSpouseDeemAmt = 0
R_EarnAfterDivideSpouseDeemAmt = 0
BweAmt = 0
return [0, (R_UnearnForSsiCalcSpouseDeemAmt + R_EarnAfterDivideSpouseDeemAmt - BweAmt)].max
"
@R_TotalIncMinusBweSpouseDeemAmt.save!

#25	2420	R_TotalIncMinusBwePassNoSpouseDeemAmt = R_TotalIncMinusBweNoSpouseDeemAmt - PassAmt - SpousePassAmt (not < 0)	
#R_TotalIncMinusBwePassNoSpouseDeemAmt
#=MAX(0;E242-E239-E240)
#242 R_TotalIncMinusBweNoSpouseDeemAmt
#239 PassAmt
#240 SpousePassAmt
@R_TotalIncMinusBwePassNoSpouseDeemAmt  = WebCalc.new(:name => 'R_TotalIncMinusBwePassNoSpouseDeemAmt')
@R_TotalIncMinusBwePassNoSpouseDeemAmt.operation = "
R_TotalIncMinusBweNoSpouseDeemAmt = 0
PassAmt = 0
SpousePassAmt = 0
return [0, (R_TotalIncMinusBweNoSpouseDeemAmt - PassAmt - SpousePassAmt)].max
"
@R_TotalIncMinusBwePassNoSpouseDeemAmt.save!

#25	2440	R_TotalIncMinusBwePassSpouseDeemAmt = R_TotalIncMinusBweSpouseDeemAmt - PassAmt (not< 0)	
#R_TotalIncMinusBwePassSpouseDeemAmt
#=MAX(0;E244-E239)
#244 R_TotalIncMinusBweSpouseDeemAmt
#239 PassAmt
@R_TotalIncMinusBwePassSpouseDeemAmt  = WebCalc.new(:name => 'R_TotalIncMinusBwePassSpouseDeemAmt')
@R_TotalIncMinusBwePassSpouseDeemAmt.operation = "
R_TotalIncMinusBweSpouseDeemAmt = 0
PassAmt = 0
return [0, (R_TotalIncMinusBweSpouseDeemAmt - PassAmt)].max
"
@R_TotalIncMinusBwePassSpouseDeemAmt.save!

#25	2590	R_FbrNoSpouseDeemAmt = IF SsiGet = Y AND SpouseSsiGet <> Y AND InKindThird <> Y, THEN RateFbrAmt, 
#ELSE IF SsiGet = Y AND SpouseSsiGet = Y AND InKindThird <> Y, THEN RateFbrCoupleAmt, 
#ELSE IF SsiGet = Y AND SpouseSsiGet <> Y AND InKindThird = Y, THEN RateTwoThirdsFbrAmt, 
#ELSE IF SsiGet = Y AND SpouseSsiGet = Y AND InKindThird = Y, THEN RateTwoThirdsFbrCoupleAmt, ELSE 0	
#R_FbrNoSpouseDeemAmt
#=IF(AND(E256="YES";E257<>"YES";E253<>"YES");E251;
#IF(AND(E256="YES";E257="YES";E253<>"YES");E252;
#IF(AND(E256="YES";E257<>"YES";E253="YES");E254;
#IF(AND(E256="YES";E257="YES";E253="YES");E255;0))))
#256 SsiGet
#257 SpouseSsiGet
#253 InKindThird
#251 RateFbrAmt
#252 RateFbrCoupleAmt
#254 RateTwoThirdsFbrAmt
#255 RateTwoThirdsFbrCoupleAmt
@R_FbrNoSpouseDeemAmt  = WebCalc.new(:name => 'R_FbrNoSpouseDeemAmt')
@R_FbrNoSpouseDeemAmt.operation = "
SsiGet = manager.get_answer_by_question_name('SsiGet')
SpouseSsiGet = manager.get_answer_by_question_name('SpouseSsiGet')
InKindThird = manager.get_answer_by_question_name('InKindThird')
RateFbrAmt = 674
RateFbrCoupleAmt = 1011
RateTwoThirdsFbrAmt = 449.34
RateTwoThirdsFbrCoupleAmt = 674.0
if (SsiGet == 'Yes' && SpouseSsiGet != 'Yes' && InKindThird != 'Yes') then
  return RateFbrAmt
elsif (SsiGet == 'Yes' && SpouseSsiGet == 'Yes' && InKindThird != 'Yes') then 
  return RateFbrCoupleAmt
elsif (SsiGet == 'Yes' && SpouseSsiGet != 'Yes' && InKindThird == 'Yes') then
  return RateTwoThirdsFbrAmt
elsif (SsiGet == 'Yes' && SpouseSsiGet == 'Yes' && InKindThird == 'Yes') then
  return RateTwoThirdsFbrCoupleAmt
else 
  return 0
end
"
@R_FbrNoSpouseDeemAmt.save!

#25	2610	R_FbrSpouseDeemAmt = IF SsiSpouseDeemUnearnAmt + SsiSpouseDeemEarnAmt > 0 AND InKindThird <> Y, THEN RateFbrCoupleAmt, ELSE IF SsiSpouseDeemUnearnAmt + SsiSpouseDeemEarnAmt > 0 AND InKindThird = Y, THEN  RateTwoThirdsFbrCoupleAmt ELSE 0	
#R_FbrSpouseDeemAmt
#=IF(AND(E258+E259>0;E253<>"YES");E252;IF(AND(E258+E259>0;E253="YES");E255;0))
#258 SsiSpouseDeemUnearnAmt
#259 SsiSpouseDeemEarnAmt
#253 InKindThird
#252 RateFbrCoupleAmt
#255 RateTwoThirdsFbrCoupleAmt
@R_FbrSpouseDeemAmt  = WebCalc.new(:name => 'R_FbrSpouseDeemAmt')
@R_FbrSpouseDeemAmt.operation = "
SsiSpouseDeemUnearnAmt = 0
SsiSpouseDeemEarnAmt = 0
InKindThird = manager.get_answer_by_question_name('InKindThird')
RateFbrCoupleAmt = 1011
RateTwoThirdsFbrCoupleAmt = 674
if ((SsiSpouseDeemUnearnAmt + SsiSpouseDeemEarnAmt > 0) && InKindThird != 'Yes') then
  return RateFbrCoupleAmt
elsif ((SsiSpouseDeemUnearnAmt + SsiSpouseDeemEarnAmt > 0) && InKindThird == 'Yes')
  return RateTwoThirdsFbrCoupleAmt
else
  return 0
end
"
@R_FbrSpouseDeemAmt.save!

#25	2630	R_SsiNoOveUnderAdjustNoSpouseDeemCalcAmt = R_FbrNoSpouseDeemAmt - R_TotalIncMinusBwePassNoSpouseDeemAmt (not < 0)	
#R_SsiNoOveUnderAdjustNoSpouseDeemCalcAmt
#=MAX(0;E263-E260)
#263 R_FbrNoSpouseDeemAmt
#260 R_TotalIncMinusBwePassNoSpouseDeemAmt

@R_SsiNoOveUnderAdjustNoSpouseDeemCalcAmt  = WebCalc.new(:name => 'R_SsiNoOveUnderAdjustNoSpouseDeemCalcAmt')
@R_SsiNoOveUnderAdjustNoSpouseDeemCalcAmt.operation = "
R_FbrNoSpouseDeemAmt = 0
R_TotalIncMinusBwePassNoSpouseDeemAmt = 0
return [0, (R_FbrNoSpouseDeemAmt - R_TotalIncMinusBwePassNoSpouseDeemAmt)].max
"
@R_SsiNoOveUnderAdjustNoSpouseDeemCalcAmt.save!

#25	2650	R_SsiNoOverUnderAdjustSpouseDeemCalcAmt = R_FbrSpouseDeemAmt - R_TotalIncMinusBwePassSpouseDeemAmt (not< 0)	
#R_SsiNoOverUnderAdjustSpouseDeemCalcAmt
#=MAX(0;E265-E261)
#265 R_FbrSpouseDeemAmt
#261 R_TotalIncMinusBwePassSpouseDeemAmt
@R_SsiNoOverUnderAdjustSpouseDeemCalcAmt  = WebCalc.new(:name => 'R_SsiNoOverUnderAdjustSpouseDeemCalcAmt')
@R_SsiNoOverUnderAdjustSpouseDeemCalcAmt.operation = "
R_FbrSpouseDeemAmt = 0
R_TotalIncMinusBwePassSpouseDeemAmt = 0
return [0, (R_FbrSpouseDeemAmt - R_TotalIncMinusBwePassSpouseDeemAmt)].max
"
@R_SsiNoOverUnderAdjustSpouseDeemCalcAmt.save!

#25	2670	R_SsiSpousalDeemCalcsUsed = TRUE IF SsiSpouseDeemUnearnAmt + SsiSpouseDeemEarnAmt > 0 AND R_SsiNoOverUnderAdjustSpouseDeemCalcAmt < R_SsiNoOveUnderAdjustNoSpouseDeemCalcAmt ELSE FALSE	
#R_SsiSpousalDeemCalcsUsed
#=IF(AND(E258+E259>0;E269<E267);"True";"False")
#258 SsiSpouseDeemUnearnAmt
#259 SsiSpouseDeemEarnAmt
#269 R_SsiNoOverUnderAdjustSpouseDeemCalcAmt
#267 R_SsiNoOveUnderAdjustNoSpouseDeemCalcAmt
@R_SsiSpousalDeemCalcsUsed  = WebCalc.new(:name => 'R_SsiSpousalDeemCalcsUsed')
@R_SsiSpousalDeemCalcsUsed.operation = "
SsiSpouseDeemUnearnAmt = 0
SsiSpouseDeemEarnAmt = 0
R_SsiNoOverUnderAdjustSpouseDeemCalcAmt = 0
R_SsiNoOveUnderAdjustNoSpouseDeemCalcAmt = 0
if ((SsiSpouseDeemUnearnAmt + SsiSpouseDeemEarnAmt > 0) && (R_SsiNoOverUnderAdjustSpouseDeemCalcAmt < R_SsiNoOveUnderAdjustNoSpouseDeemCalcAmt))
  true
else
  false
end
"
@R_SsiSpousalDeemCalcsUsed.save!

#25	2690	R_SsiNoOverUnderAdjustCalcAmt = IF R_SsiSpousalDeemCalcsUsed = TRUE, then R_SsiNoOverUnderAdjustSpouseDeemCalcAmt, ELSE R_SsiNoOveUnderAdjustNoSpouseDeemCalcAmt	
#R_SsiNoOverUnderAdjustCalcAmt
#=IF(E271=TRUE();E269;E267)
#271 R_SsiSpousalDeemCalcsUsed
#269 R_SsiNoOverUnderAdjustSpouseDeemCalcAmt
#267 R_SsiNoOveUnderAdjustNoSpouseDeemCalcAmt
@R_SsiNoOverUnderAdjustCalcAmt  = WebCalc.new(:name => 'R_SsiNoOverUnderAdjustCalcAmt')
@R_SsiNoOverUnderAdjustCalcAmt.operation = "
R_SsiSpousalDeemCalcsUsed = false
R_SsiNoOverUnderAdjustSpouseDeemCalcAmt = 0
R_SsiNoOveUnderAdjustNoSpouseDeemCalcAmt = 0
if R_SsiSpousalDeemCalcsUsed == true then
  return R_SsiNoOverUnderAdjustSpouseDeemCalcAmt
else 
  return R_SsiNoOveUnderAdjustNoSpouseDeemCalcAmt
end
"
@R_SsiNoOverUnderAdjustCalcAmt.save!


#25	2780	R_SsiActualAmt = IF SpouseSsiGet = Y, THEN SsiCoupleActualAmt, ELSE SsiUserActualAmt	
#R_SsiActualAmt
#=IF(E279="YES";E278;E277)
#279 SpouseSsiGet
#278 SsiCoupleActualAmt
#277 SsiUserActualAmt
@R_SsiActualAmt  = WebCalc.new(:name => 'R_SsiActualAmt')
@R_SsiActualAmt.operation = "
SpouseSsiGet = manager.get_answer_by_question_name('SpouseSsiGet')
SsiCoupleActualAmt = 0
SsiUserActualAmt = 0
if SpouseSsiGet == 'Yes' then
  return SsiCoupleActualAmt
else 
  return SsiUserActualAmt
end
"
@R_SsiActualAmt.save!

#25	2800	R_ActualSsiGreaterThanCalcSsiNoOverUnderAdjust = IF Current/What-If Button = Current AND R_SsiActualAmt > R_SsiNoOverUnderAdjustCalcAmt, THEN TRUE, ELSE FALSE	
#R_ActualSsiGreaterThanCalcSsiNoOverUnderAdjust
#=IF(AND(E276="Current";E282>E280);TRUE();FALSE())
#276 Current/What-If Button
#282 R_SsiActualAmt
#280 R_SsiNoOverUnderAdjustCalcAmt
#Bob is ignoring the current test for now
@R_ActualSsiGreaterThanCalcSsiNoOverUnderAdjust  = WebCalc.new(:name => 'R_ActualSsiGreaterThanCalcSsiNoOverUnderAdjust')
@R_ActualSsiGreaterThanCalcSsiNoOverUnderAdjust.operation = "
R_SsiActualAmt = 0
R_SsiNoOverUnderAdjustCalcAmt = 0
if (R_SsiActualAmt > R_SsiNoOverUnderAdjustCalcAmt) then
  return true
else 
  false
end
"
@R_ActualSsiGreaterThanCalcSsiNoOverUnderAdjust.save!

#25	2820	R_ActualSsiLessThanCalcSsiNoOverUnderAdjust = IF Current/What-If Button = Current AND R_SsiActualAmt < R_SsiNoOverUnderAdjustCalcAmt, THEN TRUE, ELSE FALSE	
#R_ActualSsiLessThanCalcSsiNoOverUnderAdjust
#=IF(AND(E276="Current";E282<E280);TRUE();FALSE())
#276 Current/What-If Button
#282 R_SsiActualAmt
#280 R_SsiNoOverUnderAdjustCalcAmt
#Bob is ignoring the current test for now
@R_ActualSsiLessThanCalcSsiNoOverUnderAdjust  = WebCalc.new(:name => 'R_ActualSsiLessThanCalcSsiNoOverUnderAdjust')
@R_ActualSsiLessThanCalcSsiNoOverUnderAdjust.operation = "
R_SsiActualAmt = 0
R_SsiNoOverUnderAdjustCalcAmt = 0
if (R_SsiActualAmt < R_SsiNoOverUnderAdjustCalcAmt) then
  return true
else 
  false
end
"
@R_ActualSsiLessThanCalcSsiNoOverUnderAdjust.save!

#25	2930	R_SsiUserOverUnderAdjustCalcAmt = IF SsiGet = Y AND SpouseSsiGet <> Y, THEN R_SsiNoOverUnderAdjustCalcAmt + SsiUserUnderPayAddAmt - SsiUserOverPayDeductAmt, ELSE 0 (not < 0)	
#R_SsiUserOverUnderAdjustCalcAmt
#=IF(AND(E294="YES";E295<>"YES");MAX(0;E289+E290-E291);0)
#294 SsiGet
#295 SpouseSsiGet
#289 R_SsiNoOverUnderAdjustCalcAmt
#290 SsiUserUnderPayAddAmt
#291 SsiUserOverPayDeductAmt
@R_SsiUserOverUnderAdjustCalcAmt  = WebCalc.new(:name => 'R_SsiUserOverUnderAdjustCalcAmt')
@R_SsiUserOverUnderAdjustCalcAmt.operation = "
SsiGet = manager.get_answer_by_question_name('SsiGet')
SpouseSsiGet = manager.get_answer_by_question_name('SpouseSsiGet')
R_SsiNoOverUnderAdjustCalcAmt = 0
SsiUserUnderPayAddAmt = 0
SsiUserOverPayDeductAmt = 0
if (SsiGet == 'Yes' && SpouseSsiGet != 'Yes') then
  return (R_SsiNoOverUnderAdjustCalcAmt + SsiUserUnderPayAddAmt - SsiUserOverPayDeductAmt)
else
  return 0
end
"
@R_SsiUserOverUnderAdjustCalcAmt.save!

#25	2940	R_SsiCoupleOverUnderAdjustCalcAmt = IF SsiGet = Y AND SpouseSsiGet = Y, THEN R_SsiNoOverUnderAdjustCalcAmt + SsiCoupleUnderPayAddAmt - SsiCoupleOverPayDeductAmt, ELSE 0 (not < 0)	
#R_SsiCoupleOverUnderAdjustCalcAmt
#=IF(AND(E294="YES";E295="YES");MAX(0;E289+E292-E293);0)
#294 SsiGet
#295 SpouseSsiGet
#289 R_SsiNoOverUnderAdjustCalcAmt
#292 SsiCoupleUnderPayAddAmt
#293 SsiCoupleOverPayDeductAmt
@R_SsiCoupleOverUnderAdjustCalcAmt  = WebCalc.new(:name => 'R_SsiCoupleOverUnderAdjustCalcAmt')
@R_SsiCoupleOverUnderAdjustCalcAmt.operation = "
SsiGet = manager.get_answer_by_question_name('SsiGet')
SpouseSsiGet = manager.get_answer_by_question_name('SpouseSsiGet')
R_SsiNoOverUnderAdjustCalcAmt = 0
SsiCoupleUnderPayAddAmt = 0
SsiCoupleOverPayDeductAmt = 0
if (SsiGet == 'Yes' && SpouseSsiGet == 'Yes') then
  return (R_SsiNoOverUnderAdjustCalcAmt + SsiCoupleUnderPayAddAmt - SsiCoupleOverPayDeductAmt)
else 
  return 0
end
"
@R_SsiCoupleOverUnderAdjustCalcAmt.save!

#25	3050	R_ActualSsiNotEqualCalcSsiAfterOverUnderAdjust = IF Current/What-If Button = Current AND SsiGet = Y AND SpouseSsiGet <> Y AND SsiUserActualAmt <> R_SsiUserOverUnderAdjustCalcAmt, THEN TRUE, ELSE FALSE	
#R_ActualSsiNotEqualCalcSsiAfterOverUnderAdjust
#=IF(AND(E301="Current";E302="YES";E303<>"YES";E304<>E306);TRUE();FALSE())
#301 Current/What-If Button
#302 SsiGet
#303 SpouseSsiGet
#304 SsiUserActualAmt
#306 R_SsiUserOverUnderAdjustCalcAmt
@R_ActualSsiNotEqualCalcSsiAfterOverUnderAdjust  = WebCalc.new(:name => 'R_ActualSsiNotEqualCalcSsiAfterOverUnderAdjust')
@R_ActualSsiNotEqualCalcSsiAfterOverUnderAdjust.operation = "
SsiGet = manager.get_answer_by_question_name('SsiGet')
SpouseSsiGet = manager.get_answer_by_question_name('SpouseSsiGet')
SsiUserActualAmt = 0
R_SsiUserOverUnderAdjustCalcAmt = 0
if (SsiGet == 'Yes' && SpouseSsiGet != 'Yes' && SsiUserActualAmt != R_SsiUserOverUnderAdjustCalcAmt) then
  return true
else
  false
end
"
@R_ActualSsiNotEqualCalcSsiAfterOverUnderAdjust.save!

#25	3060	R_CoupleActualSsiNotEqualCalcSsiAfterOverUnderAdjust = IF Current/What-If Button = Current AND SsiGet = Y AND SpouseSsiGet = Y AND SsiCoupleActualAmt <> R_SsiCoupleOverUnderAdjustCalcAmt, THEN TRUE, ELSE FALSE	
#R_CoupleActualSsiNotEqualCalcSsiAfterOverUnderAdjust
#=IF(AND(E301="Current";E302="YES";E303="YES";E305<>E307);TRUE();FALSE())
#301 Current/What-If Button
#302 SsiGet
#303 SpouseSsiGet
#305 SsiCoupleActualAmt
#307 R_SsiCoupleOverUnderAdjustCalcAmt
@R_CoupleActualSsiNotEqualCalcSsiAfterOverUnderAdjust  = WebCalc.new(:name => 'R_CoupleActualSsiNotEqualCalcSsiAfterOverUnderAdjust')
@R_CoupleActualSsiNotEqualCalcSsiAfterOverUnderAdjust.operation = "
SsiGet = manager.get_answer_by_question_name('SsiGet')
SpouseSsiGet = manager.get_answer_by_question_name('SpouseSsiGet')
SsiCoupleActualAmt = 0
R_SsiCoupleOverUnderAdjustCalcAmt = 0
if (SsiGet == 'Yes' && SpouseSsiGet == 'Yes' && SsiCoupleActualAmt != R_SsiCoupleOverUnderAdjustCalcAmt) then
  return true
else
  false
end
"
@R_CoupleActualSsiNotEqualCalcSsiAfterOverUnderAdjust.save!

#
@x  = WebCalc.new(:name => 'x')
@x.operation = "
"
@x.save!

@Incomplete  = WebCalc.new(:name => 'Incomplete')
@Incomplete.operation = "
return 'incomplete'
"
@Incomplete.save!

@BobBlank  = WebCalc.new(:name => 'BobBlank')
@BobBlank.operation = "
return '  '
"
@BobBlank.save!

#####                    Numerical results
# Creat web numerical result group
WebNumericalResultsGroup.delete_all
@INCOME = WebNumericalResultsGroup.create!(:name => 'INCOME', :order => 1)

# Create web numerical 
#Note we need a way to indent inside group and then bold totals
WebNumericalResult.delete_all
WebNumericalResult.create!(:name => 'SSDI_Cash_Benefit_Self', :display_rules => 'always', :order => 1, :web_calc_id => @R_SsdiPayAllAdjustButCareBAmt.id,    :group_id => @INCOME.id)

#note how do we address the display rule?  IF SpouseSsdiGet = Y
#@SSDI_Cash_Benefit_Self.display_rules = "
#SpouseSsdiGet = manager.get_answer_by_question_name('SpouseSsdiGet')
#LiveWithSpouse == 'Yes'
#"
#@SSDI_Cash_Benefit_Self.save!



WebNumericalResult.create!(:name => '   SSDI Cash Benefit (Spouse)',    :display_rules => 'always', :order => 2, :web_calc_id => @R_SpouseSsdiPayAllAdjustButCareBAmt.id, :group_id => @INCOME.id)
WebNumericalResult.create!(:name => '   SSI Cash Benefit (Self)', :display_rules => 'always', :order => 3, :web_calc_id => @R_SsiUserOverUnderAdjustCalcAmt.id,    :group_id => @INCOME.id)
WebNumericalResult.create!(:name => '   SSI Cash Benefit (SSI Couple)', :display_rules => 'always', :order => 4, :web_calc_id => @R_SsiCoupleOverUnderAdjustCalcAmt.id,    :group_id => @INCOME.id)
#WebNumericalResult.create!(:name => 'Virginia Auxiliary Grant', :display_rules => 'always', :order => 5, :web_calc_id => @VA_CaidRAuxGrantPaymentAmt.id,    :group_id => @INCOME.id)

#This RUnearnAmt  will be deleteed or moved once we figure out how to reference once.
@RUnearnAmt  = WebCalc.new(:name => 'RUnearnAmt')
@RUnearnAmt.operation = "
UnearnAmt = manager.get_answer_by_question_name('UnearnAmt')
if UnearnAmt != nil then
  return Float(UnearnAmt)
else
  return 0
end
"
@RUnearnAmt.save!
#for some reason the Sprint F does not produce output expected sprintf('$%.2f', @RUnearnAmt.id) does not print anything out
WebNumericalResult.create!(:name => 'Other Unearned Income (Self)', :display_rules => 'always', :order => 6, :web_calc_id =>  sprintf('$%.2f', @RUnearnAmt.id),    :group_id => @INCOME.id)

@RSpouseUnEarnAmt  = WebCalc.new(:name => 'RSpouseUnEarnAmt')
@RSpouseUnEarnAmt.operation = "
SpouseUnEarnAmt = manager.get_answer_by_question_name('SpouseUnEarnAmt')
if SpouseUnEarnAmt != nil then
  return Float(SpouseUnEarnAmt)
else
  return 0
end
"
@RSpouseUnEarnAmt.save!
WebNumericalResult.create!(:name => '   Other Unearned Income (Spouse)', :display_rules => 'always', :order => 7, :web_calc_id => @RSpouseUnEarnAmt.id,    :group_id => @INCOME.id)


@RSsdiEarnAmt  = WebCalc.new(:name => 'RSsdiEarnAmt')
@RSsdiEarnAmt.operation = "
SsdiEarnAmt = manager.get_answer_by_question_name('SsdiEarnAmt')
if SsdiEarnAmt != nil then
  return Float(SsdiEarnAmt)
else
  return 0
end
"
@RSsdiEarnAmt.save!
WebNumericalResult.create!(:name => '   Earned Income (Self)', :display_rules => 'always', :order => 8, :web_calc_id => @RSsdiEarnAmt.id,    :group_id => @INCOME.id)

@RSpouseSsdiEarnAmt  = WebCalc.new(:name => 'RSpouseSsdiEarnAmt')
@RSpouseSsdiEarnAmt.operation = "
SpouseSsdiEarnAmt = manager.get_answer_by_question_name('SpouseSsdiEarnAmt')
if SpouseSsdiEarnAmt != nil then
  return Float(SpouseSsdiEarnAmt)
else
  return 0
end
"
@RSpouseSsdiEarnAmt.save!
WebNumericalResult.create!(:name => '   Earned Income (Spouse)', :display_rules => 'always', :order => 9, :web_calc_id => @RSpouseSsdiEarnAmt.id,    :group_id => @INCOME.id)

@RSsiOrCaidEarnAmt  = WebCalc.new(:name => 'RSsiOrCaidEarnAmt')
@RSsiOrCaidEarnAmt.operation = "
SsiOrCaidEarnAmt = manager.get_answer_by_question_name('SsiOrCaidEarnAmt')
if SsiOrCaidEarnAmt != nil then
  return Float(SsiOrCaidEarnAmt)
else
  return 0
end
"
@RSsiOrCaidEarnAmt.save!
WebNumericalResult.create!(:name => '   Earned Income Received (Self)', :display_rules => 'always', :order => 10, :web_calc_id => @RSsiOrCaidEarnAmt.id,    :group_id => @INCOME.id)

@RSpouseSsiOrCaidEarnAmt  = WebCalc.new(:name => 'RSpouseSsiOrCaidEarnAmt')
@RSpouseSsiOrCaidEarnAmt.operation = "
SpouseSsiOrCaidEarnAmt = manager.get_answer_by_question_name('SpouseSsiOrCaidEarnAmt')
if SpouseSsiOrCaidEarnAmt != nil then
  return Float(SpouseSsiOrCaidEarnAmt)
else
  return 0
end
"
@RSpouseSsiOrCaidEarnAmt.save!

WebNumericalResult.create!(:name => 'Earned Income Received (Spouse)', :display_rules => 'always', :order => 11, :web_calc_id => @Incomplete.id,    :group_id => @INCOME.id)


#How do i access/modify a WebNumericalResult's display rule? '   Earned Income Received (Spouse)'.name does not seem to work
  
# can we add in currency questions that do not show and know we are adding in zero's?  If not we will need to test display rules for both 
#Note these outputs need formating help, right justified currency values.  Also need to create spacer between groups and a way to Bold totals
#Bah we have another problem here.  We want to use the same text in different places within numeric results so we need a name that does not conflict but has the same text
#a quick fix was to add a blank space to the end, not sure if this is what we want

#create a Total Gross income calc to be used inside the :name => 'Total Gross Income' Web numerical result
#@RTotalGrossIncome  = WebCalc.new(:name => 'RTotalGrossIncome')
#@RTotalGrossIncome.operation = "
#Note calculate Total Gross Income: Sum the following based on conditions
# IF DiGet = Y then add in R_SsdiPayAllAdjustButCareBAmt                                                        [SSDI Cash Benefit (Self)]
# IF SpouseSsdiGet = Y then add in R_SpouseSsdiPayAllAdjustButCareBAmt                                          [SSDI Cash Benefit (Spouse)]
# IF SsiGet = Y AND SpouseSsiGet <> Y then add in R_SsiUserOverUnderAdjustCalcAmt                               [SSI Cash Benefit (Self)]
# IF SsiGet = Y AND SpouseSsiGet = Y then add R_SsiCoupleOverUnderAdjustCalcAmt                                [SSI Cash Benefit (SSI Couple)]
# IF unearnAmt question shows then add in UnearnAmt                                                             [Other Unearned Income (Self)]
# if SpouseUnEarnAmt appears then add in SpouseUnEarnAmt                                                       [Other Unearned Income (Spouse)]
# IF SsdiEarnAmt Appear = Appear AND SsiOrCaidEarnAmt Appear = no add in SsdiEarnAmt                               [Earned Income (Self)]
# IF SpouseSsdiEarnAmt Appear = Appear AND SpouseSsiOrCaidEarnAmt Appear = no add in SpouseSsdiEarnAmt         [Earned Income (Spouse)]
# IF SsiOrCaidEarnAmt Appear =Appear add in SsiOrCaidEarnAmt                                                   [Earned Income Received (Self)]
# IF SpouseSsiOrCaidEarnAmt Appear = Appear add in SpouseSsiOrCaidEarnAmt                                      [Earned Income Received (Spouse)]                                 

#
#@RTotalGrossIncome.save!

WebNumericalResult.create!(:name =>'Total Gross Income)', :display_rules => 'always', :order => 12, :web_calc_id => @Incomplete.id,    :group_id => @INCOME.id)


#result = RAge.calculate manager
#New Group Expenses
@EXPENSES = WebNumericalResultsGroup.create!(:name => 'EXPENSES', :order => 2)

#Expenses
#25	160	EXPENSES		Always	true	
#25	170	Disability Related Work Expenses	DisWorkExpAmt	IF DisWorkExpAmt Appear =Appear	
WebNumericalResult.create!(:name => 'Disability Related Work Expenses', :display_rules => 'always', :order => 1, :web_calc_id => @Incomplete.id,    :group_id => @EXPENSES.id)
#WebNumericalResult.display_rules = "true"



#25	180	Spouse Disability Related Work Expenses	SpouseDisWorkExpAmt	IF SpouseDisWorkExpAmt Appear = true
WebNumericalResult.create!(:name => 'Spouse Disability Related Work Expenses', :display_rules => 'always', :order => 2, :web_calc_id => @Incomplete.id,    :group_id => @EXPENSES.id)

#25	190	Other Work Expenses	OthWorkExpAmt	IF OthWorkExpAmt Appear = Appear	
WebNumericalResult.create!(:name => 'Other Work Expenses', :display_rules => 'always', :order => 3, :web_calc_id => @Incomplete.id,    :group_id => @EXPENSES.id)

#25	200	Spouse Other Work Expenses	SpouseOthWorkExpAmt	IF SpouseOthWorkExpAmt Appear = Appear
WebNumericalResult.create!(:name => 'Spouse Other Work Expenses', :display_rules => 'always', :order => 4, :web_calc_id => @Incomplete.id,    :group_id => @EXPENSES.id)

#25	210	Employability Investments	EmployInvestAmt	IF EmployInvestAmt Appear =Appear
WebNumericalResult.create!(:name => 'Employability Investments', :display_rules => 'always', :order => 5, :web_calc_id => @Incomplete.id,    :group_id => @EXPENSES.id)

#25	220	Spouse Employability Investments	SpouseEmployInvestAmt	IF SpouseEmployInvestAmt Appear = Appear
WebNumericalResult.create!(:name => 'Spouse Employability Investments', :display_rules => 'always', :order => 6, :web_calc_id => @Incomplete.id,    :group_id => @EXPENSES.id)

#25  Bob thinks this assisted living stuff is not for this version 	230	Assisted Living/Adult Foster Care Payment (Self)	VA_AuxGrantFacilityRateAmt	IF VA_AuxGrantFacilityRateAmt Appear =Appear	
#25	240	 Bob thinks this assisted living stuff is not for this versionAssisted Living/Adult Foster Care Payment (Couple)	VA_CoupleAuxGrantFacilityRateAmt	IF VA_CoupleAuxGrantFacilityRateAmt Appear = Appear		 

#25	250	Medicare Part B Premium	To Be Calculated	IF CareBGet = Y	true	TB Calc
WebNumericalResult.create!(:name => 'Medicare Part B Premium', :display_rules => 'always', :order => 7, :web_calc_id => @Incomplete.id,    :group_id => @EXPENSES.id)

#25	260	Spouse Medicare Part B Premium	To Be Calculated	IF SpouseCareBGet = Y	
WebNumericalResult.create!(:name => 'Spouse Medicare Part B Premium', :display_rules => 'always', :order => 8, :web_calc_id => @Incomplete.id,    :group_id => @EXPENSES.id)

#25	270	Estimated Medical Expenses	To Be Calculated			
WebNumericalResult.create!(:name => 'Estimated Medical Expenses', :display_rules => 'always', :order => 9, :web_calc_id => @Incomplete.id,    :group_id => @EXPENSES.id)

#25	280	Spouse Estimated Medical Expenses	To Be Calculated			
WebNumericalResult.create!(:name => 'Spouse Estimated Medical Expenses', :display_rules => 'always', :order => 10, :web_calc_id => @Incomplete.id,    :group_id => @EXPENSES.id)

#25	290	Estimated Taxes	EstEarnTaxAmt	IF EstEarnTaxAmt Appear = Appear
WebNumericalResult.create!(:name => 'Estimated Taxes', :display_rules => 'always', :order => 11, :web_calc_id => @Incomplete.id,    :group_id => @EXPENSES.id)

#25	300	Spouse Estimated Taxes	SpouseEstEarnTaxAmt	IF SpouseEstEarnTaxAmt Appear =Appear	
WebNumericalResult.create!(:name => 'Spouse Estimated Taxes', :display_rules => 'always', :order => 12, :web_calc_id => @Incomplete.id,    :group_id => @EXPENSES.id)

#25	310	Other Estimated Expenses	OtherExpAmt	IF OtherExpAmt Appear = Appear
WebNumericalResult.create!(:name => 'Other Estimated Expenses', :display_rules => 'always', :order => 13, :web_calc_id => @Incomplete.id,    :group_id => @EXPENSES.id)

#25	320	Spouse Other Estimated Expenses	SpouseOtherExpAmt	IF SpouseOtherExpAmt Appear = Appear
WebNumericalResult.create!(:name => 'Spouse Other Estimated Expenses', :display_rules => 'always', :order => 14, :web_calc_id => @Incomplete.id,    :group_id => @EXPENSES.id)

#25	330	Total Expenses & Employability Investments 	Sum of posted expense amounts	Always	
WebNumericalResult.create!(:name => 'Total Expenses & Employability Investments ', :display_rules => 'always', :order => 15, :web_calc_id => @Incomplete.id,    :group_id => @EXPENSES.id)

#New Group INCOME minus EXPENSES
#25	350	INCOME minus EXPENSES		Always	true	
@INCOMEminusEXPENSES = WebNumericalResultsGroup.create!(:name => 'INCOME minus EXPENSES', :order => 3)

#25	360	Total Gross Income	Sum of posted income amounts	Always
WebNumericalResult.create!(:name => 'Total Gross Income', :display_rules => 'always', :order => 1, :web_calc_id => @Incomplete.id,    :group_id => @INCOMEminusEXPENSES.id)

#Bah we have another problem here.  We want to use the same text in different places within numeric results so we need a name that does not conflict but has the same text
#a quick fix was to add a blank space to the end, not sure if this is what we want
#25	370	Total Expenses & Employability Investments 	Sum of posted expense amounts	Always	
WebNumericalResult.create!(:name => 'Total Expenses & Employability Investments  ', :display_rules => 'always', :order => 2, :web_calc_id => @Incomplete.id,    :group_id => @INCOMEminusEXPENSES.id)

#25	380	SSI/DI NET INCOME	RNetInc	Always	
WebNumericalResult.create!(:name => 'SSI/DI NET INCOME', :display_rules => 'always', :order => 3, :web_calc_id => @Incomplete.id,    :group_id => @INCOMEminusEXPENSES.id)

#New Group  #174	Deemed Income		If ParDeem = Y OR SpouseDeem = Y
@DeemedIncome = WebNumericalResultsGroup.create!(:name => 'Deemed Income', :order => 4)

#175	Deemed Parental Income	RParDeemAmt	If ParDeem = Y 
WebNumericalResult.create!(:name => '    Deemed Parental Income', :display_rules => 'always', :order => 1, :web_calc_id => @Incomplete.id,    :group_id => @DeemedIncome.id)

#176	Deemed Unearned Spousal Income	RSpouseUnearnDeemAmt	If SpouseDeem = Y
WebNumericalResult.create!(:name => '    Deemed Unearned Spousal Income', :display_rules => 'always', :order => 2, :web_calc_id => @Incomplete.id,    :group_id => @DeemedIncome.id)

#177	Deemed Earned Spousal Income	RSpouseEarnDeemAmt	If SpouseDeem = Y
WebNumericalResult.create!(:name => '    Deemed Earned Spousal Income', :display_rules => 'always', :order => 3, :web_calc_id => @Incomplete.id,    :group_id => @DeemedIncome.id)

#178	Total Deemed Spousal Income	RSpouseTotalDeemedAmt	If SpouseDeem = Y
WebNumericalResult.create!(:name => 'Total Deemed Spousal Income', :display_rules => 'always', :order => 4, :web_calc_id => @Incomplete.id,    :group_id => @DeemedIncome.id)

#new Group #220	SSI & SSDI Work Incentives	
@SSI_SSDIWorkIncentives = WebNumericalResultsGroup.create!(:name => 'SSI & SSDI Work Incentives', :order => 5)

#230	Student Earned Income Exclusion (SEIE)	RCoupleSEIEAmt	RSEIENumRHide
WebNumericalResult.create!(:name => 'Student Earned Income Exclusion (SEIE)', :display_rules => 'always', :order => 1, :web_calc_id => @Incomplete.id,    :group_id => @SSI_SSDIWorkIncentives.id)

#240	IRWE (affecting SSI Benefit Level)	RIRWESSIBenefitAmt	RIRWESSIBenefitNumRHide
WebNumericalResult.create!(:name => 'IRWE (affecting SSI Benefit Level)', :display_rules => 'always', :order => 2, :web_calc_id => @Incomplete.id,    :group_id => @SSI_SSDIWorkIncentives.id)

#250	IRWE (affecting SGA Determination)	RIRWESGAAmt	RIRWESSGANumRHide
WebNumericalResult.create!(:name => 'IRWE (affecting SGA Determination)', :display_rules => 'always', :order => 3, :web_calc_id => @Incomplete.id,    :group_id => @SSI_SSDIWorkIncentives.id)

#260	BWE (affecting SSI Benefit Level)	RBWESSIBenefitAmt	RBWESSIBenefitNumRHide
WebNumericalResult.create!(:name => 'BWE (affecting SSI Benefit Level)', :display_rules => 'always', :order => 4, :web_calc_id => @Incomplete.id,    :group_id => @SSI_SSDIWorkIncentives.id)

#270	PASS (resources)	RPASSResourceAmt	RPASSResourceNumRHide
WebNumericalResult.create!(:name => 'PASS (resources)', :display_rules => 'always', :order => 5, :web_calc_id => @Incomplete.id,    :group_id => @SSI_SSDIWorkIncentives.id)

#280	PASS (income)	RPASSIncomeAmt	RPASSIncomeNumRHide
WebNumericalResult.create!(:name => 'PASS (income)', :display_rules => 'always', :order => 6, :web_calc_id => @Incomplete.id,    :group_id => @SSI_SSDIWorkIncentives.id)

#290	Trial Work & Grace Periods	RTWP 	RTWPNumRHide
WebNumericalResult.create!(:name => 'Trial Work & Grace Periods', :display_rules => 'always', :order => 7, :web_calc_id => @Incomplete.id,    :group_id => @SSI_SSDIWorkIncentives.id)

#300	Subsidy	RSubsidyAmt	RSubsidyNumRHide
WebNumericalResult.create!(:name => 'Subsidy', :display_rules => 'always', :order => 8, :web_calc_id => @Incomplete.id,    :group_id => @SSI_SSDIWorkIncentives.id)



#Test Area
#@Testing = WebNumericalResultsGroup.create!(:name => 'InternalTesting', :order => 100)
@BobTesting = WebNumericalResultsGroup.create!(:name => 'Bob Testing', :order => 120)
WebTip.create!( :identifier => 'CSA-Disability2',      :display_rules => 'always',   :group_id => @BobTesting.id ,  :question_id => nil,     :text => 'This is a test to see if web tips show up in numeric results ')
WebNumericalResult.create!(:name => 'RSgaAmtBasedOnDate', :display_rules => 'always', :order => 1, :web_calc_id => @Incomplete.id,    :group_id => @BobTesting.id)
WebNumericalResult.create!(:name => 'R_SsdiSgaExceeded', :display_rules => 'always', :order => 2, :web_calc_id => @R_SsdiSgaExceeded.id,    :group_id => @BobTesting.id)
WebNumericalResult.create!(:name => 'R_SsdiBenefitStops', :display_rules => 'always', :order => 3, :web_calc_id => @R_SsdiBenefitStops.id,    :group_id => @BobTesting.id)
WebNumericalResult.create!(:name => 'R_SsdiEseCeases', :display_rules => 'always', :order => 4, :web_calc_id => @R_SsdiEseCeases.id,    :group_id => @BobTesting.id)
WebNumericalResult.create!(:name => 'R_SsdiPayNoAdjustAmt', :display_rules => 'always', :order => 5, :web_calc_id => @R_SsdiPayNoAdjustAmt.id,    :group_id => @BobTesting.id)
WebNumericalResult.create!(:name => 'R_SsdiPayCareBAdjustAmt', :display_rules => 'always', :order => 6, :web_calc_id => @R_SsdiPayCareBAdjustAmt.id,    :group_id => @BobTesting.id)
WebNumericalResult.create!(:name => 'R_SsdiPayWcOrPdbAdjustAmt', :display_rules => 'always', :order => 7, :web_calc_id => @R_SsdiPayWcOrPdbAdjustAmt.id,    :group_id => @BobTesting.id)
WebNumericalResult.create!(:name => 'R_SsdiPayOverUnderAdjustAmt', :display_rules => 'always', :order => 8, :web_calc_id => @R_SsdiPayOverUnderAdjustAmt.id,    :group_id => @BobTesting.id)
WebNumericalResult.create!(:name => 'R_SsdiPayAllAdjustAmt', :display_rules => 'always', :order => 9, :web_calc_id => @R_SsdiPayAllAdjustAmt.id,    :group_id => @BobTesting.id)
WebNumericalResult.create!(:name => 'R_SsdiPayAllAdjustButCareBAmt', :display_rules => 'always', :order => 10, :web_calc_id => @R_SsdiPayAllAdjustButCareBAmt.id,    :group_id => @BobTesting.id)
WebNumericalResult.create!(:name => 'R_ActualSsdiPayNotEqualNoAdjust', :display_rules => 'always', :order => 11, :web_calc_id => @R_ActualSsdiPayNotEqualNoAdjust.id,    :group_id => @BobTesting.id)
WebNumericalResult.create!(:name => 'R_ActualSsdiPayNotEqualCareBAdjust', :display_rules => 'always', :order => 12, :web_calc_id => @R_ActualSsdiPayNotEqualCareBAdjust.id,    :group_id => @BobTesting.id)
WebNumericalResult.create!(:name => 'R_ActualSsdiPayNotEqualWcOrPbdAdjust', :display_rules => 'always', :order => 13, :web_calc_id => @R_ActualSsdiPayNotEqualWcOrPbdAdjust.id,    :group_id => @BobTesting.id)
WebNumericalResult.create!(:name => 'R_ActualSsdiPayNotEqualAllAdjust', :display_rules => 'always', :order => 14, :web_calc_id => @R_ActualSsdiPayNotEqualAllAdjust.id,    :group_id => @BobTesting.id)

@BobTestingSpace = WebNumericalResultsGroup.create!(:name => '.', :order => 121)
#WebNumericalResult.create!(:name => 'blank', :display_rules => 'always', :order => 1, :web_calc_id => @BobBlank.id,    :group_id => @BobTesting.id)

@BobTestingSpouseSSDI = WebNumericalResultsGroup.create!(:name => 'Testing Spouse SSDI', :order => 122)
WebNumericalResult.create!(:name => 'R_SpouseSgaAmt', :display_rules => 'always', :order => 1, :web_calc_id => @R_SpouseSgaAmt.id,    :group_id => @BobTestingSpouseSSDI.id)
WebNumericalResult.create!(:name => 'R_SpouseSsdiSgaExceeded', :display_rules => 'always', :order => 2, :web_calc_id => @R_SpouseSsdiSgaExceeded.id,    :group_id => @BobTestingSpouseSSDI.id)
WebNumericalResult.create!(:name => 'R_SpouseSsdiBenefitStops', :display_rules => 'always', :order => 3, :web_calc_id => @R_SpouseSsdiBenefitStops.id,    :group_id => @BobTestingSpouseSSDI.id)
WebNumericalResult.create!(:name => 'R_SpouseSsdiEseCeases', :display_rules => 'always', :order => 4, :web_calc_id => @R_SpouseSsdiEseCeases.id,    :group_id => @BobTestingSpouseSSDI.id)
WebNumericalResult.create!(:name => 'R_SpouseSsdiPayNoAdjustAmt', :display_rules => 'always', :order => 5, :web_calc_id => @R_SpouseSsdiPayNoAdjustAmt.id,    :group_id => @BobTestingSpouseSSDI.id)
WebNumericalResult.create!(:name => 'R_SpouseSsdiPayCareBAdjustAmt', :display_rules => 'always', :order => 6, :web_calc_id => @R_SpouseSsdiPayCareBAdjustAmt.id,    :group_id => @BobTestingSpouseSSDI.id)
WebNumericalResult.create!(:name => 'R_SpouseSsdiPayWcOrPdbAdjustAmt', :display_rules => 'always', :order => 7, :web_calc_id => @R_SpouseSsdiPayWcOrPdbAdjustAmt.id,    :group_id => @BobTestingSpouseSSDI.id)
WebNumericalResult.create!(:name => 'R_SpouseSsdiPayOverUnderAdjustAmt', :display_rules => 'always', :order => 8, :web_calc_id => @R_SpouseSsdiPayOverUnderAdjustAmt.id,    :group_id => @BobTestingSpouseSSDI.id)
WebNumericalResult.create!(:name => 'R_SpouseSsdiPayAllAdjustAmt', :display_rules => 'always', :order => 9, :web_calc_id => @R_SpouseSsdiPayAllAdjustAmt.id,    :group_id => @BobTestingSpouseSSDI.id)
WebNumericalResult.create!(:name => 'R_SpouseSsdiPayAllAdjustButCareBAmt', :display_rules => 'always', :order => 10, :web_calc_id => @R_SpouseSsdiPayAllAdjustButCareBAmt.id,    :group_id => @BobTestingSpouseSSDI.id)
WebNumericalResult.create!(:name => 'R_SpouseActualSsdiPayNotEqualNoAdjust', :display_rules => 'always', :order => 11, :web_calc_id => @R_SpouseActualSsdiPayNotEqualNoAdjust.id,    :group_id => @BobTestingSpouseSSDI.id)
WebNumericalResult.create!(:name => 'R_SpouseActualSsdiPayNotEqualCareBAdjust', :display_rules => 'always', :order => 12, :web_calc_id => @R_SpouseActualSsdiPayNotEqualCareBAdjust.id,    :group_id => @BobTestingSpouseSSDI.id)
WebNumericalResult.create!(:name => 'R_SpouseActualSsdiPayNotEqualWcOrPbdAdjust', :display_rules => 'always', :order => 13, :web_calc_id => @R_SpouseActualSsdiPayNotEqualWcOrPbdAdjust.id,    :group_id => @BobTestingSpouseSSDI.id)
WebNumericalResult.create!(:name => 'R_SpouseActualSsdiPayNotEqualAllAdjust', :display_rules => 'always', :order => 14, :web_calc_id => @R_SpouseActualSsdiPayNotEqualAllAdjust.id,    :group_id => @BobTestingSpouseSSDI.id)

@DetermineFederalSSICashBenefitAmount = WebNumericalResultsGroup.create!(:name => 'Determine the Federal SSI Cash Benefit Amount', :order => 122)
WebNumericalResult.create!(:name => 'R_SsdiForSsiCalcAmt', :display_rules => 'always', :order => 1, :web_calc_id => @R_SsdiForSsiCalcAmt.id,    :group_id => @DetermineFederalSSICashBenefitAmount.id)
WebNumericalResult.create!(:name => 'R_SpouseSsdiForSsiCalcAmt', :display_rules => 'always', :order => 2, :web_calc_id => @R_SpouseSsdiForSsiCalcAmt.id,    :group_id => @DetermineFederalSSICashBenefitAmount.id)
WebNumericalResult.create!(:name => 'R_SsiUnearnNoSpouseDeemAmt', :display_rules => 'always', :order => 3, :web_calc_id => @R_SsiUnearnNoSpouseDeemAmt.id,    :group_id => @DetermineFederalSSICashBenefitAmount.id)
WebNumericalResult.create!(:name => 'R_SsiUnearnSpouseDeemAmt', :display_rules => 'always', :order => 4, :web_calc_id => @R_SsiUnearnSpouseDeemAmt.id,    :group_id => @DetermineFederalSSICashBenefitAmount.id)
WebNumericalResult.create!(:name => 'R_SsiUnearnMinusInfreqAndNeedBasedNoSpouseDeemAmt', :display_rules => 'always', :order => 5, :web_calc_id => @R_SsiUnearnMinusInfreqAndNeedBasedNoSpouseDeemAmt.id,    :group_id => @DetermineFederalSSICashBenefitAmount.id)
WebNumericalResult.create!(:name => 'R_SsiUnearnMinusGenExcludeNoSpouseDeemAmt', :display_rules => 'always', :order => 6, :web_calc_id => @R_SsiUnearnMinusGenExcludeNoSpouseDeemAmt.id,    :group_id => @DetermineFederalSSICashBenefitAmount.id)
WebNumericalResult.create!(:name => 'R_UnearnForSsiCalcNoSpouseDeemAmt', :display_rules => 'always', :order => 7, :web_calc_id => @R_UnearnForSsiCalcNoSpouseDeemAmt.id,    :group_id => @DetermineFederalSSICashBenefitAmount.id)
WebNumericalResult.create!(:name => 'R_SsiUnusedGenExcludeNoSpouseDeemAmt', :display_rules => 'always', :order => 8, :web_calc_id => @R_SsiUnusedGenExcludeNoSpouseDeemAmt.id,    :group_id => @DetermineFederalSSICashBenefitAmount.id)
WebNumericalResult.create!(:name => 'R_SsiUnearnMinusInfreqAndNeedBasedSpouseDeemAmt', :display_rules => 'always', :order => 9, :web_calc_id => @R_SsiUnearnMinusInfreqAndNeedBasedSpouseDeemAmt.id,    :group_id => @DetermineFederalSSICashBenefitAmount.id)
WebNumericalResult.create!(:name => 'R_SsiUnearnMinusGenExcludeSpouseDeemAmt', :display_rules => 'always', :order => 10, :web_calc_id => @R_SsiUnearnMinusGenExcludeSpouseDeemAmt.id,    :group_id => @DetermineFederalSSICashBenefitAmount.id)
WebNumericalResult.create!(:name => 'R_UnearnForSsiCalcSpouseDeemAmt', :display_rules => 'always', :order => 11, :web_calc_id => @R_UnearnForSsiCalcSpouseDeemAmt.id,    :group_id => @DetermineFederalSSICashBenefitAmount.id)
WebNumericalResult.create!(:name => 'R_SeiePlusIrweAmt', :display_rules => 'always', :order => 12, :web_calc_id => @R_SeiePlusIrweAmt.id,    :group_id => @DetermineFederalSSICashBenefitAmount.id)
WebNumericalResult.create!(:name => 'R_SpouseSeiePlusIrweAmt', :display_rules => 'always', :order => 13, :web_calc_id => @R_SpouseSeiePlusIrweAmt.id,    :group_id => @DetermineFederalSSICashBenefitAmount.id)
WebNumericalResult.create!(:name => 'R_EarnMinusGenAndEarnExcludeNoSpouseDeemAmt', :display_rules => 'always', :order => 14, :web_calc_id => @R_EarnMinusGenAndEarnExcludeNoSpouseDeemAmt.id,    :group_id => @DetermineFederalSSICashBenefitAmount.id)
WebNumericalResult.create!(:name => 'R_EarnBeforeDivideNoSpouseDeemAmt', :display_rules => 'always', :order => 15, :web_calc_id => @R_EarnBeforeDivideNoSpouseDeemAmt.id,    :group_id => @DetermineFederalSSICashBenefitAmount.id)
WebNumericalResult.create!(:name => 'R_EarnAfterDivideNoSpouseDeemAmt', :display_rules => 'always', :order => 16, :web_calc_id => @R_EarnAfterDivideNoSpouseDeemAmt.id,    :group_id => @DetermineFederalSSICashBenefitAmount.id)
WebNumericalResult.create!(:name => 'R_EarnMinusGenAndEarnExcludeSpouseDeemAmt', :display_rules => 'always', :order => 17, :web_calc_id => @R_EarnMinusGenAndEarnExcludeSpouseDeemAmt.id,    :group_id => @DetermineFederalSSICashBenefitAmount.id)
WebNumericalResult.create!(:name => 'R_EarnBeforeDivideSpouseDeemAmt', :display_rules => 'always', :order => 18, :web_calc_id => @R_EarnBeforeDivideSpouseDeemAmt.id,    :group_id => @DetermineFederalSSICashBenefitAmount.id)
WebNumericalResult.create!(:name => 'R_EarnAfterDivideSpouseDeemAmt', :display_rules => 'always', :order => 19, :web_calc_id => @R_EarnAfterDivideSpouseDeemAmt.id,    :group_id => @DetermineFederalSSICashBenefitAmount.id)
WebNumericalResult.create!(:name => 'R_SgaExceededNotSsiElig', :display_rules => 'always', :order => 20, :web_calc_id => @R_SgaExceededNotSsiElig.id,    :group_id => @DetermineFederalSSICashBenefitAmount.id)
WebNumericalResult.create!(:name => 'R_TotalIncMinusBweNoSpouseDeemAmt', :display_rules => 'always', :order => 21, :web_calc_id => @R_TotalIncMinusBweNoSpouseDeemAmt.id,    :group_id => @DetermineFederalSSICashBenefitAmount.id)
WebNumericalResult.create!(:name => 'R_TotalIncMinusBweSpouseDeemAmt', :display_rules => 'always', :order => 22, :web_calc_id => @R_TotalIncMinusBweSpouseDeemAmt.id,    :group_id => @DetermineFederalSSICashBenefitAmount.id)
WebNumericalResult.create!(:name => 'R_TotalIncMinusBwePassNoSpouseDeemAmt', :display_rules => 'always', :order => 23, :web_calc_id => @R_TotalIncMinusBwePassNoSpouseDeemAmt.id,    :group_id => @DetermineFederalSSICashBenefitAmount.id)
WebNumericalResult.create!(:name => 'R_TotalIncMinusBwePassSpouseDeemAmt', :display_rules => 'always', :order => 24, :web_calc_id => @R_TotalIncMinusBwePassSpouseDeemAmt.id,    :group_id => @DetermineFederalSSICashBenefitAmount.id)
WebNumericalResult.create!(:name => 'R_FbrNoSpouseDeemAmt', :display_rules => 'always', :order => 25, :web_calc_id => @R_FbrNoSpouseDeemAmt.id,    :group_id => @DetermineFederalSSICashBenefitAmount.id)
WebNumericalResult.create!(:name => 'R_FbrSpouseDeemAmt', :display_rules => 'always', :order => 26, :web_calc_id => @R_FbrSpouseDeemAmt.id,    :group_id => @DetermineFederalSSICashBenefitAmount.id)
WebNumericalResult.create!(:name => 'R_SsiNoOveUnderAdjustNoSpouseDeemCalcAmt', :display_rules => 'always', :order => 27, :web_calc_id => @R_SsiNoOveUnderAdjustNoSpouseDeemCalcAmt.id,    :group_id => @DetermineFederalSSICashBenefitAmount.id)
WebNumericalResult.create!(:name => 'R_SsiNoOverUnderAdjustSpouseDeemCalcAmt', :display_rules => 'always', :order => 28, :web_calc_id => @R_SsiNoOverUnderAdjustSpouseDeemCalcAmt.id,    :group_id => @DetermineFederalSSICashBenefitAmount.id)
WebNumericalResult.create!(:name => 'R_SsiSpousalDeemCalcsUsed', :display_rules => 'always', :order => 29, :web_calc_id => @R_SsiSpousalDeemCalcsUsed.id,    :group_id => @DetermineFederalSSICashBenefitAmount.id)
WebNumericalResult.create!(:name => 'R_SsiNoOverUnderAdjustCalcAmt', :display_rules => 'always', :order => 30, :web_calc_id => @R_SsiNoOverUnderAdjustCalcAmt.id,    :group_id => @DetermineFederalSSICashBenefitAmount.id)
WebNumericalResult.create!(:name => 'R_SsiActualAmt', :display_rules => 'always', :order => 31, :web_calc_id => @R_SsiActualAmt.id,    :group_id => @DetermineFederalSSICashBenefitAmount.id)
WebNumericalResult.create!(:name => 'R_ActualSsiGreaterThanCalcSsiNoOverUnderAdjust', :display_rules => 'always', :order => 32, :web_calc_id => @R_ActualSsiGreaterThanCalcSsiNoOverUnderAdjust.id,    :group_id => @DetermineFederalSSICashBenefitAmount.id)
WebNumericalResult.create!(:name => 'R_ActualSsiLessThanCalcSsiNoOverUnderAdjust', :display_rules => 'always', :order => 33, :web_calc_id => @R_ActualSsiLessThanCalcSsiNoOverUnderAdjust.id,    :group_id => @DetermineFederalSSICashBenefitAmount.id)
WebNumericalResult.create!(:name => 'R_SsiUserOverUnderAdjustCalcAmt', :display_rules => 'always', :order => 34, :web_calc_id => @R_SsiUserOverUnderAdjustCalcAmt.id,    :group_id => @DetermineFederalSSICashBenefitAmount.id)
WebNumericalResult.create!(:name => 'R_SsiCoupleOverUnderAdjustCalcAmt', :display_rules => 'always', :order => 35, :web_calc_id => @R_SsiCoupleOverUnderAdjustCalcAmt.id,    :group_id => @DetermineFederalSSICashBenefitAmount.id)
WebNumericalResult.create!(:name => 'R_ActualSsiNotEqualCalcSsiAfterOverUnderAdjust', :display_rules => 'always', :order => 36, :web_calc_id => @R_ActualSsiNotEqualCalcSsiAfterOverUnderAdjust.id,    :group_id => @DetermineFederalSSICashBenefitAmount.id)
WebNumericalResult.create!(:name => 'R_CoupleActualSsiNotEqualCalcSsiAfterOverUnderAdjust', :display_rules => 'always', :order => 37, :web_calc_id => @R_CoupleActualSsiNotEqualCalcSsiAfterOverUnderAdjust.id,    :group_id => @DetermineFederalSSICashBenefitAmount.id)
#WebNumericalResult.create!(:name => '575R_', :display_rules => 'always', :order => 38, :web_calc_id => @Incomplete.id,    :group_id => @DetermineFederalSSICashBenefitAmount.id)
#WebNumericalResult.create!(:name => '765R_', :display_rules => 'always', :order => 39, :web_calc_id => @Incomplete.id,    :group_id => @DetermineFederalSSICashBenefitAmount.id)


#WebNumericalResult.create!(:name => 'x27', :display_rules => 'always', :order => 15, :web_calc_id => @x.id,    :group_id => @BobTesting.id)
#WebNumericalResult.create!(:name => 'x28', :display_rules => 'always', :order => 16, :web_calc_id => @x.id,    :group_id => @BobTesting.id)
#WebNumericalResult.create!(:name => 'x29', :display_rules => 'always', :order => 17, :web_calc_id => @x.id,    :group_id => @BobTesting.id)
#WebNumericalResult.create!(:name => 'x30', :display_rules => 'always', :order => 18, :web_calc_id => @x.id,    :group_id => @BobTesting.id)
#WebNumericalResult.create!(:name => 'x31', :display_rules => 'always', :order => 19, :web_calc_id => @x.id,    :group_id => @BobTesting.id)
#WebNumericalResult.create!(:name => 'x32', :display_rules => 'always', :order => 20, :web_calc_id => @x.id,    :group_id => @BobTesting.id)
#WebNumericalResult.create!(:name => 'x33', :display_rules => 'always', :order => 21, :web_calc_id => @x.id,    :group_id => @BobTesting.id)
#WebNumericalResult.create!(:name => 'x34', :display_rules => 'always', :order => 3, :web_calc_id => @x.id,    :group_id => @BobTesting.id)
#WebNumericalResult.create!(:name => 'x35', :display_rules => 'always', :order => 3, :web_calc_id => @x.id,    :group_id => @BobTesting.id)
#WebNumericalResult.create!(:name => 'x36', :display_rules => 'always', :order => 3, :web_calc_id => @x.id,    :group_id => @BobTesting.id)

