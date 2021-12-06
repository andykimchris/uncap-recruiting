# frozen_string_literal: true

module Uncap
  module Repayment
    module UseCases
      class BalanceRepayments
        # NOTE: This method MUTATES the repayments objects!
        def call(repayments:, date_received:, amount_received_from_payment:)
          balance_repayments!(repayments, date_received, amount_received_from_payment)
        end

        private

        def balance_repayments!(repayments, date_received, amount_received_from_payment)
          # YOUR CODE HERE
          
          repayments
        end

      end
    end
  end
end
