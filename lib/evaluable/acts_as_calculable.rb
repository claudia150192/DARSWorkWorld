require 'evaluable/acts_as_evaluable'

module Calculable
  def self.included(base)
    base.send :extend, ClassMethods
  end

  module ClassMethods
    def acts_as_calculable(options = {})
      send :acts_as_evaluable
      send :validate, :operation_should_evaluate
      send :include, InstanceMethods
    end
  end

  module InstanceMethods
    # perform calculation operation
    # 
    # ==== Parameters
    #
    # * <tt>:manager</tt> - WwwebSessionManager instance
    def calculate manager
      eval(self.operation)
    end

    # validate operation format
    # allowed values are  any ruby code that evaluates
    def operation_should_evaluate
      result = check_eval_syntax operation
      errors.add(:operation, "should be proper ruby code. #{result[:exception]}") unless result[:exception].blank? || result[:result] == 0
    end
  end
end

ActiveRecord::Base.send :include, Calculable