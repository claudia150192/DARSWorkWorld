Factory.define :web_tip do |wp|
  wp.text "Group text: initial"
  wp.identifier "wp-1"
  wp.display_rules "always"
  wp.workbook_order 1
end

Factory.define :non_default_first_question_web_tip, :parent => :web_tip do |wp|
  wp.text "You have changed the default answer for the first question"
  wp.identifier "wp-1"
  wp.display_rules "
  answer = manager.get_answer_by_question_name('first_question')
  answer != 'answer' && answer != nil"
end
