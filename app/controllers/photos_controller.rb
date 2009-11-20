class PhotosController < ApplicationController
  
  filter_access_to :all
  
  include FlickRaw
  
  FlickRaw.api_key = "02c75fd7a65f0e72affa799b7105afc9"
  FlickRaw.shared_secret = "3125e4dc1dd61ad4"
  ::USER_ID = "44777339@N04"
  
  @auth = flickr.auth.checkToken :auth_token => "72157622835493126-87c74181a6135d00"
  
  def index
    @photosets = flickr.photosets.getList :user_id => USER_ID
  end
  
  def show  
    @photos = flickr.photosets.getPhotos(:photoset_id => params[:id]).photo
    @photoset = flickr.photosets.getInfo(:photoset_id => params[:id])
  end
  
end