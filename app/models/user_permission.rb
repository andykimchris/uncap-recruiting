# frozen_string_literal: true

class UserPermission < ApplicationRecord
  belongs_to :user
  belongs_to :organization
  belongs_to :permission
  validates :user, :permission, :organization, presence: true
end
