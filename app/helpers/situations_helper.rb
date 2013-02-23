require 'wwweb_session_manager'
module SituationsHelper
  
  # Display situation name based on answer to question
  # Assumption: answer belongs to the SitName question in the Start-Up Information group
  # 
  # ==== Parameters
  #
  # * <tt>:situation</tt> - a hash of the answers grouped for each group/question, <tt>{ :groups => { "group one" => { :id => 1, :questions => { "question 1" => "answer 1", "question 2" => "answer 2" }}}}</tt>.
  def display_situation_name situation
    case_name = "#{situation.case.name}"
    sit_name  = "#{situation.name}"
    
    if situation.what_if?
      title = "Case:" + case_name + "| Situation:" + sit_name + " (What if)" 
    else
      title = "Case:" + case_name + "| Situation:" + sit_name + " (Current)"
    end

    raw(title)
#old code deleted on Monday Apr 2nd Scheduled for replacement on Apr 3rd 
#    title = "#{situation.case.name} - #{situation.name}"
#    
#    if situation.what_if?
#      type = "What If"
#    else
#      type = "Current Situation"
#    end
#    title << "<blockquote>(#{type})</blockquote>"
#    raw(title)

  end
 
  def display_situation_title situation
    case_name = "#{situation.case.name}"
    sit_name  = "#{situation.name}"
    
    if situation.what_if?
      title = " Sit Name:" + sit_name + " (What if)" 
    else
      title = " Sit Name:" + sit_name + " (Current)"
    end
#    title << "<blockquote>(#{type})</blockquote>"
    raw(title)

  end
  
  
  def new_situation_link kase
    if !kase.nil? && can_add_or_change_situation(kase)
      css_class = kase.situations.count > 1 ? 'dialog' : 'link'
      link_to("New", {:controller => "situations", :action => "new", :case_id=>kase.id}, "data-accesskey"=>"N", :class=>css_class, :id=>"new_situation_link") 
    end
  end

  # Display link to switch mode based on current mode selected
  # 
  # ==== Parameters
  #
  # * <tt>:situation</tt> - a hash of the answers grouped for each group/question.
  def display_mode situation
    if situation.mode == Situation::MODES[:one_at_a_time]
      link_to "Switch to group mode", edit_case_situation_path(:case_id=>@case.id,:id=>situation.id, :mode =>  Situation::MODES[:group])
    else
      link_to "Switch to one-at-a-time mode", edit_case_situation_path(:case_id=>@case.id,:id=>situation.id, :mode =>  Situation::MODES[:one_at_a_time] )
    end
  end
  
  # Display continue button to either use ajax or regular HTML based whether it should display next question or next group
  # 
  # ==== Parameters
  #
  # * <tt>:situation</tt> - a hash of the answers grouped for each group/question.
  # * <tt>:group</tt> - QuestionGroup to display
  def display_continue_button situation, group
    display = ''
    if group.get_next_displayable_question(situation).blank?
      display = submit_tag "Continue", :class => "button", :id => "continue", :name => "continue"
    else
		  display = submit_to_remote("continue", "Continue", 
  			:html 			=> { :class => "button", :id => "continue" },
        :url				=> { :controller => "situations", :action => "jwoww", :group_id => @group.id, :submit => 'continue'},
  			:update			=> "group",
        :before			=> "Element.show('continue_spinner')",
        :complete		=> "Element.hide('continue_spinner')",
        :with       => "Form.serialize(this.form)"
      )
    end
		display << image_tag('ajax-loader.gif', :id => "continue_spinner", :style => "float:right; display:none;")
  end

#RMC added >4 if clause to suppress menu when 4 what-ifs present.  Not sure what this is not >5
  def can_add_or_change_situation kase
    if kase.blank?
      return false
    elsif kase.situations.count > 4
      return false
    end
    return !kase.has_unfinished_situation?
  end
  
  def current_situation_link user, kase
    if kase.blank? || kase.current_situation.blank?
      return "Current Situation"
    else
      return link_to_unless(kase.has_unfinished_situation? && kase.current_situation.completed, "Current Situation", edit_case_situation_path(:case_id=>kase.id, :id=>kase.current_situation.id))
    end
  end

  def current_situation_path user, case_id
    current_situation = get_current_situation(user,case_id)
    if current_situation
      case_situations_path(case_id, current_situation.id)
    else
      new_case_situation_path(case_id)
    end
  end

private 
def get_current_situation user, case_id
  if(user.blank? || case_id.blank?)
      return nil
    end
    kase = user.cases.find(case_id)
    if(kase.blank?)
      return nil
    end
  kase.current_situation
end
end

