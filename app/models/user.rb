class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :jobs,      through: :companies, dependent: :destroy
  has_many :companies, dependent: :destroy

  accepts_nested_attributes_for :companies, allow_destroy: true
end
