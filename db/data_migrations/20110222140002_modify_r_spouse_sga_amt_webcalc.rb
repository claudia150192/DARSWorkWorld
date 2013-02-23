class ModifyRSpouseSgaAmtWebcalc < ActiveRecord::Migration
  def self.up
    @R_SpouseSgaAmt  = WebCalc.find_by_name('R_SpouseSgaAmt')
    if @R_SpouseSgaAmt.blank? then
      @R_SpouseSgaAmt  = WebCalc.new(:name => 'R_SpouseSgaAmt')
    end
      
@R_SpouseSgaAmt.update_attribute(:operation, 
"SpouseBlind = manager.get_answer_by_question_name('SpouseBlind')
SpouseDisability = manager.get_answer_by_question_name('SpouseDisability')
unless manager.get_answer_by_question_name('SitDate').blank? 
 SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
 rate = FederalRate.find(:first, :conditions => ['start_date <= ?', SitDate])
 if !(rate.blank?) then 
   RateSgaBlindAmt = rate.sga_blind_amount
   RateSgaDisabledAmt = rate.sga_disabled_amount
 else 
   RateSgaBlindAmt = 1640
   RateSgaDisabledAmt = 1000
 end
 if SpouseBlind == 'Yes' then
   return RateSgaBlindAmt
 elsif SpouseDisability == 'Yes'
   return RateSgaDisabledAmt
 else
   return 1000
 end
 
else
  if SpouseBlind == 'Yes'
     return 1640
  else
     return 1000 
   end
end
")

end

  def self.down
    @R_SpouseSgaAmt  = WebCalc.find_by_name('R_SpouseSgaAmt')
    if !(@R_SpouseSgaAmt.blank?) then
     @R_SpouseSgaAmt.update_attribute(:operation,
     "SpouseBlind = manager.get_answer_by_question_name('SpouseBlind')
     SpouseDisability = manager.get_answer_by_question_name('SpouseDisability')
     unless manager.get_answer_by_question_name('SitDate').blank? 
      SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
      rate = FederalRate.find(:first, :conditions => ['start_date <= ? AND end_date >= ?', SitDate, SitDate])
      if !(rate.blank?) then 
        RateSgaBlindAmt = rate.sga_blind_amount
        RateSgaDisabledAmt = rate.sga_disabled_amount
      else 
        RateSgaBlindAmt = 1640
        RateSgaDisabledAmt = 1000
      end
      if SpouseBlind == 'Yes'
        return RateSgaBlindAmt
      elsif SpouseDisability == 'Yes'
        return RateSgaDisabledAmt
      else
        return 0
      end

     else
       return 1000
     end
     ")
    end
    
  end
end
