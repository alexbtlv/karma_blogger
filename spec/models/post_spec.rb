require 'spec_helper'

describe Post, :type => :model  do
	let(:user) { FactoryGirl.create(:user) }
	before { @post = user.posts.build(title: "Lorem Lorem", body: "Lorem ipsum dolor blah blah") }

	subject { @post }

	it { is_expected.to respond_to(:title)}
  	it { is_expected.to respond_to(:body)}
  	it { is_expected.to respond_to(:user)}

  	describe '#user' do
    	subject { super().user }
    	it { is_expected.to eq(user) }
  	end

  	it { is_expected.to be_valid }

  	describe "when user_id is not present" do
	  	before { @post.user_id = nil }
	  	it { should_not be_valid }
    end

    describe "with blank title" do
      before { @post.title = " " }
      it { is_expected.not_to be_valid }
    end

    describe "with blank body" do
      before { @post.body = " " }
      it { is_expected.not_to be_valid }
    end

    describe "accessible attributes" do
      it "should not allow access to user_id" do
        expect do
          Post.new(user_id: user.id)
        end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
      end
    end
end
