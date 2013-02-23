class CreateQuestionMarried < ActiveRecord::Migration
  def self.up
     #Add new Married question from workbook 45
     #12.5	Does (or would) SSA consider you married?	Married			YES:NO		NO	If Blind = Y OR Disability = Y
     #validates_presence_of :name, :text, :display_rules, :group_id, :question_type, :question_order
     
     @QuestionGroup_Household_Info = QuestionGroup.find(:first, :conditions => ['name = ?', 'Household Info'])
 
 
     @Married = Question.find(:first, :conditions => ['name = ?',  'Married']) 

      if @Married.blank? then
         @Married = Question.new(:name => 'Married', :text => 'Married?', :display_rules => 'always', :default_answer => 'No', :reference_id => '12.5',  :question_type => 'select', :answer_choices => 'Yes, No', :question_order => 2 , :group_id => @QuestionGroup_Household_Info.id) 
     
     
     
      end
     
      @Married.update_attribute(:text, "Does (or would) SSA consider you married?") 
      @Married.update_attribute(:default_answer, "No")
      @Married.update_attribute(:group_id, @QuestionGroup_Household_Info.id) 
      @Married.update_attribute(:question_type, "select") 
      @Married.update_attribute(:answer_choices, "Yes, No") 
      @Married.update_attribute(:question_order, "2")
      @Married.update_attribute(:workbook_order, "10.5") 
#BaH, NEED to remember to change all the question order for all household_info questions

    # If Blind = Y OR Disability = Y
       @Married.update_attribute(:display_rules, "
     Blind = manager.get_answer_by_question_name('Blind')
     Disability = manager.get_answer_by_question_name('Disability')
     (Blind == 'Yes' || Disability == 'Yes')") 
   
  #   CREATE TABLE `questions` (
  #     `id` int(11) NOT NULL AUTO_INCREMENT,
  #     `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  #     `text` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  #     `display_rules` text COLLATE utf8_unicode_ci,
  #     `default_answer` text COLLATE utf8_unicode_ci,
  #     `reference_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  #     `created_at` datetime DEFAULT NULL,
  #     `updated_at` datetime DEFAULT NULL,
  #     `group_id` int(11) DEFAULT NULL,
  #     `question_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  #     `answer_choices` text COLLATE utf8_unicode_ci,
  #     `question_order` int(11) DEFAULT NULL,
  #     `validation_rules` text COLLATE utf8_unicode_ci,
  #     `validation_message` text COLLATE utf8_unicode_ci,
  #     `help_id` int(11) DEFAULT NULL,
  #     `workbook_order` float DEFAULT NULL,
  #     PRIMARY KEY (`id`)
  #   ) ENGINE=InnoDB AUTO_INCREMENT=240828 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
 
 #@LiveWithSpouse = Question.new(:display_rules => 'always', :default_answer => 'Yes',   :reference_id => '13',  :question_type => 'select',       :answer_choices => 'Yes, No',                   :order => 2 ,    :group_id => @household.id)
 
    
  end

  def self.down
  end
end


