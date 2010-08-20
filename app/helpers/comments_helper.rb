module CommentsHelper
  
  def comments_collapsed(event)
    result = 1
    setting = ResourceSetting.find_by_user_id_and_resource_id(current_user.id, event.id)
    if setting && setting.comments_expanded
      result = 0
    end
    result
  end
  
end
