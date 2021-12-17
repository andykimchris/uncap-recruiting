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

          excess_amounts = repayments.select { |repayment| repayment.amount_received > repayment.amount }
           
          if excess_amounts.any?
            total_excess_payments = amount_received_from_payment + excess_amounts.pluck(:amount_received).sum
            
            repayments.each do |repayment|
              if repayment.amount > repayment.amount_received
                balancing_amount = repayment.amount - repayment.amount_received

                unless total_excess_payments > balancing_amount
                  break
                end
                
                total_excess_payments -= balancing_amount
                repayment.update(amount_received: repayment.amount, date_received: date_received)
              end
            end
            repayments.last.update(amount_received: total_excess_payments) if total_excess_payments > 0
          else
            # NOTE: Assumption is to update last repayment or create new repayment
            repayments.last.update(amount_received: amount_received_from_payment)
          end
        
          repayments
        end

      end
    end
  end
end
