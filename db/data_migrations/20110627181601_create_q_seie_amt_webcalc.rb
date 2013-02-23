class CreateQSeieAmtWebcalc < ActiveRecord::Migration
  def self.up
      
  require 'wwweb_session_manager'  

    @Q_SeieAmt = WebCalc.find_by_name('Q_SeieAmt')
    if @Q_SeieAmt.blank? then
       @Q_SeieAmt  = WebCalc.new(:name => 'Q_SeieAmt')
    end

    @Q_SeieAmt.operation = "
   SeieAmt = manager.get_answer_by_question_name('SeieAmt')
   SeieAmt.to_f
    "
    @Q_SeieAmt.save!
  end

  def self.down
  end
end
