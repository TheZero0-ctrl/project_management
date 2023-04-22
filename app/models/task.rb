class Task < ApplicationRecord
  belongs_to :project
  has_many :task_assignments, dependent: :destroy
  has_many :assigned_users, through: :task_assignments, source: :user

  validates :name, :priority, presence: true
  # validates :latitude, numericality: { greater_than_or_equal_to:  -90, less_than_or_equal_to:  90 }
  # validates :longitude, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }

  has_rich_text :description

  default_scope { order(created_at: :desc) }

  enum priority: {
    low: 'low',
    medium: 'medium',
    high: 'high'
  }
end
