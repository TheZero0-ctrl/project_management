class Task < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :text_search,
                  against: %i[name],
                  using: {
                    tsearch: {
                      any_word: true,
                      prefix: true
                    }
                  }

  belongs_to :project
  has_many :task_assignments, dependent: :destroy
  has_many :assigned_users, through: :task_assignments, source: :user

  validates :name, :priority, presence: true
  validate :validate_file_type
  validates :latitude, numericality: { greater_than_or_equal_to:  -90, less_than_or_equal_to:  90 }
  validates :longitude, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }

  before_validation :lonlat_geo_point

  def validate_file_type
    return unless file.attached? && !file.content_type.in?(%w[image/jpeg image/png application/pdf video/mp4])

    errors.add(:file, 'must be an image (JPEG/PNG), PDF, or video (MP4) file')
  end

  has_rich_text :description
  has_one_attached :file

  enum priority: {
    low: 'low',
    medium: 'medium',
    high: 'high'
  }

  FILTER_PARAMS = %i[query priority sort project_id].freeze

  scope :for_priority, ->(priority) { priority.present? ? where(priority:) : all }
  scope :search, ->(query) { query.present? ? text_search(query) : all }
  scope :sorted, ->(selection) { selection.present? ? apply_sort(selection) : all }

  def self.apply_sort(selection)
    sort, direction = selection.split('-')
    order("tasks.#{sort} #{direction}")
  end

  def self.filter(filters)
    search(filters['query'])
      .for_priority(filters['priority'])
      .sorted(filters['sort'])
  end

  private

  def lonlat_geo_point
    self.lonlat = RGeo::Geographic.spherical_factory(srid: 4326).point(longitude, latitude)
  end
end
