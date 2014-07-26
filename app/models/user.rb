class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	
	validates :email, presence: true, uniqueness: true
	validates :name, presence: true, uniqueness: true

  has_many :posts
	
	before_create :name_downcase

	def to_param
    	name
  	end

  	def name_downcase
  		name.downcase!
  	end

end
