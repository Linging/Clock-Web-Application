class Employee < ActiveRecord::Base
  belongs_to :department
  has_many :records , dependent: :destroy
  validates :mobile, presence: true, uniqueness: true
  validates :name, presence: true, length: { maximum: 16 }
  validates :mac, presence: true, length: { is:17 }

                  
end
 