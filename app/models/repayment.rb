# frozen_string_literal: true

class Repayment < ApplicationRecord
  PERMITTED_CURRENCIES = ::Money::Currency.all.map(&:id).map(&:to_s).map(&:upcase).sort

  delegate :organization, to: :investment, allow_nil: true

  belongs_to :investment
  belongs_to :financial_report, optional: true

  validates :amount, :currency, :due_date, presence: true
  validate :amount_must_be_a_positive_number
  validate :amount_received_must_be_a_positive_number
  validate :amount_must_be_less_than1e12
  validate :amount_received_must_be_less_than1e12
  validate :payment_date_must_be_provided

  def amount_must_be_a_positive_number
    errors.add(:amount, I18n.t("admin.models.repayment.#{__method__}")) unless amount&.positive?
  end

  def amount_received_must_be_a_positive_number
    return if amount_received.blank? || amount_received&.positive?

    errors.add(:amount_received, I18n.t("admin.models.repayment.#{__method__}"))
  end

  def amount_must_be_less_than1e12
    return if amount && amount < 10**12

    errors.add(:amount, I18n.t("admin.models.repayment.#{__method__}"))
  end

  def amount_received_must_be_less_than1e12
    return if amount_received.blank? || amount_received && amount_received < 10**12

    errors.add(:amount_received, I18n.t("admin.models.repayment.#{__method__}"))
  end

  def payment_date_must_be_provided
    return if payment_date.present? || date_received.blank? && amount_received.blank?

    errors.add(:payment_date, I18n.t("admin.models.repayment.#{__method__}"))
  end

  def confirmable?
    financial_report_id.present? && payment_date.present? && date_received.blank?
  end

  def status
    return due_date < Date.current ? :overdue : :open if payment_date.blank?
    return :payment_made if amount_received.blank?

    amount_received >= amount ? :completed : :partially_completed
  end

  def missing_amount
    return amount if amount_received.nil?

    amount - amount_received
  end
end
