class UpdateQuestionLiveWithSpouseForSplitWithMarried < ActiveRecord::Migration
  def self.up
    
    require 'wwweb_session_manager' 

     #26 36 45	13	Are you living with your spouse?	
     #LiveWithSpouse			YES:NO		NO	If Married = Y	Appear	YES	Splitting the question about "married and living with spouse" allows us to ask about situations in which one person in a marriage is in a facility.	11.00
         
    @QuestionGroup = QuestionGroup.find(:first, :conditions => ['name = ?', 'Household Info'])
    @LiveWithSpouse = Question.find(:first, :conditions => ['name = ?',  'LiveWithSpouse']) 
 
    if @LiveWithSpouse.blank? then
       @LiveWithSpouse = Question.new(:name => 'LiveWithSpouse', :text => 'LiveWithSpouse?', :display_rules => 'always', :default_answer => 'No', :reference_id => '13',  :question_type => 'select', :answer_choices => 'Yes, No', :question_order => 3 , :group_id => @QuestionGroup.id) 
    end
 
    @LiveWithSpouse.update_attribute(:text, "Are you living with your spouse?") 
    @LiveWithSpouse.update_attribute(:default_answer, "No")
    @LiveWithSpouse.update_attribute(:group_id, @QuestionGroup.id) 
    @LiveWithSpouse.update_attribute(:question_type, "select") 
    @LiveWithSpouse.update_attribute(:answer_choices, "Yes, No") 
    @LiveWithSpouse.update_attribute(:question_order, "3")
    @LiveWithSpouse.update_attribute(:workbook_order, "11") 
 
       #If Married = Y
    @LiveWithSpouse.update_attribute(:display_rules, "
      Married = manager.get_answer_by_question_name('Married')
      Married == 'Yes'")
      
  end

  def self.down
  end
end
