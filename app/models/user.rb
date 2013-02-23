class User < ActiveRecord::Base
  acts_as_authentic do |c|
    c.validates_uniqueness_of_email_field_options :if => lambda{false}
    c.logged_in_timeout 30.minutes
  end
  attr_accessible :login, :email, :password, :password_confirmation, :allow_fileshare, :receive_share_email, :receive_fileshare, :counselor_name, :name
  has_many :cases, :order => "cases.updated_at DESC"
  has_and_belongs_to_many :shared_cases
  default_scope where(:deleted_at => nil)
  attr_accessor :active

  # check if user is an admin
  def admin?
    self.admin
  end

  # check if the user is active, for soft delete
  def active?
    self.deleted_at == nil && self[:active] == true
  end
  
  def activate!
    self[:active] = true
    save!
  end

  # fetch the ones that were deleted
  def self.deleted
    self.unscoped.where('deleted_at IS NOT NULL')
  end
  
  # retrieve the default answer for a particular question
  # if the question's default answer is an expression, return that
  # elsif the user has a saved answer for the question, then return his saved answer
  # else return the question's default answer
  # 
  # ==== Parameters
  #
  # * <tt>:question</tt> - Question to check answer for
  # * <tt>:situation</tt> - a hash of the answers grouped for each group/question, <tt>{ :groups => { "group one" => { :id => 1, :questions => { "question 1" => { :answer => "answer 1"}, "question 2" => { :answer => "answer 2" } }}}}</tt>.
  def default_answer question, situation
    user_saved_answer = get_saved_answer question.id
    if question.is_expression? :default_answer
      return question.attribute_value(:default_answer, situation)
    elsif !user_saved_answer.blank?
      return user_saved_answer
    else
      return question.attribute_value(:default_answer, situation)
    end
  end
  
  # get user's last saved answer for a question
  def get_saved_answer question_id
    answer = Answer.find(:first, :order => "answers.updated_at DESC", :limit => 1,
                :joins => "LEFT JOIN situations ON answers.situation_id = situations.id
                LEFT JOIN cases ON situations.case_id = cases.id" ,
                :conditions => ["cases.user_id = ? AND answers.question_id = ?", self.id, question_id])
    answer.answer unless answer.blank?
  end

end
