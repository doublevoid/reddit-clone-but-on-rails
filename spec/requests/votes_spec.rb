require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe '/votes', type: :request do
  # This should return the minimal set of attributes required to create a valid
  # Vote. As you add validations to Vote, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    skip('Add a hash of attributes valid for your model')
  end

  let(:invalid_attributes) do
    skip('Add a hash of attributes invalid for your model')
  end

  describe 'GET /subreddit_posts' do
    it 'renders a successful response' do
      Vote.create! valid_attributes
      get votes_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      vote = Vote.create! valid_attributes
      get vote_url(vote)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_vote_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      vote = Vote.create! valid_attributes
      get edit_vote_url(vote)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Vote' do
        expect do
          post votes_url, params: { vote: valid_attributes }
        end.to change(Vote, :count).by(1)
      end

      it 'redirects to the created vote' do
        post votes_url, params: { vote: valid_attributes }
        expect(response).to redirect_to(vote_url(Vote.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Vote' do
        expect do
          post votes_url, params: { vote: invalid_attributes }
        end.not_to change(Vote, :count)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post votes_url, params: { vote: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        skip('Add a hash of attributes valid for your model')
      end

      it 'updates the requested vote' do
        vote = Vote.create! valid_attributes
        patch vote_url(vote), params: { vote: new_attributes }
        vote.reload
        skip('Add assertions for updated state')
      end

      it 'redirects to the vote' do
        vote = Vote.create! valid_attributes
        patch vote_url(vote), params: { vote: new_attributes }
        vote.reload
        expect(response).to redirect_to(vote_url(vote))
      end
    end

    context 'with invalid parameters' do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        vote = Vote.create! valid_attributes
        patch vote_url(vote), params: { vote: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested vote' do
      vote = Vote.create! valid_attributes
      expect do
        delete vote_url(vote)
      end.to change(Vote, :count).by(-1)
    end

    it 'redirects to the votes list' do
      vote = Vote.create! valid_attributes
      delete vote_url(vote)
      expect(response).to redirect_to(votes_url)
    end
  end
end
