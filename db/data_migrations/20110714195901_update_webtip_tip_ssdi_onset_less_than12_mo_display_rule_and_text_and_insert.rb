class UpdateWebtipTipSsdiOnsetLessThan12MoDisplayRuleAndTextAndInsert < ActiveRecord::Migration
  def self.up
    require 'wwweb_session_manager'  
     
     #37	200	Even if you are receiving SSDI cash benefits, SSA may cancel your eligibility if you earn more than SGA (~RateSgaDisabledAmt~) before 12 months have passed since the onset date of your disability.  SSA says what date is your onset date.  Contact your SSA claims representative to find out if you can earn SGA without losing your eligibility.	SSDI	1.00	
     #Tip_Ssdi_OnsetLessThan12Mo	IF SsdiGet = YES AND Blind = NO AND SsdiGet12MonthsSinceOnset <> YES		no		22.00
               
    @Tip_Ssdi_OnsetLessThan12Mo = WebTip.find(:first, :conditions => ['identifier = ?',  'Tip_Ssdi_OnsetLessThan12Mo']) 
    @Tip_Ssdi_OnsetLessThan12Mo.update_attribute(:text, "Even if you are receiving SSDI cash benefits, SSA may cancel your eligibility if you earn more than SGA (~) before 12 months have passed since the onset date of your disability.  SSA says what date is your onset date.  Contact your SSA claims representative to find out if you can earn SGA without losing your eligibility") 
   
     #IF SsdiGet = YES AND Blind = NO AND SsdiGet12MonthsSinceOnset <> YES
    @Tip_Ssdi_OnsetLessThan12Mo.update_attribute(:display_rules, "
    SsdiGet = manager.get_answer_by_question_name('SsdiGet')
    Blind = manager.get_answer_by_question_name('Blind')
    SsdiGet12MonthsSinceOnset = manager.get_answer_by_question_name('SsdiGet12MonthsSinceOnset')
    if SsdiGet == 'Yes' && Blind  == 'No' && SsdiGet12MonthsSinceOnset != 'Yes' then 
      true
    else
      false
    end    
    ")

   @RateSgaDisabledAmt  = WebCalc.find_by_name('RateSgaDisabledAmt')


   @Insert2 = WebTipInsert.find(:first, :conditions => ['web_tip_id = ? AND insert_number = ?',  @Tip_Ssdi_OnsetLessThan12Mo.id, 1])
   if @Insert2.blank? then
      @Insert2  = WebTipInsert.new(:web_tip_id => @Tip_Ssdi_OnsetLessThan12Mo.id, :insert_number => '1', :webcalc_id_to_insert => @RateSgaDisabledAmt.id, :insert_marker => "~", :insert_type => 'currency')
      @Insert2.save!
  else
    @Insert2.update_attribute(:web_tip_id, @Tip_Ssdi_OnsetLessThan12Mo.id)
    @Insert2.update_attribute(:insert_number, '1')
    @Insert2.update_attribute(:webcalc_id_to_insert, @RateSgaDisabledAmt.id)
    @Insert2.update_attribute(:insert_marker, '~')
    @Insert2.update_attribute(:insert_type, 'currency')
   end
  end

  def self.down
  end
end
