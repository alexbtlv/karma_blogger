class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	
	validates :email, presence: true, uniqueness: true
	validates :name, presence: true, uniqueness: true

  has_many :posts, dependent: :destroy

  acts_as_voter
	
	before_create :downcase_name, :downcase_email

	def to_param
    name
  end

  def downcase_name
  	self.name = name.downcase
  end

  def downcase_email
    self.email = email.downcase
  end

end
