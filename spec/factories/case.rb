Factory.define :case do |c|
  c.name 'case'
end

Factory.define :situation do |s|
  s.situation_type Situation::TYPES[:current_situation]
  s.mode "group"
end

Factory.define :what_if, :parent=>:situation do |w|
  w.situation_type Situation::TYPES[:what_if]
  w.mode "group"
end

Factory.define :answer do |a|
  a.answer 'answer'
end
