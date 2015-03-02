class Company < ActiveRecord::Base

  has_attached_file :avatar,styles: { :medium => "150x150>", :thumb => "100x100>" },
                            default_url: "/images/:style/company.png"
  # validation
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates_presence_of     :name,  :url, :location, :avatar, :email
  validates_uniqueness_of   :email, :url
  validates_format_of       :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create


  # associations
  has_many :jobs
end
