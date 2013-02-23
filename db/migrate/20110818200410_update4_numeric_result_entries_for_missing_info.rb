class Update4NumericResultEntriesForMissingInfo < ActiveRecord::Migration
  def self.up
  
  
    #    515 Webcalcs R_SsdiPayAllAdjustButCareBAmt
    #    1085 webcalcs R_SpouseSsdiPayAllAdjustButCareBAmt
    #   2930 Webcalcs R_SsiUserOverUnderAdjustCalcAmt
    #   2940 Webcalc R_SsiCoupleOverUnderAdjustCalcAmt
    
    
    @R_SsdiPayAllAdjustButCareBAmt  = WebCalc.find_by_name('R_SsdiPayAllAdjustButCareBAmt')
    @R_SpouseSsdiPayAllAdjustButCareBAmt  = WebCalc.find_by_name('R_SpouseSsdiPayAllAdjustButCareBAmt')
    @R_SsiUserOverUnderAdjustCalcAmt  = WebCalc.find_by_name('R_SsiUserOverUnderAdjustCalcAmt')
    @R_SsiCoupleOverUnderAdjustCalcAmt  = WebCalc.find_by_name('R_SsiCoupleOverUnderAdjustCalcAmt')
    
    
    @TotR_SsdiPayAllAdjustButCareBAmt = WebNumericalResult.find_by_name('TotR_SsdiPayAllAdjustButCareBAmt') 
    @TotR_SsdiPayAllAdjustButCareBAmt.update_attribute(:result_type, "currency_detail")  unless @TotR_SsdiPayAllAdjustButCareBAmt.blank?
    @TotR_SsdiPayAllAdjustButCareBAmt.update_attribute(:web_calc_id, @R_SsdiPayAllAdjustButCareBAmt.id) unless @TotR_SsdiPayAllAdjustButCareBAmt.blank? && @R_SsdiPayAllAdjustButCareBAmt.blank?
    
    @TotR_SpouseSsdiPayAllAdjustButCareBAmt = WebNumericalResult.find_by_name('TotR_SpouseSsdiPayAllAdjustButCareBAmt') 
    @TotR_SpouseSsdiPayAllAdjustButCareBAmt.update_attribute(:result_type, "currency_detail")  unless @TotR_SpouseSsdiPayAllAdjustButCareBAmt.blank?
    @TotR_SpouseSsdiPayAllAdjustButCareBAmt.update_attribute(:web_calc_id, @R_SpouseSsdiPayAllAdjustButCareBAmt.id) unless @TotR_SpouseSsdiPayAllAdjustButCareBAmt.blank? && @R_SpouseSsdiPayAllAdjustButCareBAmt.blank?
    
    @TotR_SsiUserOverUnderAdjustCalcAmt = WebNumericalResult.find_by_name('TotR_SsiUserOverUnderAdjustCalcAmt') 
    @TotR_SsiUserOverUnderAdjustCalcAmt.update_attribute(:result_type, "currency_detail")  unless @TotR_SsiUserOverUnderAdjustCalcAmt.blank?
    @TotR_SsiUserOverUnderAdjustCalcAmt.update_attribute(:web_calc_id, @R_SsiUserOverUnderAdjustCalcAmt.id) unless @TotR_SsiUserOverUnderAdjustCalcAmt.blank? && @R_SsiUserOverUnderAdjustCalcAmt.blank?
    
    @TotR_SsiCoupleOverUnderAdjustCalcAmt = WebNumericalResult.find_by_name('TotR_SsiCoupleOverUnderAdjustCalcAmt') 
    @TotR_SsiCoupleOverUnderAdjustCalcAmt.update_attribute(:result_type, "currency_detail")  unless @TotR_SsiCoupleOverUnderAdjustCalcAmt.blank?
    @TotR_SsiCoupleOverUnderAdjustCalcAmt.update_attribute(:web_calc_id, @R_SsiCoupleOverUnderAdjustCalcAmt.id) unless @TotR_SsiCoupleOverUnderAdjustCalcAmt.blank? && @R_SsiCoupleOverUnderAdjustCalcAmt.blank?
    
    
    
  end

  def self.down
  end
end
