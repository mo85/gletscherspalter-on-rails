# encoding: utf-8 
class NewsController < ApplicationController
  filter_access_to :all
  
  def index
    @news = News.all.paginate :page => params[:page], :per_page => 5
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
      format.ajax
    end
  end
  
  def create
    @news = News.new(params[:news])
    @news.user_id = current_user.id
    
    respond_to do |format|
      if @news.save
        flash[:notice] = "News Eintrag erstellt."
        mails = UserMailer.new_news(@news)
        if mails
          mails.deliver
        end
        format.html { redirect_to :back }
      else
        flash[:notice] = "Neuigkeiten müssen zwingend eine Nachricht enthalten."
        format.html { redirect_to :action => "index" } 
      end
    end
  end
  
  def edit
    @news = News.find(params[:id])

    respond_to do |format|
      format.ajax
    end
  end
  
  def update
    @news = News.find(params[:id])
    
    respond_to do |format|
      if @news.update_attributes(params[:news])
        format.html { redirect_to :back }
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