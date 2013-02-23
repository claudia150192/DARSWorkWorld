class CreateRSpouse1619bIneligThresholdWebcalc < ActiveRecord::Migration
  def self.up
    
       require 'wwweb_session_manager'  

      # 331	IF (SpouseIndividThreshold = NO AND SpouseSsiOrCaidEarnAmt > VA_RateSsiCaidMonthlyThresholdAmt) OR (SpouseIndividThreshold = YES AND (SpouseSsiOrCaidEarnAmt * 12) > SpouseAnnualIndividThresholdAmt), 
      #THEN RSpouse1619bIneligThreshold = TRUE, ELSE FALSE	RSpouse1619bIneligThreshold
      # workbook is lacking here needs to reference blind amounts.  Other changes will be needed if new states are added
      @RSpouse1619bIneligThreshold  = WebCalc.new(:name => 'RSpouse1619bIneligThreshold')
      @RSpouse1619bIneligThreshold.operation = "
        SpouseIndividThreshold = manager.get_answer_by_question_name('SpouseIndividThreshold')
        SpouseAnnualIndividThresholdAmt = manager.get_answer_by_question_name('SpouseAnnualIndividThresholdAmt')
        SpouseSsiOrCaidEarnAmt = manager.get_answer_by_question_name('SpouseSsiOrCaidEarnAmt')
        SpouseBlind = manager.get_answer_by_question_name('SpouseBlind')      
        unless manager.get_answer_by_question_name('SitDate').blank? 
            SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
            nonBlindRate = MedicaidAnnualThreshold.find(:last, :conditions => ['start_date <= ?', SitDate])
            BlindRate = MedicaidAnnualBlindThreshold.find(:last, :conditions => ['start_date <= ?', SitDate])
            if SpouseBlind != 'Yes' then
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

        if SpouseIndividThreshold == 'Yes' then
          ThresholdRate = SpouseAnnualIndividThresholdAmt.to_f
        end
        if (SpouseSsiOrCaidEarnAmt.to_f * 12)  > ThresholdRate then
          true
        else
          false
        end 
       "
       @RSpouse1619bIneligThreshold.save!
    end
 
  def self.down
  end
end
