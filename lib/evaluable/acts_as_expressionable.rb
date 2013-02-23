require 'evaluable/acts_as_evaluable'

module Expressionable
  def self.included(base)
    base.send :extend, ClassMethods
  end

  module ClassMethods
    def acts_as_expressionable(options = {})
      unless options[:fields].blank?
        cattr_accessor :expressionable_fields
        self.expressionable_fields = options[:fields]
        send :acts_as_evaluable
        send :validate, :expression_should_evaluate
        send :include, InstanceMethods
      end
    end
  end

  module InstanceMethods
    # check if the valude of the field is an expression
    # by checking if it contains the 'expression=' at the beginning
    # 
    # ==== Parameters
    #
    # * <tt>:field_name</tt> - symbol
    def is_expression? field_name
      value = send(field_name.to_sym)
      !value.blank? && value.index("expression=") == 0
    end
    
    # return the expression value
    # 
    # ==== Parameters
    #
    # * <tt>:field_name</tt> - symbol
    def expression field_name
      value = send(field_name.to_sym)
      value.gsub(/expression=/, "")
    end
    
    # evaluate the expression of the field if it is an expression
    # 
    # ==== Parameters
    #
    # * <tt>:field_name</tt> - symbol
    # * <tt>:situation</tt> - a hash of the answers grouped for each group/question, <tt>{ :groups => { "group one" => { :id => 1, :questions => { "question 1" => { :answer => "answer 1"}, "question 2" => { :answer => "answer 2" } }}}}</tt>.
    def eval_expression field_name, situation = {}
      manager = WWWebSessionManager.new(situation)
      if is_expression? field_name
        eval(expression(field_name))
      end
    end
    
    # return the value of the field
    # either the string value or the evaluated expression
    # 
    # ==== Parameters
    #
    # * <tt>:field_name</tt> - symbol
    # * <tt>:situation</tt> - a hash of the answers grouped for each group/question, <tt>{ :groups => { "group one" => { :id => 1, :questions => { "question 1" => { :answer => "answer 1"}, "question 2" => { :answer => "answer 2" } }}}}</tt>.
    def attribute_value field_name, situation = {}
      if is_expression? field_name
        eval_expression field_name, situation
      else
        send(field_name.to_sym)
      end
    end

    # validate operation format
    # allowed values are  any ruby code that evaluates
    def expression_should_evaluate
      expressionable_fields.each do |field|
        if is_expression?(field.to_sym)
          result = check_eval_syntax expression(field.to_sym)
          errors.add(field.to_sym, "should be proper ruby code. #{result[:exception]}") unless result[:exception].blank? || result[:result] == 0
        end
      end
    end
  end
end

ActiveRecord::Base.send :include, Expressionable