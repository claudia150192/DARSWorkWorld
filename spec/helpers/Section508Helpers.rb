module Section508Helpers
  def images_have_alt_text
    # all images should have alt text or longdesc, but not both. Alts can be empty.
  end

  def image_maps_have_alt_text
    # all image map area tags should have title or alt, but not both
  end

  def image_inputs_have_alt_text
    # has to have a text alternative to identify purpose
  end

  def correct_color_contrast
    # need to figure out how to test item C2-4
  end

  def disabling_css
    # again, not sure how to test D1-D7; probably need to be manual checks.
  end

  def check_tables
    # the G & H series checks on table headings and summary fields
  end

  def check_frames
    # I tests, iframes have titles and frames have noframes
  end

  def check_no_javascript
    # L series tests, that content provided via javascript is available w/o javascript
  end

  def check_forms
    # all inputs must have a label or title
    # all cues for filling in the forms (e.g. mandatory fields) available to users w/ assistive technologies?
    # logically related fields in fieldset with legend
    # form validation errors expressed in text that's available to assistive technologies
  end

  def check_navigation_and_sections
    # skip links rules O1-5 and logical sections
  end

  def timing
    # a lot of these are subjective, but P8 might be hard; what happens if an auth session expires, can the user continue w/o losing data??  I have no idea how to do that w/o javascript
  end
end
