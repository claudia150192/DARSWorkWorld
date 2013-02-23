class UpdateWebtipTipSsiAgeLessThan22ForInsertAndDisplayRule < ActiveRecord::Migration
  def self.up
    
    require 'wwweb_session_manager'  
     #first webTip Insert
     #Since you will be less than 22 years old on the date of this situation, if you are also a full-time student you can exclude up to ~RateSEIEMaxYear~ of earned income annually when determining if your SSI cash benefit decreases because of earnings.
     #Tip_SsiAgeLessThan22
          
     @Tip_SsiAgeLessThan22 = WebTip.find(:first, :conditions => ['identifier = ?',  'Tip_SsiAgeLessThan22']) 
    #@Tip_SsiAgeLessThan22 = WebTip.find_by_name('Tip_SsiAgeLessThan22')
    @Tip_SsiAgeLessThan22.update_attribute(:text, "Since you will be less than 22 years old on the date of this situation, if you are also a full-time student you can exclude up to ~ of earned income annually when determining if your SSI cash benefit decreases because of earnings.") 

    #note baased on a June 9, 2011 conversation with DR we are moving this to the Student Earned Income Exclusion (SEIE) group
  @seieGroup = QuestionGroup.find(:first, :conditions => ['name = ?', 'Student Earned Income Exclusion (SEIE)'])
  @Tip_SsiAgeLessThan22.update_attribute(:group_id, @seieGroup.id) 

    #IF SsiGet = YES AND RAge < 22
    @Tip_SsiAgeLessThan22.update_attribute(:display_rules, "
    RAge = WebCalc.find_by_name('RAge')
    Age = RAge.calculate manager
    SsiGet = manager.get_answer_by_question_name('SsiGet')
    if SsiGet == 'Yes' && Age < 22 then 
      true
    else
      false
    end    
    ")

   # insert   OK this is bad Carma, i did not know RateSEIEMaxYear was not created and to keep this from blowing up i'll add it here.
   @RateSEIEMaxYear  = WebCalc.find_by_name('RateSEIEMaxYear')
    if @RateSEIEMaxYear.blank? then
       @RateSEIEMaxYear  = WebCalc.new(:name => 'RateSEIEMaxYear', :operation => "
      unless manager.get_answer_by_question_name('SitDate').blank? 
       SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
       rate = FederalRate.find(:last, :conditions => ['start_date <= ?', SitDate])
        if !(rate.blank?) then
            RateSEIEMaxYear = rate.seie_max_year
        else
            RateSEIEMaxYear = 6600
        end
     
        return RateSEIEMaxYear
     
      else 
        return 6600
      end")
       @RateSEIEMaxYear.save!
   end


   @Insert2 = WebTipInsert.find(:first, :conditions => ['web_tip_id = ? AND insert_number = ?',  @Tip_SsiAgeLessThan22.id, 1])
   if @Insert2.blank? then
      @Insert2  = WebTipInsert.new(:web_tip_id => @Tip_SsiAgeLessThan22.id, :insert_number => '1', :webcalc_id_to_insert => @RateSEIEMaxYear.id, :insert_marker => "~", :insert_type => 'currency')
      @Insert2.save!
  else
    @Insert2.update_attribute(:web_tip_id, @Tip_SsiAgeLessThan22.id)
    @Insert2.update_attribute(:insert_number, '1')
    @Insert2.update_attribute(:webcalc_id_to_insert, @RateSEIEMaxYear.id)
    @Insert2.update_attribute(:insert_marker, '~')
    @Insert2.update_attribute(:insert_type, 'currency')
   end
  end

  def self.down
  end
end
