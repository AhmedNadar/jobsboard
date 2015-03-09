class Company < ActiveRecord::Base

  # associations
  belongs_to :user
  has_many :jobs, dependent: :destroy
  accepts_nested_attributes_for :jobs,
    :reject_if => lambda { |a| a[:title].blank? },
    :allow_destroy => true

# validation
  validates_presence_of     :name,  :url, :location, :avatar, :email
  validates_uniqueness_of   :email, :url, case_sensitive: false

  VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_format_of       :email, with: VALID_EMAIL_REGEX , on: :create

  before_save {|company| company.email = email.downcase}
  scope :most_recent, -> { order('created_at DESC') }

  has_attached_file :avatar,
    # path: "/images/:id/:filename.:extension",
    path: "#{Rails.root}/assets/images/:filename",
    url: "#{Rails.root}/assets/images/:filename",
    # "/system/:class/:attachement/:id/:basename_:style.:extension",
    :styles => {
      :thumb    => ['100x100#',  :jpg, :quality => 70],
      :preview  => ['480x480#',  :jpg, :quality => 70],
      :large    => ['600>',      :jpg, :quality => 70],
      :retina   => ['1200>',     :jpg, :quality => 30]
    },
    :convert_options => {
      :thumb    => '-set colorspace sRGB -strip',
      :preview  => '-set colorspace sRGB -strip',
      :large    => '-set colorspace sRGB -strip',
      :retina   => '-set colorspace sRGB -strip -sharpen 0x0.5'
    },
    default_url: "/assets/images/company.png"
    validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
    validates_attachment :avatar, presence: true,
      size: { :in => 0..10.megabytes },
      content_type: { :content_type => /^image\/(jpeg|png|gif|tiff)$/ }

  FriendlyId
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  def should_generate_new_friendly_id?
    name_changed?
  end

end
