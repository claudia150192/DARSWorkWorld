class UpdateWebtipTipSsiOnsetLessThan12MoAndTextAndInsert < ActiveRecord::Migration
  def self.up
    require 'wwweb_session_manager'  
     
     #36 37	180	Even if you have received a letter from SSA saying that you are eligible for SSI, SSA may cancel your eligibility if you earn more than SGA (~RateSgaDisabledAmt~) before 12 months have passed since the onset date of your disability.  SSA says what date is your onset date.  Contact your SSA claims representative to find out if you can earn SGA without losing your eligibility.	SSI	4.00	
     #Tip_Ssi_OnsetLessThan12Mo	IF SsiGetFinalDetermination = YES AND Blind =NO AND SsiGet12MonthsSinceOnset <> YES		no		20.00
          
     @Tip_Ssi_OnsetLessThan12Mo = WebTip.find(:first, :conditions => ['identifier = ?',  'Tip_Ssi_OnsetLessThan12Mo']) 
    #@Tip_Ssi_OnsetLessThan12Mo = WebTip.find_by_name('Tip_Ssi_OnsetLessThan12Mo')
    @Tip_Ssi_OnsetLessThan12Mo.update_attribute(:text, "Even if you have received a letter from SSA saying that you are eligible for SSI, SSA may cancel your eligibility if you earn more than SGA (~) before 12 months have passed since the onset date of your disability.  SSA says what date is your onset date.  Contact your SSA claims representative to find out if you can earn SGA without losing your eligibility.") 
   
  #@seieGroup = QuestionGroup.find(:first, :conditions => ['name = ?', 'Student Earned Income Exclusion (SEIE)'])
  #@Tip_Ssi_OnsetLessThan12Mo.update_attribute(:group_id, @seieGroup.id) 

    #IF SsiGetFinalDetermination = YES AND Blind =NO AND SsiGet12MonthsSinceOnset <> YES
    
    @Tip_Ssi_OnsetLessThan12Mo.update_attribute(:display_rules, "
    SsiGet = manager.get_answer_by_question_name('SsiGet')
    Blind = manager.get_answer_by_question_name('Blind')
    SsiGetFinalDetermination = manager.get_answer_by_question_name('SsiGetFinalDetermination')
    SsiGet12MonthsSinceOnset = manager.get_answer_by_question_name('SsiGet12MonthsSinceOnset')
    if SsiGet == 'Yes' && SsiGetFinalDetermination == 'Yes' && Blind  == 'No' && SsiGet12MonthsSinceOnset != 'Yes' then 
      true
    else
      false
    end    
    ")

   @RateSgaDisabledAmt  = WebCalc.find_by_name('RateSgaDisabledAmt')


   @Insert2 = WebTipInsert.find(:first, :conditions => ['web_tip_id = ? AND insert_number = ?',  @Tip_Ssi_OnsetLessThan12Mo.id, 1])
   if @Insert2.blank? then
      @Insert2  = WebTipInsert.new(:web_tip_id => @Tip_Ssi_OnsetLessThan12Mo.id, :insert_number => '1', :webcalc_id_to_insert => @RateSgaDisabledAmt.id, :insert_marker => "~", :insert_type => 'currency')
      @Insert2.save!
  else
    @Insert2.update_attribute(:web_tip_id, @Tip_Ssi_OnsetLessThan12Mo.id)
    @Insert2.update_attribute(:insert_number, '1')
    @Insert2.update_attribute(:webcalc_id_to_insert, @RateSgaDisabledAmt.id)
    @Insert2.update_attribute(:insert_marker, '~')
    @Insert2.update_attribute(:insert_type, 'currency')
   end
  end

  def self.down
  end
end
