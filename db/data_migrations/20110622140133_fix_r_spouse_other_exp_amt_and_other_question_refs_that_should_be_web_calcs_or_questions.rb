class FixRSpouseOtherExpAmtAndOtherQuestionRefsThatShouldBeWebCalcsOrQuestions < ActiveRecord::Migration
  def self.up
    #RTrialWorkAndGrace
    
    
         require 'wwweb_session_manager'  

     @RTrialWorkAndGrace = WebCalc.find_by_name('RTrialWorkAndGrace')
     if @RTrialWorkAndGrace.blank? then
       @RTrialWorkAndGrace  = WebCalc.new(:name => 'RTrialWorkAndGrace')
     end


     #290	Trial Work & Grace Periods	RTWP 	RTWPNumRHide
     #TwpComplete SsdiGet
     @RTrialWorkAndGrace.operation = "
     SsdiGet = manager.get_answer_by_question_name('SsdiGet')
     if SsdiGet == 'No' ||  manager.get_answer_by_question_name('TwpComplete').blank? then
       'No'
     else
       'Yes'
     end
     "
     @RTrialWorkAndGrace.save!

    
    #RSpouseOtherExpAmt
    @RSpouseOtherExpAmt = WebCalc.find_by_name('RSpouseOtherExpAmt')
    if @RSpouseOtherExpAmt.blank? then
      @RSpouseOtherExpAmt  = WebCalc.new(:name => 'RSpouseOtherExpAmt')
    end

    @RSpouseOtherExpAmt.operation = "
    RSpouseOtherExpAmt = manager.get_answer_by_question_name('SpouseOtherExpAmt')
    if RSpouseOtherExpAmt != nil then
      Float(RSpouseOtherExpAmt)
    else
      return 0
    end
    "
    @RSpouseOtherExpAmt.save!
      
  end

  def self.down
  end
end
