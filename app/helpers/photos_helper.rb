module PhotosHelper
  
  # Returns a flickr image tag for the given photo
  # size and lightbox paramater could be
  # 
  # :small => 75x75
  # :thumbnail => 100px width
  # :medium => 240px width
  # :large => 500px width
  # :original => original width and height
  def photo_image_tag(photo, options)
    link_to(
      image_tag(
        get_url(photo, photo.id, options[:size]),
        get_options(photo, options[:size])),
      get_url(photo, photo.id, options[:lightbox]), 
        { :rel => 'lightbox[roadtrip]'})
  end
  
  # Returns a lightboxed flickr image tag for the given photoset
  # 
  # size paramater could be
  # :small => 75x75
  # :thumbnail => 100px width
  # :medium => 240px width
  # :large => 500px width
  # :original => original width and height
  def photoset_image_tag(photo, options)
    image_tag(
      get_url(photo, photo.primary, options[:size]),
      get_options(photo, options[:size]))
  end
  
  private 

  # generate the flickr url
  def get_url(photo, identifier, size)
    "http://farm#{photo.farm.to_s}.static.flickr.com/#{photo.server}/#{
      identifier}_#{photo.secret}#{get_url_size(size)}.jpg"
  end

  # gets the size identifier for the url
  def get_url_size(size)
    case size  
      when :small
        "_m"
      when :thumbnail
        "_t"
      when :medium
        ""
      when :large
        "_b"
      when :original
        "_o"
    end
  end
  
  # Returns the image tag options depending on the choosen size
  def get_options(photo, size)
    options = { :alt => photo.title, :class => 'bevel' }
    case size  
      when :small
        options['size'] = "75x75"
      when :thumbnail
        options['width'] = "100"
      when :medium
        options['width'] = "240"
      when :large
        options['width'] = "500"
    end
    return options
  end
  
end