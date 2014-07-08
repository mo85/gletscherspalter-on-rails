class PhotosController < ApplicationController
  
  filter_access_to :all

  include FlickRaw
  
  #FlickRaw.api_key = APP_CONFIG["flickr"]["api-key"]
  #FlickRaw.shared_secret = APP_CONFIG["flickr"]["shared-secret"]
  #@@user_id = APP_CONFIG["flickr"]["user-id"]
  #@@token = APP_CONFIG["flickr"]["auth-token"]
  #@auth = flickr.auth.checkToken :auth_token => @@token
  
  def index
    unless read_fragment(:action => "index")
      @photosets = flickr.photosets.getList :user_id => @@user_id
    end
  end
  
  def show
    unless read_fragment(:action => "show", :id => params[:id])
      @photos = flickr.photosets.getPhotos(:photoset_id => params[:id]).photo
      @photoset = flickr.photosets.getInfo(:photoset_id => params[:id])
    end
  end
  
end