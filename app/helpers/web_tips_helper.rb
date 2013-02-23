module WebTipsHelper
  
  def display_web_tip tip_text, tip_id
    display = ""
   @WebInsertion = WebTipInsert.find(:all, :conditions => ['web_tip_id = ?',  tip_id], :order => 'insert_number')
          if  @WebInsertion.blank? then       
            tip_text
                  
          else
            
            insert_text(tip_text, @WebInsertion) 
          end       
      
      
      # display += "<tr><td> <BR></td></tr>"
# display
  end
  
  # insert text into text result and remove pointer.  PLan on making this more global as others added? This code is repeated in Web Text Results Helper
  def insert_text result, textResultInserts
    
     @manager ||= WWWebSessionManager.new(situation)
     @counter = 0
     @iStringPoint = 0
     @iOldStringPoint = @iStringPoint
     @WorkingText = result
     @addSpaces = 0
     
     #for each insertion as found in the insertion table
     textResultInserts.each do |web_insert| 
       
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
       
       if (@iOldStringPoint == @iStringPoint)  && !(result.index(@sMarker, 0).blank?) then
         
          @iStringPoint = result.index(@sMarker, 0) 
          
          
          @WorkingText = result[0, @iStringPoint - (web_insert.insert_marker.length - 1)]
          @WorkingText = @WorkingText + @calcResult
          @WorkingText = @WorkingText + result[(@iStringPoint + (web_insert.insert_marker.length)), (result.length + web_insert.insert_marker.length)]
                    
          @iOldStringPoint =  @iStringPoint + 1
      
       elsif !(result.index(@sMarker, 0).blank?)
         
         @iStringPoint = @WorkingText.index(@sMarker, @iOldStringPoint) 
         
         #this zero may not work with more than 2 insertions, review later
         @partOneText = @WorkingText[0, (@iStringPoint)]
         
         #this is the text betweeen the insertion points
         @partTwoText = @WorkingText[(@iStringPoint + web_insert.insert_marker.length), (result.length + @addSpaces) ]
         #@newWorkingText = 
         @WorkingText = @partOneText  + @calcResult + @partTwoText
      
      else
          @WorkingText = result + "missinng marker"  
      
       end
            
    end
    
    @rString =  @WorkingText 
    #@rString =  "testing"
  end
end
