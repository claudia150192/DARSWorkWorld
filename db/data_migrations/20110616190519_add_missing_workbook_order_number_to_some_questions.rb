class AddMissingWorkbookOrderNumberToSomeQuestions < ActiveRecord::Migration
  def self.up
    #CaidQdwiResourceLimitExceed
    #CaidCoupleQdwiResourceLimitExceed
    #CaidQmbSlmbQiResourceLimitExceed
    #CaidCoupleQmbSlmbQiResourceLimitExceed
    #CaidGetWorksResourceLimitExceed
                                                    
    @CaidQdwiResourceLimitExceed                      = Question.find(:first, :conditions => ['name = ?',  'CaidQdwiResourceLimitExceed'])
    @CaidCoupleQdwiResourceLimitExceed                = Question.find(:first, :conditions => ['name = ?',  'CaidCoupleQdwiResourceLimitExceed'])
    @CaidQmbSlmbQiResourceLimitExceed                 = Question.find(:first, :conditions => ['name = ?',  'CaidQmbSlmbQiResourceLimitExceed'])
    @CaidCoupleQmbSlmbQiResourceLimitExceed           = Question.find(:first, :conditions => ['name = ?',  'CaidCoupleQmbSlmbQiResourceLimitExceed'])
    @CaidGetWorksResourceLimitExceed                  = Question.find(:first, :conditions => ['name = ?',  'CaidGetWorksResourceLimitExceed'])

    @CaidQdwiResourceLimitExceed.update_attribute(:workbook_order, "87.10")   unless @CaidQdwiResourceLimitExceed.blank?            
    @CaidCoupleQdwiResourceLimitExceed.update_attribute(:workbook_order, "87.20")   unless @CaidCoupleQdwiResourceLimitExceed.blank?     
    @CaidQmbSlmbQiResourceLimitExceed.update_attribute(:workbook_order, "87.30")   unless @CaidQmbSlmbQiResourceLimitExceed.blank?      
    @CaidCoupleQmbSlmbQiResourceLimitExceed.update_attribute(:workbook_order, "87.40")   unless @CaidCoupleQmbSlmbQiResourceLimitExceed.blank?
    @CaidGetWorksResourceLimitExceed.update_attribute(:workbook_order, "87.55")   unless @CaidGetWorksResourceLimitExceed.blank?       
    
    
   
  end

  def self.down
  end
end
