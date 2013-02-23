
Factory.define :question_group do |g|
  g.name "Benefits Info"
  g.order "1"
  g.workbook_order 1
end

Factory.define :starting_group, :parent=>:question_group do |g|
  g.name "Startup Info"
  g.order "0"
  g.workbook_order 1
end

Factory.define :second_group, :parent => :question_group do |g|
  g.name "SSI"
  g.order "2"
  g.workbook_order 2

end

Factory.define :first_group, :parent => :question_group do |g|
  g.name "Household Info"
  g.order "1"
  g.workbook_order 1

end

Factory.define :child_group, :parent => :question_group do |g|
  g.name "child"
  g.workbook_order 1

end

Factory.define :income_group, :parent => :question_group do |g|
  g.name "income_group"
  g.order "3"
  g.workbook_order 1

end

Factory.define :expense_group, :parent => :question_group do |g|
  g.name "expense_group"
  g.order "4"
  g.workbook_order 1

end
