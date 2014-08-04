require 'spec_helper'

describe Post  do
	let(:user) { FactoryGirl.create(:user) }
	before { @post = user.posts.build(title: "Lorem Lorem", body: "Lorem ipsum dolor blah blah") }

	subject { @post }

	it { is_expected.to respond_to(:title)}
  it { is_expected.to respond_to(:body)}
  it { is_expected.to respond_to(:user)}
  it { is_expected.to respond_to(:cached_votes_total)}
  it { is_expected.to respond_to(:cached_votes_score)}
  it { is_expected.to respond_to(:cached_votes_up)}
  it { is_expected.to respond_to(:cached_votes_down)}
  it { is_expected.to be_valid }

	describe '#user' do
  	subject { super().user }
  	it { is_expected.to eq(user) }
	end

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
end