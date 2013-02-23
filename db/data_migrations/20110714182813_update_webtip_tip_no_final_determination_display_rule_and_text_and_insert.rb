class UpdateWebtipTipNoFinalDeterminationDisplayRuleAndTextAndInsert < ActiveRecord::Migration
  def self.up
    
    require 'wwweb_session_manager'  
     
     #36 37	170	Even if you are receiving SSI cash benefits, if you have not received a letter from SSA saying that you are eligible for SSI, then earning more than SGA  (~RateSgaDisabledAmt~) could cause SSA to cancel your eligibility for SSI.  Contact your SSA claims representative to find out if you can earn SGA without losing your eligibility.	SSI	3.00	Tip_NoFinalDetermination	IF SsiGet = YES AND Blind = NO AND SsiGetFinalDetermination <> YES		no		19.00
          
     @Tip_NoFinalDetermination = WebTip.find(:first, :conditions => ['identifier = ?',  'Tip_NoFinalDetermination']) 
    #@Tip_NoFinalDetermination = WebTip.find_by_name('Tip_NoFinalDetermination')
    @Tip_NoFinalDetermination.update_attribute(:text, "Even if you are receiving SSI cash benefits, if you have not received a letter from SSA saying that you are eligible for SSI, then earning more than SGA (~) could cause SSA to cancel your eligibility for SSI.  Contact your SSA claims representative to find out if you can earn SGA without losing your eligibility.") 
   
  #@seieGroup = QuestionGroup.find(:first, :conditions => ['name = ?', 'Student Earned Income Exclusion (SEIE)'])
  #@Tip_NoFinalDetermination.update_attribute(:group_id, @seieGroup.id) 

    #IIF SsiGet = YES AND Blind = NO AND SsiGetFinalDetermination <> YES
    @Tip_NoFinalDetermination.update_attribute(:display_rules, "
    SsiGet = manager.get_answer_by_question_name('SsiGet')
    Blind = manager.get_answer_by_question_name('Blind')
    SsiGetFinalDetermination = manager.get_answer_by_question_name('SsiGetFinalDetermination')
    if SsiGet == 'Yes' && Blind  == 'No' && SsiGetFinalDetermination != 'Yes' then 
      true
    else
      false
    end    
    ")

   @RateSgaDisabledAmt  = WebCalc.find_by_name('RateSgaDisabledAmt')


   @Insert2 = WebTipInsert.find(:first, :conditions => ['web_tip_id = ? AND insert_number = ?',  @Tip_NoFinalDetermination.id, 1])
   if @Insert2.blank? then
      @Insert2  = WebTipInsert.new(:web_tip_id => @Tip_NoFinalDetermination.id, :insert_number => '1', :webcalc_id_to_insert => @RateSgaDisabledAmt.id, :insert_marker => "~", :insert_type => 'currency')
      @Insert2.save!
  else
    @Insert2.update_attribute(:web_tip_id, @Tip_NoFinalDetermination.id)
    @Insert2.update_attribute(:insert_number, '1')
    @Insert2.update_attribute(:webcalc_id_to_insert, @RateSgaDisabledAmt.id)
    @Insert2.update_attribute(:insert_marker, '~')
    @Insert2.update_attribute(:insert_type, 'currency')
   end
  end

  def self.down
  end
end
