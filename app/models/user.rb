# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :secure_validatable, :invitable, :database_authenticatable, :rememberable, :registerable, :confirmable,
         :recoverable
  has_one :user_profile, dependent: :destroy
  has_one :identity_verification, dependent: :destroy
  has_many :user_permissions, dependent: :destroy
  has_many :message_recipients, foreign_key: 'recipient_id', dependent: :destroy
  has_many :organizations, through: :user_permissions
  has_many :application_tests, dependent: :restrict_with_error
  has_one :application, foreign_key: 'initiator_id', dependent: :restrict_with_error

  delegate :first_name, :last_name, to: :user_profile

  def authorize(password)
    return nil unless valid_password?(password)
    return nil unless confirmed?

    self
  end

  def invitation_pending?
    invitation_token? && !confirmed?
  end

  def permission_for_organization(organization_id)
    user_permissions.where(organization_id: organization_id).first&.permission
  end
end
