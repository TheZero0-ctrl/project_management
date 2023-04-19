class Task < ApplicationRecord
  belongs_to :project
  has_many :task_assignments, dependent: :destroy
  has_many :assigned_users, through: :task_assignments, source: :user

  has_rich_text :description

  enum priority: {
    low: 'low',
    medium: 'medium',
    high: 'high'
  }
end
