class FixRIncAvailForPassNoPassAmtWebcalcForMinToMax < ActiveRecord::Migration
  def self.up
    @RIncAvailForPassNoPassAmt  = WebCalc.find_by_name('RIncAvailForPassNoPassAmt')
    if @RIncAvailForPassNoPassAmt.blank? then
      @RIncAvailForPassNoPassAmt  = WebCalc.new(:name => 'RIncAvailForPassNoPassAmt')
    end
      
    @RIncAvailForPassNoPassAmt.update_attribute(:operation, 
    "R_SsdiPayAllAdjustButCareBAmt = WebCalc.find_by_name('R_SsdiPayAllAdjustButCareBAmt')
    R_SsdiPayAllAdjustButCareBAmt = Float(R_SsdiPayAllAdjustButCareBAmt.calculate manager)
    R_SpouseSsdiPayAllAdjustButCareBAmt = WebCalc.find_by_name('R_SpouseSsdiPayAllAdjustButCareBAmt')
    R_SpouseSsdiPayAllAdjustButCareBAmt = Float(R_SpouseSsdiPayAllAdjustButCareBAmt.calculate manager)
    SsiOrCaidEarnAmt = manager.get_answer_by_question_name('SsiOrCaidEarnAmt')
    UnearnAmt  = manager.get_answer_by_question_name('UnearnAmt')
    SpouseUnEarnAmt = manager.get_answer_by_question_name('SpouseUnEarnAmt')
    SsiOrCaidEarnAmt = manager.get_answer_by_question_name('SsiOrCaidEarnAmt')
    SpouseSsiOrCaidEarnAmt = manager.get_answer_by_question_name('SpouseSsiOrCaidEarnAmt')
    InKindPMVAmt = manager.get_answer_by_question_name('InKindPMVAmt')
    SsiSpouseDeemUnearnAmt = manager.get_answer_by_question_name('SsiSpouseDeemUnearnAmt')
    SsiSpouseDeemEarnAmt = manager.get_answer_by_question_name('SsiSpouseDeemEarnAmt')
    SsiParDeemAmt = manager.get_answer_by_question_name('SsiParDeemAmt')
    SsiCaidIrweAmt = manager.get_answer_by_question_name('SsiCaidIrweAmt')
    BweAmt = WebCalc.find_by_name('BweAmt')
    SpouseSsiCaidIrweAmt = manager.get_answer_by_question_name('SpouseSsiCaidIrweAmt')
    SpouseBweAmt = manager.get_answer_by_question_name('SpouseBweAmt')
    returnVar = 0.0
    returnVar = R_SsdiPayAllAdjustButCareBAmt + R_SpouseSsdiPayAllAdjustButCareBAmt + UnearnAmt.to_f + SpouseUnEarnAmt.to_f + SsiOrCaidEarnAmt.to_f + SpouseSsiOrCaidEarnAmt.to_f + InKindPMVAmt.to_f + SsiSpouseDeemUnearnAmt.to_f + SsiSpouseDeemEarnAmt.to_f + SsiParDeemAmt.to_f
    returnVar = [(returnVar -  SsiCaidIrweAmt.to_f + BweAmt.to_f + SpouseSsiCaidIrweAmt.to_f + SpouseBweAmt.to_f), 0].max
    ")
  end

  def self.down
  end
end
