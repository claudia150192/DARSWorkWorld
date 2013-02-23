module Evalubale
  def self.included(base)
    base.send :extend, ClassMethods
  end

  module ClassMethods
    def acts_as_evaluable(options = {})
      send :include, InstanceMethods
    end
  end

  module InstanceMethods
    # check syntax for fields to make sure user gets a graceful error message
    def check_eval_syntax syntax
      manager = WWWebSessionManager.new(Situation.new)
      manager.current_user = User.new
      result = ''
      exception = ''
      begin
        result = eval(syntax)
      rescue Exception => exc
        exception = exc
      end
      {:result => result, :exception => exc}
    end
  end
end

ActiveRecord::Base.send :include, Evalubale