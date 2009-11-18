class PhotosController < ApplicationController
  
  include FlickRaw
  
  ::FLICKR_API_KEY = "02c75fd7a65f0e72affa799b7105afc9"
  ::SHARED_SECRET = "3125e4dc1dd61ad4"
  ::USER_ID = "44777339@N04"
  
  def index
    @photosets = flickr.photosets.getList :user_id => USER_ID
  end
  
  def show
    
  end
  
end