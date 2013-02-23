# add an admin user if one doesn't exist
@ychaker = User.find_by_email('ychaker@o19s.com')
@ychaker = User.create!(:login => 'ychaker', :email => "ychaker@o19s.com", :password => "password", :password_confirmation => "password", :admin => true) if @ychaker.blank?

@bobc = User.find_by_email('vcubob@gmail.com')
@bobc = User.create!(:login => 'bobc', :email => "vcubob@gmail.com", :password => "password", :password_confirmation => "password", :admin => true) if @bobc.blank?

@davetest = User.find_by_email('pdbanks@vcu.edu')
@davetest = User.create!(:login => 'davetest', :email => "pdbanks@vcu.edu", :password => "password", :password_confirmation => "password", :admin => true) if @davetest.blank?

@djradmin = User.find_by_email('djruth@comcast.net')
@djradmin = User.create!(:login => 'djradmin', :email => "djruth@comcast.net", :password => "password", :password_confirmation => "password", :admin => true) if @djradmin.blank?

@jimtroxell = User.find_by_email('xort1111@aol.com')
@jimtroxell = User.create!(:login => 'jimtroxell', :email => "xort1111@aol.com", :password => "password", :password_confirmation => "password", :admin => true) if @jimtroxell.blank?
