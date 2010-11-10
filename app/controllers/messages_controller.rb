# encoding: utf-8 
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
    
    if !params[:users].blank? && params[:recipients] == "select"
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
    
    @recipients = @recipients.select{|u| u.email != nil && u.email != ""}
    
    respond_to do |format|
      if @message.save
        UserMailer.mail_message(@recipients, @message).deliver
        flash[:notice] = "Nachricht an #{@recipients.size} Empfänger gesendet."
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
      flash[:notice] = "Nachricht wurde gelöscht."
      format.html { redirect_to(messages_path) }
    end
  end
  
end