class PostsController < ApplicationController
  filter_access_to :all
  filter_access_to :edit, :attribute_check => true
  
  # GET /topics/:topic_id/posts/new
  def new
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.build

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    @topic = @post.topic
  end

  # POST /topics/:topic_id/posts
  def create
    @post = Topic.find(params[:topic_id]).posts.build(params[:post])

    respond_to do |format|
      if @post.save
        current_user.posts << @post
        flash[:notice] = 'Kommentar wurde erfolgreich erstellt.'
        format.html { redirect_to(@post.topic) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /posts/1
  def update
    @post = Post.find(params[:id])
    
    respond_to do |format|
      if @post.update_attributes(params[:post])
        flash[:notice] = 'Kommentar wurde erfolgreich angepasst.'
        format.html { redirect_to(topic_path(@post.topic)) }
      else
        format.html { render :action => "edit" }
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
