class TimeSet < ActiveRecord::Base
  belongs_to :corperation
  validates :corperation_id, presence: true,uniqueness: true
end
