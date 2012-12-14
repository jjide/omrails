class StaticPagesController < ApplicationController
  def home
    @feeds = Feed.all
  end

  def about
  end
end
