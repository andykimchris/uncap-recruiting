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
          overpaid_amount = get_overpaid_amount!(repayments, amount_received_from_payment)
          reallocate_amount!(repayments, overpaid_amount, date_received)

          repayments
        end

        def get_overpaid_amount!(repayments, amount_received_from_payment)
          # YOUR CODE HERE  
        end

        def reallocate_amount!(repayments, amount, date_received)
          # YOUR CODE HERE
        end

      end
    end
  end
end
