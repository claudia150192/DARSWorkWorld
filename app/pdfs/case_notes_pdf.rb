class CaseNotesPdf < BaseCasesPdf
  def initialize kase, groups, view
    @case = kase
    @groups = groups
#    @view = view
    super "Case Notes", view do 
      text get_notes kase
    end

  end
  def get_notes kase
    kase.notes || "" #leaving this as an array just incase
  end

end

