class Add1619bEligibilityResourceWebcalcsToNumericResults < ActiveRecord::Migration
  def self.up
  #to be added
   # RSsiIneligUnearn
   # RCaidIneligUnearn
   # RSpouseCaidIneligUnearn
   # RSsiResourceLimitExceed
   # RCaidResourceLimitExceed
   # R1619bIneligUnearnOrResources
   # R1619bIneligThreshold
   # RSpouse1619bIneligThreshold
   # R1619bElig
   # RSpouse1619bElig
   # RLoseSSIFinancial
   
   require 'wwweb_session_manager'  
   
    @BobWebSsiWiCalcSheetDisplay = WebNumericalResultsGroup.find_by_name('Testing WebSsiWiCalc variables') 
    
     @Id = WebCalc.find_by_name('RSsiIneligUnearn') 
      @RSsiIneligUnearn = WebNumericalResult.find_by_name('RSsiIneligUnearn') 
      @RSsiIneligUnearn.delete unless @RSsiIneligUnearn.blank?
      @RSsiIneligUnearn = WebNumericalResult.create!(:name => 'RSsiIneligUnearn', :text => 'Start of Resources: RSsiIneligUnearn',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
      RShowWorkVar = (RShowWorkVar.calculate manager)
      if RShowWorkVar then
        true
      else
       false
      end", 
      :order => 100, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)

   @Id = WebCalc.find_by_name('RCaidIneligUnearn') 
    @RCaidIneligUnearn = WebNumericalResult.find_by_name('RCaidIneligUnearn') 
    @RCaidIneligUnearn.delete unless @RCaidIneligUnearn.blank?
    @RCaidIneligUnearn = WebNumericalResult.create!(:name => 'RCaidIneligUnearn', :text => 'RCaidIneligUnearn',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
    RShowWorkVar = (RShowWorkVar.calculate manager)
    if RShowWorkVar then
      true
    else
     false
    end", 
    :order => 101, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)

     @Id = WebCalc.find_by_name('RSpouseCaidIneligUnearn') 
      @RSpouseCaidIneligUnearn = WebNumericalResult.find_by_name('RSpouseCaidIneligUnearn') 
      @RSpouseCaidIneligUnearn.delete unless @RSpouseCaidIneligUnearn.blank?
      @RSpouseCaidIneligUnearn = WebNumericalResult.create!(:name => 'RSpouseCaidIneligUnearn', :text => 'RSpouseCaidIneligUnearn',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
      RShowWorkVar = (RShowWorkVar.calculate manager)
      if RShowWorkVar then
        true
      else
       false
      end", 
      :order => 102, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)

    @Id = WebCalc.find_by_name('RSsiResourceLimitExceed') 
     @RSsiResourceLimitExceed = WebNumericalResult.find_by_name('RSsiResourceLimitExceed') 
     @RSsiResourceLimitExceed.delete unless @RSsiResourceLimitExceed.blank?
     @RSsiResourceLimitExceed = WebNumericalResult.create!(:name => 'RSsiResourceLimitExceed', :text => 'RSsiResourceLimitExceed',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
     RShowWorkVar = (RShowWorkVar.calculate manager)
     if RShowWorkVar then
       true
     else
      false
     end", 
     :order => 103, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)

      @Id = WebCalc.find_by_name('RCaidResourceLimitExceed') 
       @RCaidResourceLimitExceed = WebNumericalResult.find_by_name('RCaidResourceLimitExceed') 
       @RCaidResourceLimitExceed.delete unless @RCaidResourceLimitExceed.blank?
       @RCaidResourceLimitExceed = WebNumericalResult.create!(:name => 'RCaidResourceLimitExceed', :text => 'RCaidResourceLimitExceed',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
       RShowWorkVar = (RShowWorkVar.calculate manager)
       if RShowWorkVar then
         true
       else
        false
       end", 
       :order => 104, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)

    @Id = WebCalc.find_by_name('R1619bIneligUnearnOrResources') 
     @R1619bIneligUnearnOrResources = WebNumericalResult.find_by_name('R1619bIneligUnearnOrResources') 
     @R1619bIneligUnearnOrResources.delete unless @R1619bIneligUnearnOrResources.blank?
     @R1619bIneligUnearnOrResources = WebNumericalResult.create!(:name => 'R1619bIneligUnearnOrResources', :text => 'R1619bIneligUnearnOrResources',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
     RShowWorkVar = (RShowWorkVar.calculate manager)
     if RShowWorkVar then
       true
     else
      false
     end", 
     :order => 106, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)

   @Id = WebCalc.find_by_name('R1619bIneligThreshold') 
    @R1619bIneligThreshold = WebNumericalResult.find_by_name('R1619bIneligThreshold') 
    @R1619bIneligThreshold.delete unless @R1619bIneligThreshold.blank?
    @R1619bIneligThreshold = WebNumericalResult.create!(:name => 'R1619bIneligThreshold', :text => 'R1619bIneligThreshold',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
    RShowWorkVar = (RShowWorkVar.calculate manager)
    if RShowWorkVar then
      true
    else
     false
    end", 
    :order => 108, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)

   @Id = WebCalc.find_by_name('RSpouse1619bIneligThreshold') 
    @RSpouse1619bIneligThreshold = WebNumericalResult.find_by_name('RSpouse1619bIneligThreshold') 
    @RSpouse1619bIneligThreshold.delete unless @RSpouse1619bIneligThreshold.blank?
    @RSpouse1619bIneligThreshold = WebNumericalResult.create!(:name => 'RSpouse1619bIneligThreshold', :text => 'RSpouse1619bIneligThreshold',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
    RShowWorkVar = (RShowWorkVar.calculate manager)
    if RShowWorkVar then
      true
    else
     false
    end", 
    :order => 110, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)

#R1619bElig
    @Id = WebCalc.find_by_name('R1619bElig') 
     @R1619bElig = WebNumericalResult.find_by_name('R1619bElig') 
     @R1619bElig.delete unless @R1619bElig.blank?
     @R1619bElig = WebNumericalResult.create!(:name => 'R1619bElig', :text => 'R1619bElig',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
     RShowWorkVar = (RShowWorkVar.calculate manager)
     if RShowWorkVar then
       true
     else
      false
     end", 
     :order => 112, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)
  
   @Id = WebCalc.find_by_name('RSpouse1619bElig') 
    @RSpouse1619bElig = WebNumericalResult.find_by_name('RSpouse1619bElig') 
    @RSpouse1619bElig.delete unless @RSpouse1619bElig.blank?
    @RSpouse1619bElig = WebNumericalResult.create!(:name => 'RSpouse1619bElig', :text => 'RSpouse1619bElig',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
    RShowWorkVar = (RShowWorkVar.calculate manager)
    if RShowWorkVar then
      true
    else
     false
    end", 
    :order => 114, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)
  
    @Id = WebCalc.find_by_name('RLoseSSIFinancial') 
     @RLoseSSIFinancial = WebNumericalResult.find_by_name('RLoseSSIFinancial') 
     @RLoseSSIFinancial.delete unless @RLoseSSIFinancial.blank?
     @RLoseSSIFinancial = WebNumericalResult.create!(:name => 'RLoseSSIFinancial', :text => 'RLoseSSIFinancial',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
     RShowWorkVar = (RShowWorkVar.calculate manager)
     if RShowWorkVar then
       true
     else
      false
     end", 
     :order => 116, :web_calc_id => @Id.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id) 
  
    #example from past
  #   @RTotalWorkExpAmtId = WebCalc.find_by_name('RTotalWorkExpAmt') 
  #    @RTotalWorkExpAmt = WebNumericalResult.find_by_name('RTotalWorkExpAmt') 
  #    @RTotalWorkExpAmt.delete unless @RTotalWorkExpAmt.blank?
  #    @RTotalWorkExpAmt = WebNumericalResult.create!(:name => 'RTotalWorkExpAmt', :text => 'RTotalWorkExpAmt',:display_rules =>"RShowWorkVar = WebCalc.find_by_name('RShowWorkVar')
  #    RShowWorkVar = (RShowWorkVar.calculate manager)
  #    if RShowWorkVar then
  #      true
  #    else
  #     false
  #    end", 
  #    :order => 1, :web_calc_id => @RTotalWorkExpAmtId.id,    :group_id => @BobWebSsiWiCalcSheetDisplay.id)
  end

  def self.down
  end
end
