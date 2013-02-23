module QuestionsHelper
  
  # Display question based on question_type and answer_choices
  # 
  # ==== Parameters
  #
  # * <tt>:question</tt> - the question being displayed
  # * <tt>:situation</tt> - a hash of the answers grouped for each group/question, <tt>{ :groups => { "group one" => { :id => 1, :questions => { "question 1" => "answer 1", "question 2" => "answer 2" }}}}</tt>.
  # 
  # ==== Examples
  #  
  #   * <tt>:question_type</tt>
  #     ** <tt>:text_field</tt>       -   show a normal text field input
  #     ** <tt>:text_area</tt>        -   show a normal text area input
  #     ** <tt>:select</tt>           -   show a normal select input
  #     ** <tt>:radio_buttons</tt>    -   show a normal radio button input
  #     ** <tt>:checkboxes</tt>       -   show a normal checkboxes input
  #     ** <tt>:hidden_field</tt>     -   show a normal hidden field input
  #     ** <tt>:date_time</tt>        -   show a text field input with a calendar popup
  #     ** <tt>:not_question</tt>     -   show a disabled text field input
  # 
  #   * <tt>:answer_choices</tt>
  #     ** <tt>:states, States</tt>                                                                   -   show list of US states as option in drop down list
  #     ** <tt>:counties, Counties, cities, Cities, Counties and Cities, counties and cities</tt>     -   show list of VA counties and cities as option in drop down list
  # 
  #   * <tt>:default_answer</tt> 
  #     ** <tt>:Current Date, current date, today, Today</tt>    -   use today's date as default answer
  def display_question question, situation
    manager = WWWebSessionManager.new(situation)
    question_info = manager.get_question_information_by_question_name(question.name)
    
    #TODO:  possibly move these two lines into the situation#answer_to function?
    default = default_for(question, situation)

    accept_button = ''
    accept_button = submit_tag("Accept", :class => "button", :name => "accept") unless situation.case.is_a? SharedCase
    id = question.idify # maintain a browser friendly id for input
    display = ""
    display << display_help(question)
    case question.question_type
    when "text_field"
      display = text_field_tag "groups[#{question.group.name}][questions][#{question.name}]", default, :class => "textfield answer", :id => id
      display << accept_button
    when "text_area"
      display = text_area_tag "groups[#{question.group.name}][questions][#{question.name}]", default, :class => "textarea answer", :rows => 20, :cols => 40, :id => id
      display << accept_button
    when "select"
      choices = question.answer_choices.blank? ? [] : options_for_select(question.answer_choices.split(/, /), default)
      case question.answer_choices
      when "states", "States"
        choices = state_options_for_select(selected = default || "Virginia", country = 'US')
      when "counties", "Counties", "cities", "Cities", "Counties and Cities", "counties and cities"
        choices = options_for_select(CountyOrCity.all.collect {|p| [ p.name, p.name ] }, default)
      end
      display = select_tag "groups[#{question.group.name}][questions][#{question.name}]", choices, :class => "textfield answer", :id => id
      display << accept_button
    when "checkboxes"
      question.answer_choices.split(/, /).collect do |choice|
        display = check_box_tag("groups[#{question.group.name}][questions][#{question.name}][]", choice, default == choice, :class => "checkbox answer", :id => id)
        display << accept_button
      end
    when "radio_buttons"
      question.answer_choices.split(/, /).collect do |choice|
        display << radio_button_tag("groups[#{question.group.name}][questions][#{question.name}]", choice, default == choice, :class => "radio answer", :id => id)
        display << accept_button
      end
    when "hidden_field"
      display = hidden_field_tag "groups[#{question.group.name}][questions][#{question.name}]", default, :class => "textfield", :id => id
    when "date_time"
      begin 
        Date.strptime(default, "%m/%d/%Y")
      rescue
        default = current_user.default_answer(question, situation)
      end
      choice = default.blank? ? Date.today.strftime("%m/%d/%Y") : Date.strptime(default, "%m/%d/%Y").strftime("%m/%d/%Y")
      display = calendar_date_select_tag "groups[#{question.group.name}][questions][#{question.name}]", choice #, :year_range => 100.years.ago..0.years.ago, :class => "textfield date_time", :id => id
      display << accept_button
    when "not_question"
      display = hidden_field_tag "groups[#{question.group.name}][questions][#{question.name}]", default, :class => "textfield", :id => id
      display << text_field_tag("groups[#{question.group.name}][questions][#{question.name}]", default, :class => "textfield disabled", :disabled => true, :id => id)
    end
    display << image_tag('ajax-loader.gif', :id => "#{question.id}_spinner", :style => "float:right; display:none;")
    if question.has_validation_errors?
      display = "<span class='question fieldWithErrors'>" + display_help(question) + display
      unless question.validation_message.blank?
        display << "<div class='help'>"
        display << calculate(question.validation_message, situation)
        display << "</div>" 
      end
      display << "</span>" 
    else
      display = "<span class='question'>#{display_help(question)} #{display}</span>"
    end
    raw(display)
  end
  
  # Dsplay help icon for question pointing to the RoboHelp help.
  # 
  # ==== Parameters
  #
  # * <tt>:question</tt> - the question being displayed
  def display_help question
#link_to(image_tag('help-blue-button.png', :heigh => 26, :width => 26) , "javascript:RH_ShowHelp(0, '/WebHelp/Helpfile_csh.htm', HH_HELP_CONTEXT, #{question.help_id})", :class => 'help-icon' )
    #link_to("Help", help_path(question.help_id), :class => 'help' ) unless question.help_id.nil?
     #link_to(raw("Help for &quot;#{question.text}&quot;"), "javascript:RH_ShowHelp(0, '/WebHelp/WebHelp_Example.htm>SecondWindow', HH_HELP_CONTEXT, 1)", :class=>'help')
    help_link(question.text, question.help_id)
  end
 
  def calendar_date_select_tag question, answer
    text_field_tag question, answer, :class=> 'textfield date_time answer'
  end

  def default_for question, situation
    current = get_current_answer(question, situation)
    default = question.default_answer_for situation
    if current.blank?
       answer = situation.answer_to question
       default = answer.answer unless answer.blank?
    else
      default = current
    end
    default
  end

  def get_current_answer question, situation
    begin
      display_answer(situation[:groups][question.group.name][:questions][question.name][:answer])
    rescue
      nil
    end
  end

  def display_answer a
    if a.is_a?(Hash) && a[:answer]
      a[:answer]
    else
      a
    end
  end

  def hidden_for question, situation
    default = default_for question, situation
    hidden_field_tag "groups[#{question.group.name}][questions][#{question.name}]", default, :class => "hidden answer", :id => question.idify
  end

 #added by RMC on June 13, 2011 
  
    def display_question_text  question_id, question_text
      display = question_text
    @WebInsertion = QuestionInsert.find(:all, :conditions => ['question_id = ?',  question_id], :order => 'insert_number')
           if  @WebInsertion.blank? then       
                if question_text.blank? then
                  question_text = "why question text Blank in Questions helper"
               else
                question_text
               end
           else
             insert_text(question_text, @WebInsertion) 
           end       
 
    end
    
  #Note to Bob, this needs to be beefed up.  If there is a record in the insertion table but no marker or mismatched marker [typically ~] we get a nill error and a bad screen
    def display_question_validation_message  question_id, question_validation_text
      display = question_validation_text
    @WebMessageInsertion = QuestionValidationInsert.find(:all, :conditions => ['question_id = ?',  question_id], :order => 'insert_number')
           if  @WebMessageInsertion.blank? then       
             question_validation_text
 
           else
             insert_text(question_validation_text, @WebMessageInsertion) 
           end       
 
    end

    # insert text into text result and remove pointer.  PLan on making this more global as others added? This code is repeated in Web Text Results Helper
    def insert_text result, questionInserts

       @manager ||= WWWebSessionManager.new(situation)
       @counter = 0
       @iStringPoint = 0
       @iOldStringPoint = @iStringPoint
       @WorkingText = result
       @addSpaces = 0

       #for each insertion as found in the insertion table
       questionInserts.each do |web_insert| 

         #Figure out what is to be inserted this time and put in calcResult
         @WCalcInserted = WebCalc.find(:first, :conditions => ['id = ?',  web_insert.webcalc_id_to_insert])

          if !(@WCalcInserted.blank?) then

            #Bah if i forget the == instead of = again  i'm going to spit and hope i miss the monitor
            if web_insert.insert_type == "string_detail" then
              @calcResult = @WCalcInserted.calculate(@manager).to_s 

            else
              @calcResult = number_to_currency(@WCalcInserted.calculate(@manager).to_f) 

            end

          else
             @calcResult  = "missing pointer in Web Tip text !!!!!!"
          end

         #find out where the insert_marker is pointing 
         #smarker is the string from the db that indicates where calc is to be inserted
         @sMarker = web_insert.insert_marker
         #str.index(substring [, offset])

         @addSpaces = @addSpaces + @calcResult.length

         if (@iOldStringPoint == @iStringPoint) then

            @iStringPoint = result.index(@sMarker, 0) 
            @WorkingText = result[0, @iStringPoint - (web_insert.insert_marker.length - 1)]
            @WorkingText = @WorkingText + @calcResult
            @WorkingText = @WorkingText + result[(@iStringPoint + (web_insert.insert_marker.length)), (result.length + web_insert.insert_marker.length)]

            @iOldStringPoint =  @iStringPoint + 1

         else

           @iStringPoint = @WorkingText.index(@sMarker, @iOldStringPoint) 

           #this zero may not work with more than 2 insertions, review later
           @partOneText = @WorkingText[0, (@iStringPoint)]

           #this is the text betweeen the insertion points
           @partTwoText = @WorkingText[(@iStringPoint + web_insert.insert_marker.length), (result.length + @addSpaces) ]
           #@newWorkingText = 
           @WorkingText = @partOneText  + @calcResult + @partTwoText


         end

      end

      @rString =  @WorkingText 
      #@rString =  "testing"
    end
end
