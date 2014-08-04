require 'spec_helper'

describe User do
	let(:valid_attributes) {
    {
      name: "Alexander",
      email: "alexander@karma.com",
      password: "1234567890",
      password_confirmation: "1234567890"
    }
	}

  it { is_expected.to respond_to(:name)}
  it { is_expected.to respond_to(:email)}
  it { is_expected.to respond_to(:password)}
  it { is_expected.to respond_to(:password_confirmation)}


	context "validations" do
  	let(:user) { User.new(valid_attributes) }

  	before do
      User.create(valid_attributes)
    end

    it "requires an name" do 
      expect(user).to validate_presence_of(:name)
    end

    it "requires a unique name" do
      expect(user).to validate_uniqueness_of(:name)
    end

    it "requires an email" do 
      expect(user).to validate_presence_of(:email)
    end

    it "requires a unique email" do
      expect(user).to validate_uniqueness_of(:email)
    end

    it "requires a unique email and case insensitive" do
      user.email = "ALEXANDER@KARMA.COM"
      expect(user).to validate_uniqueness_of(:email)
    end

    it "requires the email address to look like an email" do
      user.email = "12345"
      expect(user).to_not be_valid
    end
	end

	describe "downcase name" do
	it "makes the name attribute lower case" do
		user = User.new(valid_attributes.merge(name: "ALEXANDER"))
    		expect{ user.downcase_name }.to change{ user.name }.
      		from("ALEXANDER").
     			to("alexander")
	end

	it "downcases an name before saving" do
    user = User.new(valid_attributes)
    user.name = "OBAMA"
    expect(user.save).to be_truthy
    expect(user.name).to eq("obama")
	end
end

describe "downcase email" do
	it "makes the email attribute lower case" do
		user = User.new(valid_attributes.merge(email: "ALEXANDER@KARMA.COM"))
		expect{ user.downcase_email }.to change{ user.email }.
      		from("ALEXANDER@KARMA.COM").to("alexander@karma.com")
	end

	it "downcases an email before saving" do
    user = User.new(valid_attributes)
    user.email = "OBAMA@KARMA.COM"
    expect(user.save).to be_truthy
    expect(user.email).to eq("obama@karma.com")
	end
end

context "relationships" do
    it { should have_many(:posts) }

    it "should destroy associated posts" do
    	user = User.new(valid_attributes)
	    posts = user.posts.dup
	    user.destroy
	    expect(posts).to be_empty
	    posts.each do |post|
	    	expect(Post.find_by_id(post.id)).to be_nil
	    end
    end
	end
end












