class CreateR1619bIneligThresholdWebcalc < ActiveRecord::Migration
  def self.up
    
     require 'wwweb_session_manager'  
    
    #329	IF (SsiIndividThreshold = NO AND SsiOrCaidEarnAmt > VA_RateSsiCaidMonthlyThresholdAmt) OR (SsiIndividThreshold = YES AND (SsiOrCaidEarnAmt * 12) > SsiAnnualIndividThresholdAmt), THEN R1619bIneligThreshold = TRUE, ELSE FALSE	R1619bIneligThreshold
    # workbook is lacking here needs to reference blind amounts.  Other changes will be needed if new states are added
    @R1619bIneligThreshold  = WebCalc.new(:name => 'R1619bIneligThreshold')
    @R1619bIneligThreshold.operation = "
      SsiIndividThreshold = manager.get_answer_by_question_name('SsiIndividThreshold')
      SsiAnnualIndividThresholdAmt = manager.get_answer_by_question_name('SsiAnnualIndividThresholdAmt')
      SsiOrCaidEarnAmt = manager.get_answer_by_question_name('SsiOrCaidEarnAmt')
      Blind = manager.get_answer_by_question_name('Blind')      
      unless manager.get_answer_by_question_name('SitDate').blank? 
          SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
          nonBlindRate = MedicaidAnnualThreshold.find(:last, :conditions => ['start_date <= ?', SitDate])
          BlindRate = MedicaidAnnualBlindThreshold.find(:last, :conditions => ['start_date <= ?', SitDate])
          if Blind != 'Yes' then
             if !(nonBlindRate.blank?) then
                ThresholdRate = nonBlindRate.virginia
             else
               ThresholdRate = 32545.01
             end 
          else
             if !(BlindRate.blank?) then
                ThresholdRate = BlindRate.virginia
            else
              ThresholdRate = 32545.01
            end
          
          end
      else
         ThresholdRate =  32545.01
      end
      
      if SsiIndividThreshold == 'Yes' then
        ThresholdRate = SsiAnnualIndividThresholdAmt.to_f
      end
      if (SsiOrCaidEarnAmt.to_f * 12)  > ThresholdRate then
        true
      else
        false
      end 
     "
     @R1619bIneligThreshold.save!
  end

  def self.down
  end
end
