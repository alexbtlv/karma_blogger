require "spec_helper"

describe PostsController do
	describe "routing" do
		it "routes to #best" do
			expect(get("/")).to route_to("posts#best")
		end

		it "routes to #fresh" do
			expect(get("/fresh")).to  route_to("posts#fresh")
		end

		it "routes to #show" do
			expect(get("/slug")).to route_to("posts#show", :id => 'slug')  
		end

		it "routes to #new" do
			expect(get("/new-story")).to route_to("posts#new")
		end

		it "routes to #edit" do
			expect(get("/slug/edit")).to  route_to("posts#edit", :id => 'slug')
		end

		it "routes to #create" do
			expect(post("/")).to route_to("posts#create")
		end

		it "routes to #update" do
			expect(put("/slug")).to route_to("posts#update", :id => 'slug')
		end

		it "routes to #destroy" do
			expect(delete("/slug")).to  route_to("posts#destroy", :id => 'slug')
		end

		it "routes to #karma_up" do
			expect(patch("/slug/karma_up")).to   route_to("posts#karma_up", :id => 'slug')
		end

		it "routes to #karma_down" do
			expect(patch("/slug/karma_down")).to  route_to("posts#karma_down", :id => 'slug')
		end
	end
end