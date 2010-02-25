class PostsController < ApplicationController
  filter_access_to :all
  filter_access_to :edit, :attribute_check => true
  
  def new
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.build

    respond_to do |format|
      format.ajax
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    @topic = @post.topic

    respond_to do |format|
      format.ajax
    end
  end

  # POST /topics/:topic_id/posts
  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.build(params[:post])

    respond_to do |format|
      if @post.save
        current_user.posts << @post
        flash[:notice] = 'Kommentar wurde erfolgreich erstellt.'
        format.html { redirect_to(@post.topic) }
      else
        format.html { render :action => "new", :locals => { :topic => @topic } }
      end
    end
  end

  # PUT /posts/1
  def update
    @post = Post.find(params[:id])
    @topic = @post.topic
    
    respond_to do |format|
      if @post.update_attributes(params[:post])
        flash[:notice] = 'Kommentar wurde erfolgreich angepasst.'
        format.html { redirect_to(topic_path(@post.topic)) }
      else
        format.html { render :action => "edit", :locals => { :topic => @topic } }
      end
    end
  end

  # DELETE /posts/1
  def destroy
    @post = Post.find(params[:id])
    @topic = @post.topic
    @post.destroy

    respond_to do |format|
      flash[:notice] = "Kommentart wurde gelöscht."
      format.html { redirect_to(topic_path(@topic)) }
    end
  end
end
