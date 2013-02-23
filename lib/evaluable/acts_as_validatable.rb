require 'evaluable/acts_as_evaluable'

module Validatable
  def self.included(base)
    base.send :extend, ClassMethods
  end

  module ClassMethods
    def acts_as_validatable(options = {})
      attr_accessor :validation_errors
      send :acts_as_evaluable
      send :validate, :validation_rules_should_evaluate
      send :include, InstanceMethods
    end
  end

  module InstanceMethods
    def validation_errors
      @validation_errors ||= []
    end

    # check if question has any validation errors
    def has_validation_errors?
      !validation_errors.blank?
    end

    # add error message to array if not already in there
    # 
    # ==== Parameters
    #
    # * <tt>:group</tt> - the group being displayed
    # * <tt>:situation</tt> - a hash of the answers grouped for each group/question, <tt>{ :groups => { "group one" => { :id => 1, :questions => { "question 1" => { :answer => "answer 1"}, "question 2" => { :answer => "answer 2" } }}}}</tt>.
    def add_error_message message
      if validation_errors.blank?
        self.validation_errors = [message]
      elsif !validation_errors.include? message
        self.validation_errors << message
      end
    end


    # evaluate validation rules and figure out if answer given is valid
    # if answer is not valid, add validation message to validation error messages
    # if answer is valid, make sure validation error messages is empty
    # 
    # ==== Parameters
    #
    # * <tt>:situation</tt> - a hash of the answers grouped for each group/question, <tt>{ :groups => { "group one" => { :id => 1, :questions => { "question 1" => { :answer => "answer 1"}, "question 2" => { :answer => "answer 2" } }}}}</tt>.
    def validates? situation ={}
      unless validation_rules.blank? 
        manager = WWWebSessionManager.new(situation)
        unless eval(validation_rules)
          add_error_message validation_message
          return false
        end
      end
      self.validation_errors = []
      true
    end

    # validate validation_rules format
    # allowed values are '' (empty string), 'always', or any ruby code that evaluates to true or false
    def validation_rules_should_evaluate
      result = check_eval_syntax validation_rules
      errors.add(:validation_rules, "should be proper ruby code and evaluate to true or false. #{result[:exception]}") unless
      validation_rules.blank? || validation_rules == "always" || result[:result] == true || result[:result] == false
    end
  end
end

ActiveRecord::Base.send :include, Validatable