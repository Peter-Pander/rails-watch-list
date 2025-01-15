class BookmarksController < ApplicationController
  before_action :set_bookmark, only: :destroy
  # Finds the bookmark for destroy action
  before_action :set_list, only: [:new, :create]
  # Finds the list for new and create actions

  def new
    @bookmark = Bookmark.new
  end

  def create
    @bookmark = Bookmark.new(bookmark_params)
    # Associate the bookmark with the list
    @bookmark.list = @list
    if @bookmark.save
      # Redirect to the list page after saving the bookmark
      redirect_to list_path(@list)
    else
      # Re-render the new form if there's an error
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark.destroy
    # Redirect back to the list
    redirect_to list_path(@bookmark.list), status: :see_other
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end

  def set_bookmark
    @bookmark = Bookmark.find(params[:id]) # Find the bookmark by id
  end

  def set_list
    @list = List.find(params[:list_id]) # Find the list by list_id
  end
end
