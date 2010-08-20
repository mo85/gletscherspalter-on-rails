class ResourceSettingsController < ApplicationController
  
  def toggle_resource_setting
    user = User.find(params[:user_id])
    clazz = eval(params[:resource_type])
    resource = clazz.find(params[:id])
    
    if user && resource
      setting = ResourceSetting.find_by_user_id_and_resource_id(user.id, resource.id)
      unless setting
        setting = user.resource_settings.create(:resource => resource)
      end
      
      setting.toggle_setting(params[:setting])
      setting.save
    end
    
    render :text => "OK"
  end

end
