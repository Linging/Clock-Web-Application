class Calendar < ActiveRecord::Base
  belongs_to :corperation
  validates :day, presence: true
  validates :corperation_id, presence: true
  # validate :valid_times, on: :update
  # def valid_times
    # params[:start] < params[:arrive] && params[:arrive] < params[:late]
  # end
end
