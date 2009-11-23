class TopicsController < ApplicationController
  filter_access_to :all
  
  # GET /topics
  def index
    @topics = Topic.all.paginate :page => params[:page], :per_page => 15

    respond_to do |format|
      format.html # insufficientcredentials.html.erb
    end
  end

  # GET /topics/1
  def show
    @topic = Topic.find(params[:id], :include => {:posts => :user})
    @posts = @topic.posts.paginate :page => params[:page], :per_page => 10
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /topics/new
  def new
    @topic = Topic.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /topics/1/edit
  def edit
    @topic = Topic.find(params[:id])
  end

  # POST /topics
  def create
    @topic = Topic.new(params[:topic])

    respond_to do |format|
      if @topic.save
        current_user.topics << @topic
        flash[:notice] = 'Thread wurde erfolgreich erstellt.'
        format.html { redirect_to(@topic) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /topics/1
  def update
    @topic = Topic.find(params[:id])

    respond_to do |format|
      if @topic.update_attributes(params[:topic])
        flash[:notice] = 'Thread wurde erfolgreich angepasst.'
        format.html { redirect_to(@topic) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /topics/1
  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy

    respond_to do |format|
      flash[:notice] = "Thread wurde gelöscht."
      format.html { redirect_to(topics_url) }
    end
  end
end
