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
    @news = News.new
    
    respond_to do |format|
      format.html
    end
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def destroy
  end
  
end