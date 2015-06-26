class StaticPagesController < ApplicationController

   def home
    @title = "home"
    if logged_in?
      @entry  = current_user.entries.build
      @feed_items = current_user.feed.paginate(page: params[:page], :per_page =>10)
    end

  end
  def help
    @title = "Help"
  end

  def login
    @title = "Log In"
  end

  def about
    @title = "About"
  end

  def contact
    @title = "Contact"
  end

end
