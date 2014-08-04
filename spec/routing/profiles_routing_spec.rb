require "spec_helper"

describe ProfileController do
	describe "routing" do
		it "routes to #show" do
			get('/@name').should route_to("profile#show", :id => 'name')
		end
	end
end