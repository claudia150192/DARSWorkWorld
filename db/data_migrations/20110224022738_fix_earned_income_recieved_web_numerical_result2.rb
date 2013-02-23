class FixEarnedIncomeRecievedWebNumericalResult2 < ActiveRecord::Migration

    def self.up
      @web_numerical_result_Earned_Income_Received_Self = WebNumericalResult.find_by_name('   Earned Income Received (Self)')
      @web_numerical_result_Earned_Income_Received_Self.update_attribute(:result_type, 'currency_detail') unless @web_numerical_result_Earned_Income_Received_Self.blank?
      @web_numerical_result_Earned_Income_Received_Self.update_attribute(:name, 'Earned_Income_Received_Self') unless @web_numerical_result_Earned_Income_Received_Self.blank?
    end

    def self.down

      @web_numerical_result_Earned_Income_Received_Self = WebNumericalResult.find_by_name('Earned_Income_Received_Self')
      @web_numerical_result_Earned_Income_Received_Self.update_attribute(:result_type, '') unless @web_numerical_result_Earned_Income_Received_Self.blank?
      @web_numerical_result_Earned_Income_Received_Self.update_attribute(:name, '   Earned Income Received (Self)') unless @web_numerical_result_Earned_Income_Received_Self.blank?

    end
  end
