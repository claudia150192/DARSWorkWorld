Factory.define :question do |q|
  q.name "question"
  q.text "answer me"
  q.display_rules "always"
  q.default_answer "answer"
  q.reference_id "1"
  q.question_order "1"
  q.question_type "text_field"
  q.validation_rules "
  answer = manager.get_answer_by_question_name(self.name)
  (Float(answer) != nil rescue false && answer >= 0) ? true : false"
  q.validation_message "Answer must be 0 or a positive number"
end

Factory.define :valid_question, :parent => :question do |q|
  q.validation_rules ""
  q.validation_message ""
end

Factory.define :question_without_group, :parent => :question do |q|
  q.group nil
end

Factory.define :expression_default_question, :parent => :question do |q|
  q.name "expression_default_question"
  q.default_answer "expression= 1 + 2"
end

Factory.define :first_question, :parent => :valid_question do |q|
  q.name "first_question"
  q.question_order "1"
end

Factory.define :second_question, :parent => :valid_question do |q|
  q.name "second_question"
  q.question_order "2"
end

Factory.define :third_question, :parent => :valid_question do |q|
  q.name "third_question"
  q.question_order "3"
end

Factory.define :fourth_question, :parent => :valid_question do |q|
  q.name "fourth_question"
  q.question_order "4"
end

Factory.define :fifth_question, :parent => :valid_question do |q|
  q.name "fifth_question"
  q.question_order "5"
end

Factory.define :income_question, :parent => :valid_question do |q|
  q.name "income_question"
  q.default_answer "0.0"
end

Factory.define :expense_question, :parent => :valid_question do |q|
  q.name "expense_question"
  q.default_answer "expression= 
  manager.get_answer_by_question_name('income_question')
  "
end
