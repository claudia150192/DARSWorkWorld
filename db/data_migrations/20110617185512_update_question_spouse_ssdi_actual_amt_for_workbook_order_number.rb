class UpdateQuestionSpouseSsdiActualAmtForWorkbookOrderNumber < ActiveRecord::Migration
  def self.up
    
    
    @SpouseSsdiActualAmt                  = Question.find(:first, :conditions => ['name = ?',  'SpouseSsdiActualAmt'])
    @SpouseSsdiActualAmt.update_attribute(:workbook_order, "65.50")   unless @SpouseSsdiActualAmt.blank?

  end

  def self.down
  end
end
