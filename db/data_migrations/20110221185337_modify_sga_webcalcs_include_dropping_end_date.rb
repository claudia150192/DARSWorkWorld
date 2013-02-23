class ModifySgaWebcalcsIncludeDroppingEndDate < ActiveRecord::Migration
  def self.up
  
  
    @R_SgaAmt  = WebCalc.find_by_name('R_SgaAmt')
    if @R_SgaAmt.blank? then
      @R_SgaAmt  = WebCalc.new(:name => 'R_SgaAmt')
    end
      
@R_SgaAmt.update_attribute(:operation, 
"Blind = manager.get_answer_by_question_name('Blind')
Disability = manager.get_answer_by_question_name('Disability')
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
  
  if Blind == 'Yes'
    return RateSgaBlindAmt
  elsif Disability == 'Yes'
    return RateSgaDisabledAmt
  else
    return 1000
  end
  
else
 if Blind == 'Yes'
   return 1640
 elsif Disability == 'Yes'
   return 1000
 else
   return 1000
  end
end
")
    
#RateSgaDisabledAmt    
 @RateSgaDisabledAmt  = WebCalc.find_by_name('RateSgaDisabledAmt')
 if @RateSgaDisabledAmt.blank? then
   @RateSgaDisabledAmt  = WebCalc.new(:name => 'RateSgaDisabledAmt')
 end
   
@RateSgaDisabledAmt.update_attribute(:operation, 
"Disability = manager.get_answer_by_question_name('Disability')
unless manager.get_answer_by_question_name('SitDate').blank? 
 SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
 rate = FederalRate.find(:first, :conditions => ['start_date <= ?', SitDate])
 if !(rate.blank?) then
   RateSgaDisabledAmt = rate.sga_disabled_amount
 else
     1000
 end
else
  1000
end
 ")   
  
  
  @RateSgaBlindAmt  = WebCalc.find_by_name('RateSgaBlindAmt')
   if @RateSgaBlindAmt.blank? then
     @RateSgaBlindAmt  = WebCalc.new(:name => 'RateSgaBlindAmt')
   end

  @RateSgaBlindAmt.update_attribute(:operation, 
  "Blind = manager.get_answer_by_question_name('Blind')
  unless manager.get_answer_by_question_name('SitDate').blank? 
   SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
   rate = FederalRate.find(:first, :conditions => ['start_date <= ?', SitDate])
   if !(rate.blank?) then
      RateSgaBlindAmt = rate.sga_blind_amount
   else 
     RateSgaBlindAmt = 1640
   end
  else
    return 1640
  end
   ")  
   
end

  def self.down
    @RateSgaBlindAmt  = WebCalc.find_by_name('RateSgaBlindAmt')
    if !(@RateSgaBlindAmt.blank?) then
      @RateSgaBlindAmt.update_attribute(:operation,
      "Blind = manager.get_answer_by_question_name('Blind')
      Disability = manager.get_answer_by_question_name('Disability')
      unless manager.get_answer_by_question_name('SitDate').blank? 
       SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
        rate = FederalRate.find(:first, :conditions => ['start_date <= ? AND end_date >= ?', SitDate, SitDate])

        if !(rate.blank?) then
          RateSgaBlindAmt = rate.sga_blind_amount
        else 
          RateSgaBlindAmt = 1640
        end
      else
        return 1640
      end
     ")
    end
    
    @RateSgaDisabledAmt  = WebCalc.find_by_name('RateSgaDisabledAmt')
    if !(@RateSgaDisabledAmt.blank?) then
      @RateSgaDisabledAmt.update_attribute(:operation,
      "Blind = manager.get_answer_by_question_name('Blind')
      Disability = manager.get_answer_by_question_name('Disability')
      unless manager.get_answer_by_question_name('SitDate').blank? 
       SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
       rate = FederalRate.find(:first, :conditions => ['start_date <= ? AND end_date >= ?', SitDate, SitDate])
       if !(rate.blank?) then
         RateSgaDisabledAmt = rate.sga_disabled_amount
        else
           1000.01
        end
      else
       1000.01
     end
     ")
    end
  
  
    @R_SgaAmt  = WebCalc.find_by_name('R_SgaAmt')
    if !(@R_SgaAmt.blank?) then
     @R_SgaAmt.update_attribute(:operation,
     "Blind = manager.get_answer_by_question_name('Blind')
     Disability = manager.get_answer_by_question_name('Disability')
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
      if Blind == 'Yes'
        return RateSgaBlindAmt
      elsif Disability == 'Yes'
        return RateSgaDisabledAmt
      else
        return 1000
      end

     else
       return 1000
     end
     ")
    end
  
 end
end
