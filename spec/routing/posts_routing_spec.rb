require "spec_helper"

describe PostsController do
	describe "routing" do
		it "routes to #best" do
			get("/").should route_to("posts#best")
		end

		it "routes to #fresh" do
			get("/fresh").should route_to("posts#fresh")
		end

		it "routes to #show" do
			get("/slug").should route_to("posts#show", :id => 'slug')
		end

		it "routes to #new" do
			get("/new-story").should route_to("posts#new")
		end

		it "routes to #edit" do
			get("/slug/edit").should route_to("posts#edit", :id => 'slug')
		end

		it "routes to #create" do
			post("/").should route_to("posts#create")
		end

		it "routes to #update" do
			put("/slug").should route_to("posts#update", :id => 'slug')
		end

		it "routes to #destroy" do
			delete("/slug").should route_to("posts#destroy", :id => 'slug')
		end

		it "routes to #karma_up" do
			patch("/slug/karma_up").should route_to("posts#karma_up", :id => 'slug')
		end

		it "routes to #karma_down" do
			patch("/slug/karma_down").should route_to("posts#karma_down", :id => 'slug')
		end
	end
end