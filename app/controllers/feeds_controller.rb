class FeedsController < ApplicationController
  # GET /feeds
  # GET /feeds.json
  require 'rfeedfinder'
  require 'pismo'
  require 'uri_validator'
  require 'dynamic_form'
  
  def index
    @feeds = Feed.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @feeds }
    end
  end

  # GET /feeds/1
  # GET /feeds/1.json
  def show
    @feed = Feed.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @feed }
    end
  end

  # GET /feeds/new
  # GET /feeds/new.json
  def new

   @feed = Feed.new

      respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @feed }
    
      
    end
  end

  # GET /feeds/1/edit
  def edit
    @feed = Feed.find(params[:id])
  end

  # POST /feeds
  # POST /feeds.json
  def create
    
    @feed = Feed.new
    
    #@feed = Feed.new(params[:feed])
   if @feed.errors.any?
     redirect_to root_path
   end  
    
    @feed.url = params[:feed][:url]
    
    #params[:feed_url] = Rfeedfinder.feed("#{@feed.url}")
    
    params[:feed_url] = Rfeedfinder.feed("#{@feed.url}")
    @feed.feed_url = params[:feed_url]
    
    doc = Pismo::Document.new("#{@feed.url}")
    #doc = Pismo::Document.new('http://orbitingjupiter.com')
    @feed.name = doc.html_title
    @feed.favicon = doc.favicon
    @feed.latest_post_title = doc.title
    @feed.last_updated = doc.datetime
    @feed.user_id = current_user
   # @feed.save
 
     
    respond_to do |format|
      if @feed.save
        format.html { redirect_to @feed, notice: 'Feed was successfully created.' }
        format.json { render json: @feed, status: :created, location: @feed }
      else
        format.html { render action: "new" }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /feeds/1
  # PUT /feeds/1.json
  def update
    @feed = Feed.find(params[:id])

    respond_to do |format|
      if @feed.update_attributes(params[:feed])
        format.html { redirect_to @feed, notice: 'Feed was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @feed.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feeds/1
  # DELETE /feeds/1.json
  def destroy
    @feed = Feed.find(params[:id])
    @feed.destroy

    respond_to do |format|
      format.html { redirect_to feeds_url }
      format.json { head :no_content }
    end
  end
end
