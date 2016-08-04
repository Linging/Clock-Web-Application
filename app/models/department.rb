class Department < ActiveRecord::Base
  belongs_to :corperation
  has_many :employees, dependent: :destroy
  validates :corperation_id, presence: true
  validates :name, presence: true, length: { maximum: 16 }
end
