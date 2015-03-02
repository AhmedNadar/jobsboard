class Job < ActiveRecord::Base

  # default_scope -> { order(created_at: :desc) }
  scope :most_recent, -> { order('created_at DESC') }

  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  # validation
  validates_presence_of :title, :description, :url, :company_id
  validates_uniqueness_of :url
  validates_presence_of :url, url: true

  def should_generate_new_friendly_id?
    title_changed?
  end

  # associations
  # belongs_to :user
  belongs_to :company
end
