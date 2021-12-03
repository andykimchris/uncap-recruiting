# frozen_string_literal: true

class UserProfile < ApplicationRecord
  HUMAN_GENDERS = {
    unknown: '',
    male: 'Male',
    female: 'Female',
    diverse: 'Diverse',
    prefer_not_to_say: 'Prefer not to say'
  }.freeze

  belongs_to :user
  belongs_to :country, optional: true
  enum gender: { unknown: 0, male: 1, female: 2, diverse: 3, prefer_not_to_say: 4 }
  has_one_attached :avatar

  def full_name
    "#{first_name} #{last_name}"
  end

  class << self
    def human_readable_genders
      HUMAN_GENDERS.map do |gender, human_readable_gender|
        OpenStruct.new(gender: gender, human_readable_gender: human_readable_gender)
      end
    end
  end
end
