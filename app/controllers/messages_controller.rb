class MessagesController < ApplicationController
  filter_access_to :all

  def index
    @messages = Message.all

    respond_to do |format|
      format.html # insufficientcredentials.html.erb
    end
  end

  def new
    @message = Message.new

    respond_to do |format|
      format.html
    end
  end

  def edit
    @message = Message.find(params[:id])
  end

  def create
    @message = Message.new(params[:message])
    @message.publisher = current_user
    @recipients = []
    if params[:recipients] == "all"
      @recipients = User.all
    elsif params[:recipients] == "active"
      @recipients = User.find_all_by_is_player(true)
    elsif params[:recipients] == "passive"
      @recipients = User.find_all_by_is_player(false)
    end
    
    respond_to do |format|
      if @message.save
        flash[:notice] = 'Message was successfully created.'
        format.html { redirect_to(messages_path) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @message = Message.find(params[:id])

    respond_to do |format|
      if @message.update_attributes(params[:event])
        flash[:notice] = 'Event was successfully updated.'
        format.html { redirect_to(messages_path) }
      else
        format.html { render :action => "edit" }
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