class CommentsController < ApplicationController
  before_action :set_comment, only: %i[show edit update destroy]

  def index
    @comments = CommentService.all_comments
  end

  def show; end

  def new
    @comment = Comment.new
  end

  def edit; end

  def create
    success, result = CommentService.create_comment(comment_params)
    respond_to do |format|
      if success
        @comment = result
        format.html { redirect_to comment_url(@comment), notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: result, status: :unprocessable_entity }
      end
    end
  end

  def update
    success, result = CommentService.update_comment(@comment, comment_params)
    respond_to do |format|
      if success
        format.html { redirect_to comment_url(@comment), notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: result, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    CommentService.destroy_comment(@comment)
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_comment
    @comment = CommentService.find_comment_by_id(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body, :post_id, :user_id)
  end
end
