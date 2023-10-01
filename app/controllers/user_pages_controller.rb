# frozen_string_literal: true
class UserPagesController < ApplicationController
  def show
    user_page_service = UserPageService.new(params[:id])
    user_page_service.fetch_details

    @user = user_page_service.user
    @pagy, @overall = pagy_countless(UserPageEntry.union_query(user_page_service.username))

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end
end
