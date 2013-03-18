class WebTextResultsGroup < ActiveRecord::Base
  validates_presence_of :name, :order
  validates_uniqueness_of :name
  has_many :text_results, :class_name => "WebTextResult", :foreign_key => "group_id", :uniq => true, :dependent => :destroy, :autosave => true#, :order => "web_text_results.order ASC"
  
  # figure out if group should show
  # if at least one text result in the group shows, then groups should show
  # 
  # ==== Parameters
  #
  # * <tt>:situation</tt> - a hash of the answers grouped for each group/question, <tt>{ :groups => { "group one" => { :id => 1, :questions => { "question 1" => "answer 1", "question 2" => "answer 2" }}}}</tt>.
  def show? situation
    self.text_results.each do |result|
      if result.show? situation
        return true
      end
    end
    false
  end
end
