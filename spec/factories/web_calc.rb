Factory.define :web_calc do |w|
  w.sequence(:name) {|n| "Default_#{n}"}
  w.operation "18"
end
