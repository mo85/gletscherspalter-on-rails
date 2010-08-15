class CommentsController < ApplicationController
  filter_access_to :all
  
  # GET /events/1/edit
  def edit
    @comment = Comment.find(params[:id])
    
    respond_to do |format|
      format.ajax
    end
  end

  # PUT /events/1
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        flash[:notice] = 'Kommentar erfolgreich angepasst.'
        format.html { redirect_to :back }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  # DELETE /events/1
  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy

    respond_to do |format|
      flash[:notice] = "Kommentar wurde gelöscht."
      format.html { redirect_to :back }
    end
  end
  
end
