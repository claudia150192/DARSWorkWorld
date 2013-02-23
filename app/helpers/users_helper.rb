module UsersHelper

def mark_mandatory
  raw("<span class='red'>*</span>")
end

  def display_help_for_fileshare 
#link_to(image_tag('help-blue-button.png', :heigh => 26, :width => 26) , "javascript:RH_ShowHelp(0, '/WebHelp/Helpfile_csh.htm', HH_HELP_CONTEXT, #{question.help_id})", :class => 'help-icon' )
    #link_to("Help", help_path(question.help_id), :class => 'help' ) unless question.help_id.nil?
     #link_to(raw("Help for &quot;#{question.text}&quot;"), "javascript:RH_ShowHelp(0, '/WebHelp/WebHelp_Example.htm>SecondWindow', HH_HELP_CONTEXT, 1)", :class=>'help')
    help_link("File Share", 10)
  end
end
