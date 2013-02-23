class AddDataToWebTipsOrderField2 < ActiveRecord::Migration

    def self.up
  #    @rate = FederalRate.find(:first, :conditions => ['start_date > ? AND end_date < ?',  Date.new(2011,01,01), Date.new(2012,01,01)])
      @web_tip_webTipCSI1a = WebTip.find(:first, :conditions => ['identifier = ?',  'webTipCSI1a'])
      @web_tip_webTipCSI1a.update_attribute(:order, '1') unless @web_tip_webTipCSI1a.blank?

      @web_tip_webTipCSI1b = WebTip.find(:first, :conditions => ['identifier = ?',  'webTipCSI1b'])
      @web_tip_webTipCSI1b.update_attribute(:order, '2') unless @web_tip_webTipCSI1b.blank?

      @web_tip_webTipBlindTest = WebTip.find(:first, :conditions => ['identifier = ?',  'webTipBlindTest'])
      @web_tip_webTipBlindTest.update_attribute(:order, '3') unless @web_tip_webTipBlindTest.blank?

      @web_tip_webTipNotBlindTest = WebTip.find(:first, :conditions => ['identifier = ?',  'webTipNotBlindTest'])
      @web_tip_webTipNotBlindTest.update_attribute(:order, '4') unless @web_tip_webTipNotBlindTest.blank?

      @web_tip_CSABirthDate2 = WebTip.find(:first, :conditions => ['identifier = ?',  'CSABirthDate2'])
      @web_tip_CSABirthDate2.update_attribute(:order, '5') unless @web_tip_CSABirthDate2.blank?

      @web_tip_CSABirthDate3 = WebTip.find(:first, :conditions => ['identifier = ?',  'CSABirthDate3'])
      @web_tip_CSABirthDate3.update_attribute(:order, '6') unless @web_tip_CSABirthDate3.blank?

      @web_tip_CSASitDate1 = WebTip.find(:first, :conditions => ['identifier = ?',  'CSASitDate1'])    
      @web_tip_CSASitDate1.update_attribute(:order, '7') unless @web_tip_CSASitDate1.blank?

      @web_tip_CSAState1 = WebTip.find(:first, :conditions => ['identifier = ?',  'CSAState1'])
      @web_tip_CSAState1.update_attribute(:order, '8') unless @web_tip_CSAState1.blank?

      @web_tip_CSADisability1 = WebTip.find(:first, :conditions => ['identifier = ?',  'CSADisability1'])
      @web_tip_CSADisability1.update_attribute(:order, '9') unless @web_tip_CSADisability1.blank?
    end

    def self.down


      @web_tip_CSADisability1 = WebTip.find(:first, :conditions => ['identifier = ?',  'CSADisability1'])
      @web_tip_CSADisability1.update_attribute(:order, '') unless @web_tip_CSADisability1.blank?

      @web_tip_CSAState1 = WebTip.find(:first, :conditions => ['identifier = ?',  'CSAState1'])
      @web_tip_CSAState1.update_attribute(:order, '') unless @web_tip_CSAState1.blank?

      @web_tip_CSASitDate1 = WebTip.find(:first, :conditions => ['identifier = ?',  'CSASitDate1'])    
      @web_tip_CSASitDate1.update_attribute(:order, '') unless @web_tip_CSASitDate1.blank?

      @web_tip_CSABirthDate3 = WebTip.find(:first, :conditions => ['identifier = ?',  'CSABirthDate3'])
      @web_tip_CSABirthDate3.update_attribute(:order, '') unless @web_tip_CSABirthDate3.blank?

      @web_tip_CSABirthDate2 = WebTip.find(:first, :conditions => ['identifier = ?',  'CSABirthDate2'])
      @web_tip_CSABirthDate2.update_attribute(:order, '') unless @web_tip_CSABirthDate2.blank?

      @web_tip_webTipNotBlindTest = WebTip.find(:first, :conditions => ['identifier = ?',  'webTipNotBlindTest'])
      @web_tip_webTipNotBlindTest.update_attribute(:order, '') unless @web_tip_webTipNotBlindTest.blank?

      @web_tip_webTipBlindTest = WebTip.find(:first, :conditions => ['identifier = ?',  'webTipBlindTest'])
      @web_tip_webTipBlindTest.update_attribute(:order, '') unless @web_tip_webTipBlindTest.blank?

      @web_tip_webTipCSI1b = WebTip.find(:first, :conditions => ['identifier = ?',  'webTipCSI1b'])
      @web_tip_webTipCSI1b.update_attribute(:order, '') unless @web_tip_webTipCSI1b.blank?

      @web_tip_webTipCSI1a = WebTip.find(:first, :conditions => ['identifier = ?',  'webTipCSI1a'])
     @web_tip_webTipCSI1a.update_attribute(:order, '') unless @web_tip_webTipCSI1a.blank?

    end
  end
