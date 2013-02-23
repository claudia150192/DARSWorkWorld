require 'spec_helper'

describe Case do
  describe '#create' do
    before(:each) do
      @user = Factory(:user)
    end

    it "should create a new instance given valid attributes" do
      Factory(:case, :user => @user)
    end
  
    it "should require a user" do
      @case = Factory.build(:case)
      @case.should have(1).errors_on(:user_id)
    end
    
    it "should check uniqueness of name and return an error if not unique per user" do
      Factory(:case, :user => @user)
      @case = Factory.build(:case, :user => @user)
      @case.should have(1).errors_on(:name)
    end
    
    it "should check uniqueness of name and validate if unique per user" do
      Factory(:case, :user => @user)
      @case = Factory.build(:case, :name => 'another case', :user => @user)
      @case.should have(0).errors_on(:name)
    end
    
    it "should check uniqueness of name and validate if different users" do
      Factory(:case, :user => @user)
      @another_user =  Factory(:another_user)
      @case = Factory.build(:case, :user => @another_user)
      @case.should have(0).errors_on(:name)
    end

    it "should have a current_situation" do
      @case = Factory(:case, :user=>@user)
      @case.current_situation.blank?.should be_false
    end
  end

  describe '#situations' do
    before(:each) do
      @user = Factory(:user)
      @case = Factory(:case, :user=>@user)
    end

    it 'should not accept any what-if scenarios if the current_situation is not completed' do
      @situation = Factory(:situation, :case=>@case, :situation_type=>Situation::TYPES[:what_if])
      @case.should have(1).errors_on(:situations)
    end

    it 'should allow a what-if scenario if the current_situation is completed' do
      @case.current_situation.complete!
      @situation = Factory(:situation, :case=>@case, :situation_type=>Situation::TYPES[:what_if])
      @case.should have(0).errors_on(:situations)
    end

    it 'should allow only four what_if scenarios' do
      @case.current_situation.complete!
      @sit_one = Factory(:situation, :case=>@case, :situation_type=>Situation::TYPES[:what_if])
      @sit_two = Factory(:situation, :case=>@case, :situation_type=>Situation::TYPES[:what_if])
      @sit_three = Factory(:situation, :case=>@case, :situation_type=>Situation::TYPES[:what_if])
      @sit_four = Factory(:situation, :case=>@case, :situation_type=>Situation::TYPES[:what_if])
      @sit_five = Factory(:situation, :case=>@case, :situation_type=>Situation::TYPES[:what_if])
      @case.should have(1).errors_on(:situations)
    end

    it 'should only allow adding what-ifs' do
      @case.current_situation.complete!
      @another_current = Factory(:situation, :case=>@case, :situation_type=>Situation::TYPES[:current_situation])
      @case.should have(1).errors_on(:situations)
    end
  end
end
