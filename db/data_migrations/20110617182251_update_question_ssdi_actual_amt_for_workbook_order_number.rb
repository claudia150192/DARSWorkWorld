class UpdateQuestionSsdiActualAmtForWorkbookOrderNumber < ActiveRecord::Migration
  def self.up


    @SsdiActualAmt                  = Question.find(:first, :conditions => ['name = ?',  'SsdiActualAmt'])
    @SsdiActualAmt.update_attribute(:workbook_order, "43")   unless @SsdiActualAmt.blank?
 
  end

  def self.down
  end
end
