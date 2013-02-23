class Help < ActiveRecord::Base
  validates_uniqueness_of :topic
  validates_presence_of :body, :topic
end
