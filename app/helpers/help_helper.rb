module HelpHelper
#javascript:RH_ShowHelp(0, '/WebHelp/WebHelp_Example.htm>SecondWindow', HH_HELP_CONTEXT, 1)
def help_link text, help_id
  link_to_unless(help_id.nil?, raw("Help for &quot;#{text}&quot;"), "javascript:RH_ShowHelp(0, '/WebHelp/helpfile.htm', HH_HELP_CONTEXT, #{help_id} )", :class=>'help') do |name|
    ""
  end
end

def help_select

end

end
