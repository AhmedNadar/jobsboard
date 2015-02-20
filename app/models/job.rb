class Job < ActiveRecord::Base

  default_scope -> { order(created_at: :desc) }

  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  # validation
  validates_presence_of :title, :company, :url
  validates_uniqueness_of :url

  def should_generate_new_friendly_id?
    title_changed?
  end
end
