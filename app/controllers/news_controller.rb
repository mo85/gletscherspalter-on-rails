class NewsController < ApplicationController
  filter_access_to :all

  def index
    @news = News.all

    respond_to do |format|
      format.html # insufficientcredentials.html.erb
    end
  end

  def new
    @news = News.new

    respond_to do |format|
      format.html
    end
  end
  
  
  def completions
    debugger
    @users = User.find_all :limit => 3
    respond_to do |format|
      format.ajax
    end
  end

  def edit
    @news = News.find(params[:id])
  end

  def create
    @news = News.new(params[:news])
    @news.publisher = current_user
    
    respond_to do |format|
      if @news.save
        flash[:notice] = 'News was successfully created.'
        format.html { redirect_to(news_index_path) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @news = News.find(params[:id])

    respond_to do |format|
      if @news.update_attributes(params[:event])
        flash[:notice] = 'Event was successfully updated.'
        format.html { redirect_to(@news_path) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @news = News.find(params[:id])
    @news.destroy

    respond_to do |format|
      format.html { redirect_to(events_url) }
    end
  end
  
end