require 'evaluable/acts_as_evaluable'

module Displayable
  def self.included(base)
    base.send :extend, ClassMethods
  end

  module ClassMethods
    def acts_as_displayable(options = {})
      send :acts_as_evaluable
      send :validate, :display_rules_should_evaluate
      send :include, InstanceMethods
    end
  end

  module InstanceMethods

    # evaluate display rules and figure out if question should be shown/asked
    # 
    # ==== Parameters
    #
    def show? situation
      manager = WWWebSessionManager.new(situation)
      begin
        if display_rules == "always"
          self[:cache] = {:situation=>situation, :display=>true}
        else
          if self[:cache].blank? || self[:cache][:situation] != situation # todo: this may still be a problem if the answer has changed...
            self[:cache] = {:situation=>situation, :display=> eval(display_rules)}
          end
        end
        self[:cache][:display]
      rescue
        false
      end
      #end
    end

    # validate display_rules format
    # allowed values are 'always', or any ruby code that evaluates to true or false
    def display_rules_should_evaluate
      result = check_eval_syntax display_rules
      errors.add(:display_rules, "should be proper ruby code and evaluate to true or false. #{result[:exception]}") unless
      display_rules == "always" || result[:result] == true || result[:result] == false
    end
  end
end

ActiveRecord::Base.send :include, Displayable