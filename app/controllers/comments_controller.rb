class CommentsController < ApplicationController
	before_action :logged_in_user, only: [:create]
	before_action :find_entry
	def create
	@entry = Entry.find params[:entry_id]
    @comment = @entry.comments.build(comment_params)
    if logged_in? && @comment.save
      flash[:success] = "comment created!"
      redirect_to @entry
    else
      render "/entries/show"
    end
  end
  private
  def comment_params
      params.require(:comment).permit(:content, :user_id, :entry_id)
    end
  def find_entry
@entry = Entry.find(params[:entry_id] || params[:id])
redirect_to root_path, flash[:warning] = "Access denied" unless @entry
end
end
