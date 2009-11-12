module TopicsHelper

  def info_for_last_comment(post)
    unless post
      return "-"
    end
    
    "#{post.user.full_name}<br /> #{l(post.created_at, :format => :short)}"
  end

end
