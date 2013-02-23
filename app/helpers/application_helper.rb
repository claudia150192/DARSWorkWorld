# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def evaluable_field form, field_name
    display = form.text_area field_name.to_sym, :class => "texteditfield"
    display << raw(evaluable_field_help)
    display
  end
  
  def evaluable_field_help
    "
      <div class='help'>
    		Instructions:<br />
    		a 'manager' object is available to retrieve answers to questions via the following two methods:
    		<ul class='help'>
    			<li>get_answer_by_question_name question_name</li>
    			<li>get_answer_by_group_and_question_name group_name, question_name</li>
    		</ul>
    		use the 'manager' to retrieve the values you wish to perform calculations on.<br />
    		you can manipulate the object using standard ruby code.<br />
    		PS: all answers are returned in form of a String.<br />
    		use Rails methods to retrieve information like rates: WebRate.find_by_name('name')<br />
    		or previous calculations: WebCalc.find_by_name('name')<br />
    		<br />
    		Examples:<br />
<pre>answer = manager.get_answer_by_question_name(self.name)
(answer.is_a?(Float) && answer >= 0) ? true : false
</pre>
<br />
<pre>birthdate = Date.strptime(manager.get_answer_by_question_name('BirthDate'), '%m/%d/%Y')
sitdate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
answer = sitdate.year - birthdate.year</pre>
        <br />
        To check if an answer is a valid date surround it by a begin-rescue block.<br />
        This could be used to either check answer validation or make sure previous answers don't break the current code.<br />
        Examples: <br />
<pre>
begin 
  Date.strptime(manager.get_answer_by_question_name(self.name), \"%m/%d/%Y\") 
  true 
rescue 
  false 
end
</pre>
<br />
<pre>
unless manager.get_answer_by_question_name('SitDate').blank? || manager.get_answer_by_question_name('BirthDate').blank? 
  begin 
    SitDate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y') 
    BirthDate = Date.strptime(manager.get_answer_by_question_name('BirthDate'), '%m/%d/%Y') 
    SitDate.year - BirthDate.year >= 15 && SitDate.year - BirthDate.year < 66 
  rescue 
    false 
  end 
else 
  false 
end
</pre>
    	</div>
    	<br />
    "
  end
  
  def evaluable_default_answer form
    display = form.text_area :default_answer, :class => "texteditfield"
    display << raw(evaluable_default_answer_help)
    display
  end

  def evaluable_default_answer_help
    "
      <div class='help'>
        To set to the current date enter: use the expression format as shown below.<br />
    		To set to a date enter date in following format: 'dd/mm/yyyy'.<br />

    		To use ruby expressions using the instructions mentioned below, add 'expression=' at the beginning. <br />
    		
    		Instructions:<br />
    		a 'manager' object is available to retrieve answers to questions via the following two methods:
    		<ul class='help'>
    			<li>get_answer_by_question_name question_name</li>
    			<li>get_answer_by_group_and_question_name group_name, question_name</li>
    		</ul>
    		use the 'manager' to retrieve the values you wish to perform calculations on.<br />
    		you can manipulate the object using standard ruby code.<br />
    		PS: all answers are returned in form of a String.<br />
    		use Rails methods to retrieve information like rates: WebRate.find_by_name('name')<br />
    		or previous calculations: WebCalc.find_by_name('name')<br />
    		<br />
    		Examples:<br />
<pre>expression= 1 + 2</pre>
<br />
<pre>expression= Date.today.strftime('%m/%d/%Y')</pre>
<br />
<pre>expression= 
answer = manager.get_answer_by_question_name(self.name)
(answer.is_a?(Float) && answer >= 0) ? true : false
</pre>
<br />
<pre>expression= 
birthdate = Date.strptime(manager.get_answer_by_question_name('BirthDate'), '%m/%d/%Y')
sitdate = Date.strptime(manager.get_answer_by_question_name('SitDate'), '%m/%d/%Y')
answer = sitdate.year - birthdate.year</pre>
    	</div>
    	<br />
    "
  end
#added on 3/3/2011 By Bobc to help sort columns
 def sortable(column, title = nil)
     title ||= column.titleize
     css_class = column == sort_column ? "current #{sort_direction}" : nil
     direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
     link_to title, {:sort => column, :direction => direction}, {:class => css_class}
   end


  def calculate(text, situation)
    @manager ||= WWWebSessionManager.new(situation)
    @manager.situation = situation

    result = text
    # calculate text 
    result = calc_with_format(result, @manager, 'T', Proc.new { |val| val })

    to_currency = Proc.new do |val|
      num = val.to_f
      number_to_currency(num, :unit => '$', :separator => ".", :delimiter => ",")
    end


    #calculate currency
    result = calc_with_format(result, @manager, 'C', to_currency)
    result
  end

  def calc_with_format(text, manager, prefix, format)
    result = text
    text_pattern = /#{prefix}\{(.+?)\}/
    desired_insertions = text.scan(text_pattern).flatten
    desired_insertions.each do |name|
      begin
        calc = WebCalc.find_by_name(name)
        value = calc.calculate(@manager).to_s
        value = format.call(value)
      rescue Exception => exc
        value = '*****'
        logger.warn exc
      end
      calc_pattern = "#{prefix}{"+name+"}"
      result = result.gsub(calc_pattern, value)
    end
    result
  end

  def admin?  
    logged_in? && @current_user.admin?
  end
  
  def delete_situation_link situation
    if situation.blank?
      "Delete"
    else
      link_to_if(@situation.what_if?, "Delete", delete_situation_path(:case_id=>@situation.case.id, :id=>@situation.id))
    end
  end

  #get a link to a numbered what-if for a case. This is a 1-indexed number, so the first what-if in a case is 1, second is 2 and so on.
  def what_if_link(kase, num)
    text = "What If #{num}"
    if (kase.nil? || kase.what_ifs.empty? || kase.what_ifs.count < num || num < 1)
      text
    else
      whatif = kase.what_ifs[num-1]
      link_to_unless(kase.has_unfinished_situation? && whatif.completed, text, edit_case_situation_path(:case_id=>kase.id, :id=>whatif.id))
    end
  end

  def cancel_link
    link_to "Cancel", :back, :rel=>"prev"
  end
end
