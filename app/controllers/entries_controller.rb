class EntriesController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy
 def create
    @entry = current_user.entries.build(entry_params)
    if @entry.save
      flash[:success] = "Title created!"
      redirect_to home_url
    else
     @feed_items = []
      render 'static_pages/home'
    end
  end
  def show
     @entry = Entry.find(params[:entry_id] || params[:id])
     @comment = @entry.comments.build
  end
  def destroy
     @entry.destroy
    flash[:success] = "Title deleted"
    redirect_to request.referrer || root_url

  end
  def index
@entries = Entry.all.paginate(page: params[:page], :per_page => 10 )
  end
  private

    def entry_params
      params.require(:entry).permit(:title, :body, :picture)
    end
    def correct_user
      @entry = current_user.entries.find_by(id: params[:id])
      redirect_to root_url if @entry.nil?
    end
end