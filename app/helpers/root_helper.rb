require "base64"

module RootHelper
  
  def encode_mail(address)
    Base64.encode64(address)
  end
  
end
