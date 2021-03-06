class Post < ActiveRecord::Base
	validates :title, presence: true, length: { minimum: 2 }
	validates :body, presence: true, length: { minimum: 5 }
	validates :user_id, presence: true

	belongs_to :user

	acts_as_votable

	before_create :create_slug

	def create_slug
    	self.slug = self.title.parameterize
  	end

  	def to_param
    	slug
  	end
end
