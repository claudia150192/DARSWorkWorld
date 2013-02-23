class ModifyVaAuxGrantFacilityRateAmtQuestionDefault < ActiveRecord::Migration
  def self.up
    @question = Question.find_by_name('VA_AuxGrantFacilityRateAmt')
    @question.update_attribute(:default_answer,
   "expression= 
    SsdiEarnAmt = manager.get_answer_by_question_name('SsdiEarnAmt')
    RateVaMaxAuxiliaryGrantPd8 = WebCalc.find_by_name('RateVaMaxAuxiliaryGrantPd8')
    RateVaMaxAuxiliaryGrantPd8 = Float(RateVaMaxAuxiliaryGrantPd8.calculate manager)
    RateVaMaxAuxiliaryGrantElsewhere = WebCalc.find_by_name('RateVaMaxAuxiliaryGrantElsewhere')
    RateVaMaxAuxiliaryGrantElsewhere = Float(RateVaMaxAuxiliaryGrantElsewhere.calculate manager)
    RatePd_8_amount = RateVaMaxAuxiliaryGrantPd8
    RateElsewhere_amount = RateVaMaxAuxiliaryGrantElsewhere
    VA_CityCounty = manager.get_answer_by_question_name('VA_CityCounty')
    if VA_CityCounty == 'Arlington County' || VA_CityCounty == 'Louden County' || VA_CityCounty == 'Prince William County' || VA_CityCounty == 'Fairfax County' || VA_CityCounty == 'Alexandria County' then
     answer = RatePd_8_amount
    else
      answer = RateElsewhere_amount
    end
  ") unless @question.blank?
  end

  def self.down
    @question = Question.find_by_name('VA_AuxGrantFacilityRateAmt')
    @question.update_attribute(:default_answer,
   " expression= 
    SsdiEarnAmt = manager.get_answer_by_question_name('SsdiEarnAmt')
    unless manager.get_answer_by_question_name('SitDate').blank? 
     SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
     rate = VaMaxAuxiliaryGrantFacilityRate.find(:last, :conditions => ['start_date <= ?', SitDate])
     RatePd_8_amount = rate.pd_8_amount
     RateElsewhere_amount = rate.elsewhere_amount
     VA_CityCounty = manager.get_answer_by_question_name('VA_CityCounty')
     if VA_CityCounty == 'Arlington County' || VA_CityCounty == 'Louden County' || VA_CityCounty == 'Prince William County' || VA_CityCounty == 'Fairfax County' || VA_CityCounty == 'Alexandria County' then
       answer = RatePd_8_amount
     else
      answer = RateElsewhere_amount
     end
    else
      answer = 438
    end
   
  ") unless @question.blank?
    
  end
end