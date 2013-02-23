class ModifyRSsiIndividThresholdWebcalc < ActiveRecord::Migration
  def self.up
    @RSsiIndividThreshold  = WebCalc.find_by_name('RSsiIndividThreshold')
    if @RSsiIndividThreshold.blank? then
      @RSsiIndividThreshold  = WebCalc.new(:name => 'RSsiIndividThreshold')
    end
    
@RSsiIndividThreshold.update_attribute(:operation, 
"Blind = manager.get_answer_by_question_name('Blind')
Disability = manager.get_answer_by_question_name('Disability')
State = manager.get_answer_by_question_name('State')
unless manager.get_answer_by_question_name('SitDate').blank? 
  SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
 
  if Blind == 'Yes' then
      rate = MedicaidAnnualBlindThreshold.find(:last, :conditions => ['start_date <= ?', SitDate])
  else
    rate = MedicaidAnnualThreshold.find(:last, :conditions => ['start_date <= ?', SitDate])
  end

  if !(rate.blank?) && State == 'Virginia'
     return  ((rate.virginia).to_f)/12
  elsif !(rate.blank?) && State == 'Oklahoma'
    return  ((rate.oklahoma).to_f)/12
  else 
    return (32545/12)
  end
 else
  return (32545/12)
 end
")
  end

  def self.down
    @RSsiIndividThreshold  = WebCalc.find_by_name('R_SpouseSgaAmt')
    if !(@RSsiIndividThreshold.blank?) then
     @RSsiIndividThreshold.update_attribute(:operation,
     "Blind = manager.get_answer_by_question_name('Blind')
     Disability = manager.get_answer_by_question_name('Disability')
     unless manager.get_answer_by_question_name('SitDate').blank? 
       SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
       Blind = manager.get_answer_by_question_name('Blind')

       if Blind == 'Yes' then
           rate = MedicaidAnnualBlindThreshold.find(:first, :conditions => ['start_date <= ? AND end_date >= ?', SitDate, SitDate])
       else
         rate = MedicaidAnnualThreshold.find(:first, :conditions => ['start_date <= ? AND end_date >= ?', SitDate, SitDate])
       end

       if !(rate.blank?)
          return  ((rate.virginia).to_f)/12
       else 
         return (30600/12)
       end
      else
       return (30600/12)
      end
     ")
    end
  end
end
