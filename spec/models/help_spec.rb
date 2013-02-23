require 'spec_helper'

describe Help do
  before(:each) do
    Help.create!(:topic=>"fileshare", :body=>"Allowing file sharing will enable you to share some of your files with other users of ESI.  If you do plan to share your files with anyone else, check 'Allow Fileshare'. If you want others to 
    be able to share their files with you, check 'Receive Fileshare'.  Finally, if you want the ESI system to send you an email to notify you when someone else wants to share with you,
    check 'Receive Share Email'.")
  end

  it "should be findable by topic" do
    sharing = Help.find_by_topic("fileshare")
    sharing.should_not be_nil
  end

  it "should validate unique topic" do
    help = Help.new(:topic=>"fileshare")
    help.valid?.should be_false
  end

  it "should validate presence of topic" do
    help = Help.new
    help.valid?
    help.errors[:topic].should include("can't be blank")
  end

  it "should validate presence of body" do
    help = Help.new(:topic=>"jersey shore")
    help.valid?
    help.errors[:body].should include("can't be blank")
  end
end
