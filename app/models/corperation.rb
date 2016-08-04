class Corperation < ActiveRecord::Base
  has_many :departments, dependent: :destroy
  has_many :users
  has_many :calendars
  has_one :time_sets
  validates :name, presence: true, length: { maximum: 16 }
  validates :mac, presence: true, length: { is:17 }
 
end
