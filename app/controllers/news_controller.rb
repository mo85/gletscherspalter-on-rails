class NewsController < ApplicationController
  
  def index
    @news = News.all
    
    respond_to do |format|
      format.html
    end
  end
  
  def show
    @news = News.find(params[:id])
    
    respond_to do |format|
      format.html
    end
  end
  
  def new
    @news = News.new
    
    respond_to do |format|
      format.html
    end
  end
  
  def create
    @news = News.new(params[:news])
    @news.user_id = current_user.id
    
    respond_to do |format|
      if @news.save
        flash[:notice] = "News Eintrag erstellt."
        format.html { redirect_to news_index_path }
      else
        format.html { render :action => "new" } 
      end
    end
  end
  
  def edit
    @news = News.find(params[:id])
  end
  
  def update
    @news = News.find(params[:id])
    
    respond_to do |format|
      if @news.update_attributes(params[:news])
        format.html { redirect_to news_index_path }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  def destroy  
    @news = News.find(params[:id])
    @news.destroy

    respond_to do |format|
      flash[:notice] = "News Eintrag gelöscht."
      format.html { redirect_to(news_index_path) }
    end
  end
  
end