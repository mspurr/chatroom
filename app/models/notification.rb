class Notification < ActiveRecord::Base
  belongs_to :user

  scope :for, ->(user) { where(user: user).order(created_at: :desc).limit(5) }
  scope :between, ->(from, to) { where('created_at BETWEEN ? AND ?', from, to) }
end
