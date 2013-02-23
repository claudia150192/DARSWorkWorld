class CreateWebcalcSitdate < ActiveRecord::Migration
  def self.up
       require 'wwweb_session_manager'  

     @Q_SitDate = WebCalc.find_by_name('Q_SitDate')
     if @Q_SitDate.blank? then
       @Q_SitDate  = WebCalc.new(:name => 'Q_SitDate')
     end

    @Q_SitDate.operation = "
      SitDate = manager.get_answer_by_question_name('SitDate')"
    @Q_SitDate.save!
  end

  def self.down
  end
end
