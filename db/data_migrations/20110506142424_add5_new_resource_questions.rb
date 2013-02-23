class Add5NewResourceQuestions < ActiveRecord::Migration
  def self.up
    require 'wwweb_session_manager'   
    @ResourcesQuestionsGroup = QuestionGroup.find_by_name('Resources') 
    
    @CaidQdwiResourceLimitExceed            =  Question.create!(:name => 'CaidQdwiResourceLimitExceed',           :text => 'resource?', :display_rules => 'false', :reference_id => '82.1', :default_answer => 'No', :answer_choices => 'Yes, No', :group_id => @ResourcesQuestionsGroup.id, :question_type => 'select',  :question_order => '5')
    @CaidCoupleQdwiResourceLimitExceed      =  Question.create!(:name => 'CaidCoupleQdwiResourceLimitExceed',     :text => 'resource?', :display_rules => 'false', :reference_id => '82.2', :default_answer => 'No', :answer_choices => 'Yes, No', :group_id => @ResourcesQuestionsGroup.id, :question_type => 'select',  :question_order => '6')
    @CaidQmbSlmbQiResourceLimitExceed       =  Question.create!(:name => 'CaidQmbSlmbQiResourceLimitExceed',      :text => 'resource?', :display_rules => 'false', :reference_id => '82.3', :default_answer => 'No', :answer_choices => 'Yes, No', :group_id => @ResourcesQuestionsGroup.id, :question_type => 'select',  :question_order => '7')
    @CaidCoupleQmbSlmbQiResourceLimitExceed =  Question.create!(:name => 'CaidCoupleQmbSlmbQiResourceLimitExceed',:text => 'resource?', :display_rules => 'false', :reference_id => '82.4', :default_answer => 'No', :answer_choices => 'Yes, No', :group_id => @ResourcesQuestionsGroup.id, :question_type => 'select',  :question_order => '8')
    @CaidWorksResourceLimitExceed           =  Question.create!(:name => 'CaidWorksResourceLimitExceed',          :text => 'resource?', :display_rules => 'false', :reference_id => '82.5', :default_answer => 'No', :answer_choices => 'Yes, No', :group_id => @ResourcesQuestionsGroup.id, :question_type => 'select',  :question_order => '9')
    
  end

  def self.down
  end
end
