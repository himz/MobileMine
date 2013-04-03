class User < ActiveRecord::Base

  ##
  # The user model has details of a user including:
  #
  # first_name: Mandatory parameter
  # last_name: Mandatory parameter
  # address: Optional parameter
  # phone_number: Optional parameter.
  # zipcode: Zipcode of the user's address, Mandatory parameter
  # user_type: Defines the type of user of the system. For admin_users, it is set to 0 and for a regular user, it is set to 1. The default value is 1. Mandatory parameter
  # email: Mandatory parameter
  #
  # Database model: https://docs.google.com/document/d/12_X6ZmRD042Sr2peaH7DuS3U_om3o31kn17HePzwFDE/edit
  #
  #
  ##

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  has_many :credit_infos
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :first_name, :last_name, :phone_number, :address, :user_type, :zipcode, :activated
                  # attr_accessible :title, :body

  VALID_EMAIL_REGEX = /\A[\w+\.]+@[a-z\d\.]+\.[a-z]+\z/i
  validates :first_name, presence:true, length: {maximum:50}
  validates :last_name, presence:true, length: {maximum:50}
  validates :address, length: {maximum:500}
  validates :phone_number, length: {minimum:8, maximum:15}
  validates :zipcode, presence:true, :length => { :is => 5 }, :numericality=> { :only_integer => true}
  validates :user_type, presence:true, :numericality=> { :only_integer => true}, length: {maximum:1}
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  validates :password, presence:true, :on=>:create

  after_initialize :init
  def init
    self.user_type ||=1
  end
end
