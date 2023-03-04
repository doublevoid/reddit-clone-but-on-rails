require "rails_helper"

RSpec.describe PostVotesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/post_votes").to route_to("post_votes#index")
    end

    it "routes to #new" do
      expect(get: "/post_votes/new").to route_to("post_votes#new")
    end

    it "routes to #show" do
      expect(get: "/post_votes/1").to route_to("post_votes#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/post_votes/1/edit").to route_to("post_votes#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/post_votes").to route_to("post_votes#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/post_votes/1").to route_to("post_votes#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/post_votes/1").to route_to("post_votes#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/post_votes/1").to route_to("post_votes#destroy", id: "1")
    end
  end
end
