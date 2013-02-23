class Chart < ActiveRecord::Base
  validates_presence_of :title, :chart_type
  has_many :series, :class_name=>"ChartResult"

  TYPES = {:column=>"column", :bar=>"bar"}
  PDF_TYPES = %w[None Bar Line]
  STACK_TYPES = {:not_stacked =>"",:stacked=>"normal"}

  def idify
    self.title.gsub(/[ ]/,'').underscore
  end
end
