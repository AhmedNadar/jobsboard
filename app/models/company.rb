class Company < ActiveRecord::Base

  has_attached_file :avatar,styles: { :medium => "150x150>", :thumb => "100x100>" },
                            default_url: "/images/:style/company.png"
  # validation
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates_presence_of :name, :url, :location

  # associations
  belongs_to :job
end
