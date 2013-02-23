require 'spec_helper'
require 'cancan/matchers'

describe Ability do
  before(:each) do
    @user = Factory(:user)
    @admin = Factory(:admin)
  end

  it "should only be able to delete himself if he is not an admin user" do
    ability = Ability.new(@user)
    ability.should be_able_to(:destroy, @user)
    ability.should_not be_able_to(:destroy, @admin)
  end

  it "should be able to delete anyone if he is an admin user" do
    ability = Ability.new(@admin)
    ability.should be_able_to(:destroy, @user)
  end

end
