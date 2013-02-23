class UpdateSeveralQuestionsTextForPuttingRecieveAndEarnInAllCaps < ActiveRecord::Migration
  def self.up
    #47	DJR	6/23/2011	In WebQuest 102, 103, 103.5, 107, 108, 108.5 revised text to have  RECEIVE and EARN show in ALL CAPS.
     #102 29 47	102	How much do you EARN monthly in gross wages, salary or self-employment? [NOTE: Select "Help" for difference between Earn & Receive.]	SsdiEarnAmt
     #103 25 47	103	How much do you RECEIVE monthly in gross wages, salary or self-employment? [NOTE: Select "Help" for difference between Earn & Receive.]	SsiOrCaidEarnAmt
     #103.5 46 47	103.5	How much of the ~$SsiOrCaidEarnAmt~ you RECEIVE is infrequent or irregular?	EarnInfrequentAmt
     #107 25 47	107	How much monthly income from wages, salary or self-employment does your spouse EARN? [NOTE: Select "Help" for difference between Earn & Receive.] 	SpouseSsdiEarnAmt
     #108 25 47	108	How much monthly income from wages, salary or self-employment does your spouse RECEIVE? [NOTE: Select "Help" for difference between Earn & Receive.] 	SpouseSsiOrCaidEarnAmt
     #108.5 46 47	108.5	How much of the ~$SpouseSsiOrCaidEarnAmt~ that your spouse RECEIVES is infrequent or irregular?	SpouseEarnInfrequentAmt
          
     require 'wwweb_session_manager'  
   #102
    @SsdiEarnAmt = Question.find(:first, :conditions => ['name = ?',  'SsdiEarnAmt']) 
    @SsdiEarnAmt.update_attribute(:text, 'How much do you EARN monthly in gross wages, salary or self-employment? [NOTE: Select "Help" for difference between Earn & Receive.]') unless @SsdiEarnAmt.blank?
    #103
    @SsiOrCaidEarnAmt = Question.find(:first, :conditions => ['name = ?',  'SsiOrCaidEarnAmt']) 
    @SsiOrCaidEarnAmt.update_attribute(:text, 'How much do you RECEIVE monthly in gross wages, salary or self-employment? [NOTE: Select "Help" for difference between Earn & Receive.]') unless @SsiOrCaidEarnAmt.blank?
    #103.5
    @EarnInfrequentAmt = Question.find(:first, :conditions => ['name = ?',  'EarnInfrequentAmt']) 
    @EarnInfrequentAmt.update_attribute(:text, "How much of the ~ you RECEIVE is infrequent or irregular?") unless @EarnInfrequentAmt.blank?
    #107
    @SpouseSsdiEarnAmt = Question.find(:first, :conditions => ['name = ?',  'SpouseSsdiEarnAmt']) 
    @SpouseSsdiEarnAmt.update_attribute(:text, 'How much monthly income from wages, salary or self-employment does your spouse EARN? [NOTE: Select "Help" for difference between Earn & Receive.]') unless @SpouseSsdiEarnAmt.blank?
    #108
    @SpouseSsiOrCaidEarnAmt = Question.find(:first, :conditions => ['name = ?',  'SpouseSsiOrCaidEarnAmt']) 
    @SpouseSsiOrCaidEarnAmt.update_attribute(:text, 'How much monthly income from wages, salary or self-employment does your spouse RECEIVE? [NOTE: Select "Help" for difference between Earn & Receive.]') unless @SpouseSsiOrCaidEarnAmt.blank?



#    #108.5  Well this question has not been created yet, will do this in another migration
#    @SpouseEarnInfrequentAmt = Question.find(:first, :conditions => ['name = ?',  'SpouseEarnInfrequentAmt']) 
#    @SpouseEarnInfrequentAmt.update_attribute(:text, "How much of the ~ that your spouse RECEIVES is infrequent or irregular?") unless @SpouseEarnInfrequentAmt.blank?
  end

  def self.down
  end
end
