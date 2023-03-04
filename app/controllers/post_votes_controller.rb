class PostVotesController < ApplicationController
  before_action :set_post_vote, only: %i[ show edit update destroy ]

  # GET /post_votes or /post_votes.json
  def index
    @post_votes = PostVote.all
  end

  # GET /post_votes/1 or /post_votes/1.json
  def show
  end

  # GET /post_votes/new
  def new
    @post_vote = PostVote.new
  end

  # GET /post_votes/1/edit
  def edit
  end

  # POST /post_votes or /post_votes.json
  def create
    @post_vote = PostVote.new(post_vote_params)

    respond_to do |format|
      if @post_vote.save
        format.html { redirect_to post_vote_url(@post_vote), notice: "Post vote was successfully created." }
        format.json { render :show, status: :created, location: @post_vote }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post_vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /post_votes/1 or /post_votes/1.json
  def update
    respond_to do |format|
      if @post_vote.update(post_vote_params)
        format.html { redirect_to post_vote_url(@post_vote), notice: "Post vote was successfully updated." }
        format.json { render :show, status: :ok, location: @post_vote }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post_vote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /post_votes/1 or /post_votes/1.json
  def destroy
    @post_vote.destroy

    respond_to do |format|
      format.html { redirect_to post_votes_url, notice: "Post vote was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post_vote
      @post_vote = PostVote.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_vote_params
      params.require(:post_vote).permit(:value, :user_id, :post_id)
    end
end
