class TextResultInsert < ActiveRecord::Base
  validates_presence_of :web_text_result_id, :insert_number, :webcalc_id_to_insert
  belongs_to :web_text_result
  
end
