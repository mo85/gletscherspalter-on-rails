class MessagesController < ApplicationController
  filter_access_to :all

  def index
    @messages = Message.all :order => "created_at DESC", :limit => 5

    respond_to do |format|
      format.html
    end
  end

  def new
    @message = Message.new

    respond_to do |format|
      format.html
    end
  end

  def create
    @message = Message.new(params[:message])
    @message.publisher = current_user
    @recipients = []
    
    if !params[:users].blank?
      @recipients = User.find(params[:users].split(','))
    else
      if params[:recipients] == "all"
        @recipients = User.all
      elsif params[:recipients] == "active"
        @recipients = User.find_all_by_is_player(true)
      elsif params[:recipients] == "passive"
        @recipients = User.find_all_by_is_player(false)
      end
    end
    
    respond_to do |format|
      if @message.save
        UserMailer.deliver_mail_news(@recipients, @message)
        flash[:notice] = 'Message was successfully created.'
        format.html { redirect_to(messages_path) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to(messages_path) }
    end
  end
  
end