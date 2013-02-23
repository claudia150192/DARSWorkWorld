class UpdateQuestionUserIsCaidCommunitySpouseForWorkbookOrderAndReferenceNumber < ActiveRecord::Migration
  def self.up
    
    #45	56.5	Are you considered for Medicaid purposes to be a "community spouse"?	UserIsCaidCommunitySpouse			YES:NO		NO	IF VA_CaidSpouseApplyCoveredGroup = (Medical Instition OR Waiver) AND (LiveWithSpouseInFacility <> Y AND LiveInFacility <> Y) 	no		If spouse is applying for Long Term Care (Medical Institution or Waiver), then the resources of a Community Spouse are considered when determining initial eligibility.	57.50
    
    @UserIsCaidCommunitySpouse                  = Question.find(:first, :conditions => ['name = ?',  'UserIsCaidCommunitySpouse'])
    @UserIsCaidCommunitySpouse.update_attribute(:workbook_order, "57.50")   unless @UserIsCaidCommunitySpouse.blank?
    @UserIsCaidCommunitySpouse.update_attribute(:reference_id, "56.5")   unless @UserIsCaidCommunitySpouse.blank?

  end

  def self.down
  end
end
