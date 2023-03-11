require "rails_helper"

RSpec.describe UserSubscriptionsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/user_subscriptions").to route_to("user_subscriptions#index")
    end

    it "routes to #new" do
      expect(get: "/user_subscriptions/new").to route_to("user_subscriptions#new")
    end

    it "routes to #show" do
      expect(get: "/user_subscriptions/1").to route_to("user_subscriptions#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/user_subscriptions/1/edit").to route_to("user_subscriptions#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/user_subscriptions").to route_to("user_subscriptions#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/user_subscriptions/1").to route_to("user_subscriptions#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/user_subscriptions/1").to route_to("user_subscriptions#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/user_subscriptions/1").to route_to("user_subscriptions#destroy", id: "1")
    end
  end
end
