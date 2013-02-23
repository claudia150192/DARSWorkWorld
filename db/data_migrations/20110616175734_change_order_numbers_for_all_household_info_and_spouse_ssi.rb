class ChangeOrderNumbersForAllHouseholdInfoAndSpouseSsi < ActiveRecord::Migration
  def self.up
   # VA_CityCounty                                    
   # Married
   # LiveWithSpouse
   # SpouseBirthDate
   # SpouseBlind
   # SpouseDisability
   # VA_CaidLiveWithSpouseAndOwnParents
   # VA_CaidLiveWithSpouseAndSpouseParents
   # LiveWithSpouseAndOthers
   # LiveWithSpouseInFacility
   # SpouseLiveInFacility
   # Alone
   # LiveWithParents
   # LiveWithOthers
   # LiveInFacility
  
    
   @VA_CityCounty                                    = Question.find(:first, :conditions => ['name = ?',  'VA_CityCounty'])
   @Married                                          = Question.find(:first, :conditions => ['name = ?',  'Married'])
   @LiveWithSpouse                                   = Question.find(:first, :conditions => ['name = ?',  'LiveWithSpouse'])
   @SpouseBirthDate                                  = Question.find(:first, :conditions => ['name = ?',  'SpouseBirthDate'])
   @SpouseBlind                                      = Question.find(:first, :conditions => ['name = ?',  'SpouseBlind'])
   @SpouseDisability                                 = Question.find(:first, :conditions => ['name = ?',  'SpouseDisability'])
   @VA_CaidLiveWithSpouseAndOwnParents               = Question.find(:first, :conditions => ['name = ?',  'VA_CaidLiveWithSpouseAndOwnParents'])
   @VA_CaidLiveWithSpouseAndSpouseParents            = Question.find(:first, :conditions => ['name = ?',  'VA_CaidLiveWithSpouseAndSpouseParents'])
   @LiveWithSpouseAndOthers                          = Question.find(:first, :conditions => ['name = ?',  'LiveWithSpouseAndOthers'])
   @LiveWithSpouseInFacility                         = Question.find(:first, :conditions => ['name = ?',  'LiveWithSpouseInFacility'])
   @SpouseLiveInFacility                             = Question.find(:first, :conditions => ['name = ?',  'SpouseLiveInFacility'])
   @Alone                                            = Question.find(:first, :conditions => ['name = ?',  'Alone'])
   @LiveWithParents                                  = Question.find(:first, :conditions => ['name = ?',  'LiveWithParents'])
   @LiveWithOthers                                   = Question.find(:first, :conditions => ['name = ?',  'LiveWithOthers'])
   @LiveInFacility                                   = Question.find(:first, :conditions => ['name = ?',  'LiveInFacility'])
    
      
  @VA_CityCounty.update_attribute(:question_order, "1")                           unless @VA_CityCounty.blank?                      
  @Married.update_attribute(:question_order, "2")                                 unless @Married.blank?                          
  @LiveWithSpouse.update_attribute(:question_order, "3")                          unless @LiveWithSpouse.blank?
  @SpouseBirthDate.update_attribute(:question_order, "4")                         unless @SpouseBirthDate.blank?               
  @SpouseBlind.update_attribute(:question_order, "5")                             unless @SpouseBlind.blank?                 
  @SpouseDisability.update_attribute(:question_order, "6")                        unless @SpouseDisability.blank?                   
  @VA_CaidLiveWithSpouseAndOwnParents.update_attribute(:question_order, "7")      unless @VA_CaidLiveWithSpouseAndOwnParents.blank?
  @VA_CaidLiveWithSpouseAndSpouseParents.update_attribute(:question_order, "8")   unless @VA_CaidLiveWithSpouseAndSpouseParents.blank?
  @LiveWithSpouseAndOthers.update_attribute(:question_order, "9")                 unless @LiveWithSpouseAndOthers.blank?
  @LiveWithSpouseInFacility.update_attribute(:question_order, "10")               unless @LiveWithSpouseInFacility.blank?
  @SpouseLiveInFacility.update_attribute(:question_order, "11")                   unless @SpouseLiveInFacility.blank?
  @Alone.update_attribute(:question_order, "12")                                  unless @Alone.blank?
  @LiveWithParents.update_attribute(:question_order, "13")                        unless @LiveWithParents.blank?
  @LiveWithOthers.update_attribute(:question_order, "14")                         unless @LiveWithOthers.blank?
  @LiveInFacility.update_attribute(:question_order, "15")                         unless @LiveInFacility.blank?
   
  @VA_CityCounty.update_attribute(:workbook_order, "10.00")                         unless @VA_CityCounty.blank?                      
  @Married.update_attribute(:workbook_order, "10.50")                               unless @Married.blank?                          
  @LiveWithSpouse.update_attribute(:workbook_order, "11.00")                        unless @LiveWithSpouse.blank?
  @SpouseBirthDate.update_attribute(:workbook_order, "12.00")                       unless @SpouseBirthDate.blank?               
  @SpouseBlind.update_attribute(:workbook_order, "13.00")                           unless @SpouseBlind.blank?                 
  @SpouseDisability.update_attribute(:workbook_order, "14.00")                      unless @SpouseDisability.blank?                   
  @VA_CaidLiveWithSpouseAndOwnParents.update_attribute(:workbook_order, "15.00")    unless @VA_CaidLiveWithSpouseAndOwnParents.blank?
  @VA_CaidLiveWithSpouseAndSpouseParents.update_attribute(:workbook_order, "16.00") unless @VA_CaidLiveWithSpouseAndSpouseParents.blank?
  @LiveWithSpouseAndOthers.update_attribute(:workbook_order, "17.00")               unless @LiveWithSpouseAndOthers.blank?
  @LiveWithSpouseInFacility.update_attribute(:workbook_order, "19.00")              unless @LiveWithSpouseInFacility.blank?
  @SpouseLiveInFacility.update_attribute(:workbook_order, "19.50")                  unless @SpouseLiveInFacility.blank?
  @Alone.update_attribute(:workbook_order, "20.00")                                 unless @Alone.blank?
  @LiveWithParents.update_attribute(:workbook_order, "21.00")                       unless @LiveWithParents.blank?
  @LiveWithOthers.update_attribute(:workbook_order, "22.00")                        unless @LiveWithOthers.blank?
  @LiveInFacility.update_attribute(:workbook_order, "24.00")                        unless @LiveInFacility.blank?
                                                                                 
   
   
  @SpouseSsiGet                       = Question.find(:first, :conditions => ['name = ?',  'SpouseSsiGet'])
  @VA_SpouseLiveInAuxGrantFacility    = Question.find(:first, :conditions => ['name = ?',  'VA_SpouseLiveInAuxGrantFacility'])
  @SsiSpouseActualAmt                 = Question.find(:first, :conditions => ['name = ?',  'SsiSpouseActualAmt'])
   
  @SpouseSsiGet.update_attribute(:question_order, "1")                     unless @SpouseSsiGet.blank?  
  @VA_SpouseLiveInAuxGrantFacility.update_attribute(:question_order, "2")  unless @VA_SpouseLiveInAuxGrantFacility.blank?        
  @SsiSpouseActualAmt.update_attribute(:question_order, "3")               unless @SsiSpouseActualAmt.blank?

  @SpouseSsiGet.update_attribute(:workbook_order, "52.00")                     unless @SpouseSsiGet.blank?  
  @VA_SpouseLiveInAuxGrantFacility.update_attribute(:workbook_order, "52.25")  unless @VA_SpouseLiveInAuxGrantFacility.blank?    
  @SsiSpouseActualAmt.update_attribute(:workbook_order, "52.50")               unless @SsiSpouseActualAmt.blank?
   
    
  end

  def self.down
  end
end
