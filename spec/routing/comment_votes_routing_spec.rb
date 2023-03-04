require "rails_helper"

RSpec.describe CommentVotesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/comment_votes").to route_to("comment_votes#index")
    end

    it "routes to #new" do
      expect(get: "/comment_votes/new").to route_to("comment_votes#new")
    end

    it "routes to #show" do
      expect(get: "/comment_votes/1").to route_to("comment_votes#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/comment_votes/1/edit").to route_to("comment_votes#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/comment_votes").to route_to("comment_votes#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/comment_votes/1").to route_to("comment_votes#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/comment_votes/1").to route_to("comment_votes#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/comment_votes/1").to route_to("comment_votes#destroy", id: "1")
    end
  end
end
