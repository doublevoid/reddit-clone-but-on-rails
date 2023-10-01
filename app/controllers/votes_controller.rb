class VotesController < ApplicationController
  before_action :set_vote, only: %i[edit update destroy]
  def edit; end

  def create
    success, result = VoteService.create_vote(vote_params)
    respond_to do |format|
      if success
        @vote = result
        format.html { redirect_to vote_url(@vote), notice: 'Vote was successfully created.' }
        format.json { render :show, status: :created, location: @vote }
      end
    end
  end

  def update
    success, result = VoteService.update_vote(@vote, vote_params)
    respond_to do |format|
      if success
        format.html { redirect_to vote_url(@vote), notice: 'Vote was successfully updated.' }
        format.json { render :show, status: :ok, location: @vote }
      end
    end
  end

  def destroy
    VoteService.destroy_vote(@vote)
    respond_to do |format|
      format.html { redirect_to votes_url, notice: 'Vote was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_vote
    @vote = VoteService.find_vote_by_id(params[:id])
  end

  def vote_params
    params.require(:vote).permit(:value, :voteable_type, :voteable_id, :user_id)
  end
end
