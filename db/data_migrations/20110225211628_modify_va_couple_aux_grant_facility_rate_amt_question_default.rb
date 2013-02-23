class ModifyVaCoupleAuxGrantFacilityRateAmtQuestionDefault < ActiveRecord::Migration
  def self.up
    @question = Question.find_by_name('VA_CoupleAuxGrantFacilityRateAmt')
    @question.update_attribute(:default_answer,
   "expression= 
    SsdiEarnAmt = manager.get_answer_by_question_name('SsdiEarnAmt')
    RateVaMaxAuxiliaryGrantCouplePd8 = WebCalc.find_by_name('RateVaMaxAuxiliaryGrantCouplePd8')
    RateVaMaxAuxiliaryGrantCouplePd8 = Float(RateVaMaxAuxiliaryGrantCouplePd8.calculate manager)
    RateVaMaxAuxiliaryGrantCoupleElsewhere = WebCalc.find_by_name('RateVaMaxAuxiliaryGrantCoupleElsewhere')
    RateVaMaxAuxiliaryGrantCoupleElsewhere = Float(RateVaMaxAuxiliaryGrantCoupleElsewhere.calculate manager)
    VA_CityCounty = manager.get_answer_by_question_name('VA_CityCounty')
    if VA_CityCounty == 'Arlington County' || VA_CityCounty == 'Louden County' || VA_CityCounty == 'Prince William County' || VA_CityCounty == 'Fairfax County' || VA_CityCounty == 'Alexandria County' then
     answer = RateVaMaxAuxiliaryGrantCouplePd8
    else
     answer = RateVaMaxAuxiliaryGrantCoupleElsewhere
    end
  ") unless @question.blank?
  end

  def self.down
    @question = Question.find_by_name('VA_CoupleAuxGrantFacilityRateAmt')
    @question.update_attribute(:default_answer,
   "expression= 
    SsdiEarnAmt = manager.get_answer_by_question_name('SsdiEarnAmt')
    unless manager.get_answer_by_question_name('SitDate').blank? 
     SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
     rate = VaMaxAuxiliaryGrantFacilityRate.find(:last, :conditions => ['start_date <= ?', SitDate])
     RatePd_8_amount = 1279
     RateElsewhere_amount = 1112
     RatePd_8_amount = rate.couple_pd_8_amount unless rate.blank?
     RateElsewhere_amount = rate.couple_elsewhere_amount unless rate.blank?
     VA_CityCounty = manager.get_answer_by_question_name('VA_CityCounty')
     if VA_CityCounty == 'Arlington County' || VA_CityCounty == 'Louden County' || VA_CityCounty == 'Prince William County' || VA_CityCounty == 'Fairfax County' || VA_CityCounty == 'Alexandria County' then
       answer = RatePd_8_amount
     else
      answer = RateElsewhere_amount
     end
    else
      answer = 1112
    end
") unless @question.blank?
  end
end