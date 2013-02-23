require 'wwweb_session_manager'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)

# add an admin user if one doesn't exist
@ychaker = User.find_by_email('ychaker@o19s.com')
@ychaker = User.create!(:login => 'ychaker', :email => "ychaker@o19s.com", :password => "password", :password_confirmation => "password", :admin => true) if @ychaker.blank?

# add question groups
QuestionGroup.delete_all
@startup    =   QuestionGroup.create!(:name => 'Start-Up Information',  :order => 1)
@benefits   =   QuestionGroup.create!(:name => 'Benefits',              :order => 2)
@household  =   QuestionGroup.create!(:name => 'Household Info',        :order => 1)
@ssi        =   QuestionGroup.create!(:name => 'SSI',                   :order => 2)
@medicaid   =   QuestionGroup.create!(:name => 'Medicaid',              :order => 3)
@ssdi       =   QuestionGroup.create!(:name => 'SSDI',                  :order => 4)
@medicare   =   QuestionGroup.create!(:name => 'Medicare',              :order => 5)

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
@medicare.next_group    =   nil
@medicare.save!




# Create questions
Question.delete_all
@CurrentDate                              = Question.new(:display_rules => 'always', :default_answer => 'Current Date',      :reference_id =>   '',    :question_type => 'not_question', :answer_choices => '',                          :order => 1 ,    :group_id => @startup.id)
@BirthDate                                = Question.new(:display_rules => 'always', :default_answer => '01/01/1990',        :reference_id =>   '4',   :question_type => 'date_time',    :answer_choices => '',                          :order => 2 ,    :group_id => @startup.id)
@SitDate                                  = Question.new(:display_rules => 'always', :default_answer => 'Current Date',                  :reference_id =>   '5',   :question_type => 'date_time',    :answer_choices => '',                          :order => 3 ,    :group_id => @startup.id)
@State                                    = Question.new(:display_rules => 'always', :default_answer => 'Virginia',          :reference_id =>   '6',   :question_type => 'select',       :answer_choices => 'states',                    :order => 4 ,    :group_id => @startup.id)
@Blind                                    = Question.new(:display_rules => 'always', :default_answer => 'No',                :reference_id =>   '7',   :question_type => 'select',       :answer_choices => 'Yes, No',                   :order => 5 ,    :group_id => @startup.id)
@Disability                               = Question.new(:display_rules => 'always', :default_answer => 'Yes',               :reference_id =>   '8',   :question_type => 'select',       :answer_choices => 'Yes, No',                   :order => 6 ,    :group_id => @startup.id)
@SitName                                  = Question.new(:display_rules => 'always', :default_answer => 'Current Situation', :reference_id =>   '9',   :question_type => 'text_field',   :answer_choices => '',                          :order => 7 ,    :group_id => @startup.id)
@VACityCounty                             = Question.new(:display_rules => 'always', :default_answer => '',                  :reference_id => '12',  :question_type => 'select',       :answer_choices => 'counties and cities',          :order => 1 , :group_id => @household.id)
@LiveWithSpouse                           = Question.new(:display_rules => 'always', :default_answer => 'Yes',               :reference_id => '13',  :question_type => 'select',       :answer_choices => 'Yes, No',                   :order => 2 ,    :group_id => @household.id)
@SpouseBirthDate                          = Question.new(:display_rules => 'always', :default_answer => '01/01/1950',        :reference_id => '14',  :question_type => 'date_time',    :answer_choices => '',                          :order => 3 ,    :group_id => @household.id)
@SpouseBlind                              = Question.new(:display_rules => 'always', :default_answer => 'No',                :reference_id => '15',  :question_type => 'select',       :answer_choices => 'Yes, No',                   :order => 4 ,    :group_id => @household.id)
@SpouseDisability                         = Question.new(:display_rules => 'always', :default_answer => 'No',                :reference_id => '15',  :question_type => 'select',       :answer_choices => 'Yes, No',                   :order => 5 ,    :group_id => @household.id)
@LiveWithSpouseAndOwnParents              = Question.new(:display_rules => 'always', :default_answer => 'No',                :reference_id => '!7',  :question_type => 'select',       :answer_choices => 'Yes, No',                   :order => 6 ,    :group_id => @household.id)
@LiveWithSpouseAndSpouseParents           = Question.new(:display_rules => 'always', :default_answer => 'No',                :reference_id => '18',  :question_type => 'select',       :answer_choices => 'Yes, No',                   :order => 7 ,    :group_id => @household.id)
@LiveWithSpouseAndOthers                  = Question.new(:display_rules => 'always', :default_answer => 'No',                :reference_id => '19',  :question_type => 'select',       :answer_choices => 'Yes, No',                   :order => 8 ,    :group_id => @household.id)
@LiveWithSpouseAuxGrantFacility           = Question.new(:display_rules => 'always', :default_answer => 'No',                :reference_id => '20',  :question_type => 'select',       :answer_choices => 'Yes, No',                   :order => 9 ,    :group_id => @household.id)
@LiveWithSpouseCaidFacility               = Question.new(:display_rules => 'always', :default_answer => 'No',                :reference_id => '21',  :question_type => 'select',       :answer_choices => 'Yes, No',                   :order => 10 ,    :group_id => @household.id)
@Alone                                    = Question.new(:display_rules => 'always', :default_answer => 'Yes',               :reference_id => '22',  :question_type => 'select',       :answer_choices => 'Yes, No',                   :order => 11,    :group_id => @household.id)
@LiveWithParents                          = Question.new(:display_rules => 'always', :default_answer => 'Yes',               :reference_id => '23',  :question_type => 'select',       :answer_choices => 'Yes, No',                   :order => 12,    :group_id => @household.id)
@LiveWIthOthers                           = Question.new(:display_rules => 'always', :default_answer => 'Yes',               :reference_id => '24',  :question_type => 'select',       :answer_choices => 'Yes, No',                   :order => 13,    :group_id => @household.id)
@LiveInAuxGrantFacility                   = Question.new(:display_rules => 'always', :default_answer => 'No',                :reference_id => '25',  :question_type => 'select',       :answer_choices => 'Yes, No',                   :order => 14,    :group_id => @household.id)
@LiveInCaidFacility                       = Question.new(:display_rules => 'always', :default_answer => 'No',                :reference_id => '26',  :question_type => 'select',       :answer_choices => 'Yes, No',                   :order => 15,    :group_id => @household.id)
@LiveInCadFacilityWithSpouseInCommunity   = Question.new(:display_rules => 'always', :default_answer => 'No',                :reference_id => '27',  :question_type => 'select',       :answer_choices => 'Yes, No',                   :order => 16,    :group_id => @household.id)


@CurrentDate.name = 'CurrentDate'
@CurrentDate.text = 'Today\'s Date'
@CurrentDate.save!
@BirthDate.name = 'BirthDate'
@BirthDate.text = 'What\'s your birthdate?'
@BirthDate.save!
@SitDate.name = 'SitDate'
@SitDate.text = 'Enter date for which you want WW-Web to calculate results (the "situation date")'
@SitDate.validation_rules = "
answer = manager.get_answer_by_question_name(self.name)
unless answer.blank?
  date = Date.strptime(answer, '%m/%d/%Y') 
  date >= Date.strptime('01/01/2010', '%m/%d/%Y') 
else 
  false
end
"
@SitDate.validation_message = 'Situation date should not be earlier than 1/1/2010'
@SitDate.save!
@State.name = 'State'
@State.text = 'In what State do you live?'
@State.display_rules = "
unless manager.get_answer_by_question_name('SitDate').blank? || manager.get_answer_by_question_name('BirthDate').blank?
  SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
  BirthDate = Date.strptime(manager.get_answer_by_question_name('BirthDate'), '%m/%d/%Y')
  SitDate.year - BirthDate.year >= 15 && SitDate.year - BirthDate.year < 66
else
  false
end
"
@State.save!
@Blind.name = 'Blind'
@Blind.text = 'Are you legally blind according to SSA criteria?'
@Blind.display_rules = "
State = manager.get_answer_by_question_name('State')
State == 'Virginia'
"
@Blind.save!
@Disability.name = 'Disability'
@Disability.text = 'Do you have a disability according to SSA criteria?'
@Disability.display_rules = "
Blind = manager.get_answer_by_question_name('Blind')
Blind == 'No'
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
@VACityCounty.name = 'VACityCounty'
@VACityCounty.text = 'In what Virginia City or County do you live?'
@VACityCounty.display_rules = "
Blind = manager.get_answer_by_question_name('Blind')
Disability = manager.get_answer_by_question_name('Disability')
Blind == 'Yes' || Disability == 'Yes'
"
@VACityCounty.save!
@LiveWithSpouse.name = 'LiveWithSpouse'
@LiveWithSpouse.text = 'Are you married and living with your spouse?'
@LiveWithSpouse.display_rules = "
Blind = manager.get_answer_by_question_name('Blind')
Disability = manager.get_answer_by_question_name('Disability')
Blind == 'Yes' || Disability == 'Yes'
"
@LiveWithSpouse.save!
@SpouseBirthDate.name = 'SpouseBirthDate'
@SpouseBirthDate.text = 'What is your spouse\'s birthdate?'
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
SpouseBlind = manager.get_answer_by_question_name('SpouseBlind')
LiveWithSpouse = manager.get_answer_by_question_name('LiveWithSpouse') 
LiveWithSpouse == 'Yes' && SpouseBlind == 'No'
"
@SpouseDisability.save!
@LiveWithSpouseAndOwnParents.name = 'LiveWithSpouseAndOwnParents'
@LiveWithSpouseAndOwnParents.text = 'Do you and your spouse live with your parents?'
@LiveWithSpouseAndOwnParents.display_rules = "
unless manager.get_answer_by_question_name('SitDate').blank? || manager.get_answer_by_question_name('SpouseBirthDate').blank?
  SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
  SpouseBirthDate = Date.strptime(manager.get_answer_by_question_name('SpouseBirthDate'), '%m/%d/%Y')
  LiveWithSpouse = manager.get_answer_by_question_name('LiveWithSpouse')
  LiveWithSpouse == 'Yes' && (SitDate.year - SpouseBirthDate.year) < 18
else
  false
end
"
@LiveWithSpouseAndOwnParents.save!
@LiveWithSpouseAndSpouseParents.name = 'LiveWithSpouseAndSpouseParents'
@LiveWithSpouseAndSpouseParents.text = 'Do you and your spouse live with your spouse\'s parents?'
@LiveWithSpouseAndSpouseParents.display_rules = "
unless manager.get_answer_by_question_name('SitDate').blank? || manager.get_answer_by_question_name('SpouseBirthDate').blank?
  SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
  SpouseBirthDate = Date.strptime(manager.get_answer_by_question_name('SpouseBirthDate'), '%m/%d/%Y')
  LiveWithSpouse = manager.get_answer_by_question_name('LiveWithSpouse')
  LiveWithSpouseAndOwnParents = manager.get_answer_by_question_name('LiveWithSpouseAndOwnParents')
  LiveWithSpouse == 'Yes' && (SitDate.year - SpouseBirthDate.year) < 18 && LiveWithSpouseAndOwnParents != 'Yes'
else
  false
end
"
@LiveWithSpouseAndSpouseParents.save!
@LiveWithSpouseAndOthers.name = 'LiveWithSpouseAndOthers'
@LiveWithSpouseAndOthers.text = 'Do you and your spouse live with other adults?'
@LiveWithSpouseAndOthers.display_rules = "
LiveWithSpouse = manager.get_answer_by_question_name('LiveWithSpouse')
LiveWithSpouseAndOwnParents = manager.get_answer_by_question_name('LiveWithSpouseAndOwnParents')
LiveWithSpouseAndSpouseParents = manager.get_answer_by_question_name('LiveWithSpouseAndSpouseParents')
LiveWithSpouse == 'Yes' && LiveWithSpouseAndOwnParents != 'Yes' && LiveWithSpouseAndSpouseParents != 'Yes' 
"
@LiveWithSpouseAndOthers.save!
@LiveWithSpouseAuxGrantFacility.name = 'LiveWithSpouseAuxGrantFacility'
@LiveWithSpouseAuxGrantFacility.text = 'Do you and your spouse live in a facility or foster care supported by an Auxiliary Grant?'
@LiveWithSpouseAuxGrantFacility.display_rules = "
LiveWithSpouseAndOthers = manager.get_answer_by_question_name('LiveWithSpouseAndOthers')
State = manager.get_answer_by_question_name('State')
LiveWithSpouseAndOthers == 'Yes' && State == 'Virginia'
"
@LiveWithSpouseAuxGrantFacility.save!
@LiveWithSpouseCaidFacility.name = 'LiveWithSpouseCaidFacility'
@LiveWithSpouseCaidFacility.text = 'Do you and your spouse live in a facility supported by Medicaid?'
@LiveWithSpouseCaidFacility.display_rules =  "
LiveWithSpouseAndOthers = manager.get_answer_by_question_name('LiveWithSpouseAndOthers')
LiveWithSpouseAuxGrantFacility = manager.get_answer_by_question_name('LiveWithSpouseAuxGrantFacility')
LiveWithSpouseAndOthers == 'Yes' && LiveWithSpouseAuxGrantFacility != 'Yes'
"
@LiveWithSpouseCaidFacility.save!
@Alone.name = 'Alone'
@Alone.text = 'Do you live alone?'
@Alone.display_rules =  "
LiveWithSpouse = manager.get_answer_by_question_name('LiveWithSpouse')
LiveWithSpouse == 'No'
"
@Alone.save!
@LiveWithParents.name = 'LiveWithParents'
@LiveWithParents.text = 'Do you live with your parents?'
@LiveWithParents.display_rules =  "
unless manager.get_answer_by_question_name('SitDate').blank? || manager.get_answer_by_question_name('BirthDate').blank?
  SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
  BirthDate = Date.strptime(manager.get_answer_by_question_name('BirthDate'), '%m/%d/%Y')
  Alone = manager.get_answer_by_question_name('Alone')
  Alone == 'No' && (SitDate.year - BirthDate.year) < 18
else
  false
end
"
@LiveWithParents.save!
@LiveWIthOthers.name = 'LiveWIthOthers'
@LiveWIthOthers.text = 'Do you live with other adults?'
@LiveWIthOthers.display_rules =  "
LiveWithParents = manager.get_answer_by_question_name('LiveWithParents')
Alone = manager.get_answer_by_question_name('Alone')
Alone == 'No' && LiveWithParents != 'Yes'
"
@LiveWIthOthers.save!
@LiveInAuxGrantFacility.name = 'LiveInAuxGrantFacility'
@LiveInAuxGrantFacility.text = 'Do you in a facility or foster care supported by an Auxiliary Grant?'
@LiveInAuxGrantFacility.display_rules =  "
LiveWithOthers = manager.get_answer_by_question_name('LiveWithOthers')
State = manager.get_answer_by_question_name('State')
LiveWithOthers == 'Yes' && State == 'Virginia'
"
@LiveInAuxGrantFacility.save!
@LiveInCaidFacility.name = 'LiveInCaidFacility'
@LiveInCaidFacility.text = 'Do you live in a facility supported by Medicaid?'
@LiveInCaidFacility.display_rules =  "
LiveWithOthers = manager.get_answer_by_question_name('LiveWithOthers')
LiveInAuxGrantFacility = manager.get_answer_by_question_name('LiveInAuxGrantFacility')
LiveWithOthers == 'Yes' && LiveInAuxGrantFacility != 'Yes'
"
@LiveInCaidFacility.save!
@LiveInCadFacilityWithSpouseInCommunity.name= 'LiveInCadFacilityWithSpouseInCommunity'
@LiveInCadFacilityWithSpouseInCommunity.text = 'Do you have a spouse living in the community?'
@LiveInCadFacilityWithSpouseInCommunity.display_rules =  "
LiveInCaidFacility = manager.get_answer_by_question_name('LiveInCaidFacility')
LiveInCaidFacility == 'Yes'
"
@LiveInCadFacilityWithSpouseInCommunity.save!



# Create web tips
WebTip.delete_all
WebTip.create!( :identifier => 'CSI-1a',          :display_rules => 'always',   :group_id => @startup.id ,  :question_id => nil,     :text => 'You must first answer questions about your current situation.  Once you enter your birth date, you can select (click on or tab into) the answers to any of the other questions on this page if you want to change them from the default answers. ')
WebTip.create!( :identifier => 'CSI-1b',          :display_rules => 'always',   :group_id => @startup.id ,  :question_id => nil,     :text => 'You must first answer questions about your current situation.  You can select (click on or tab into) the answers to any of the other questions on this page if you want to change them from the default answers. ')
WebTip.create!( :identifier => 'CSA-BirthDate-1', :display_rules => 'always',   :group_id => nil,           :question_id => @BirthDate.id,  :text => 'The next time you start a case in WW-Web, the birth date in your last previously saved case will be the default birth date.')


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
                    :sga_disabled_amount => 980.00,
                    :sga_blind_amount => 1640.00,
                    :gen_exclude_amount => 20.00,
                    :earned_inc_disregard_amount => 65.00,
                    :seie_max_monthly => 1640.00,
                    :seie_max_year => 6600.00,
                    :care_b_premium => 96.40,
                    :ssi_resource_limit => 2000.00,
                    :ssi_resource_limit_married => 3000.00
)


# Create web calcs
WebCalc.delete_all
@RAge     = WebCalc.new(:name => 'RAge')
@RSgaAmt  = WebCalc.new(:name => 'RSgaAmt')

@RAge.operation = "
unless manager.get_answer_by_question_name('SitDate').blank? || manager.get_answer_by_question_name('BirthDate').blank?
  SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
  BirthDate = Date.strptime(manager.get_answer_by_question_name('BirthDate'), '%m/%d/%Y')
  SitDate.year - BirthDate.year
else 
  return 0
end
"
@RAge.save!
@RSgaAmt.operation = "
Blind = manager.get_answer_by_question_name('Blind')
Disability = manager.get_answer_by_question_name('Disability')
RateSgaBlindAmt = FederalRate.first.sga_blind_amount
RateSgaDisabledAmt = FederalRate.first.sga_disabled_amount
if Blind == 'Yes'
  return RateSgaBlindAmt
elsif Disability == 'Yes'
  return RateSgaDisabledAmt
else
  return 0
end
"
@RSgaAmt.save!


# Creat web numerical result group
WebNumericalResultsGroup.delete_all
@test = WebNumericalResultsGroup.create!(:name => 'test', :order => 1)

# Create web numerical 
WebNumericalResult.delete_all
WebNumericalResult.create!(:name => 'Situation Age', :display_rules => 'always', :order => 1, :web_calc_id => @RAge.id,    :group_id => @test.id)
WebNumericalResult.create!(:name => 'Sga Amount',    :display_rules => 'always', :order => 2, :web_calc_id => @RSgaAmt.id, :group_id => @test.id)











