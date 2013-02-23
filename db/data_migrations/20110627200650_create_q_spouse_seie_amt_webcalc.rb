class CreateQSpouseSeieAmtWebcalc < ActiveRecord::Migration
  def self.up
    require 'wwweb_session_manager'  
 
    @Q_SpouseSeieAmt = WebCalc.find_by_name('Q_SpouseSeieAmt')
    if @Q_SpouseSeieAmt.blank? then
       @Q_SpouseSeieAmt  = WebCalc.new(:name => 'Q_SpouseSeieAmt')
    end
 
    @Q_SpouseSeieAmt.operation = "
   SeieAmt = manager.get_answer_by_question_name('SpouseSeieAmt')
   "
    @Q_SpouseSeieAmt.save!
 
  end

  def self.down
  end
end
