class ResourceSetting < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :resource, :polymorphic => true
  
  def toggle_setting(setting)
    value = self.send(setting)
    setter_name = "#{setting}="
    if (value)
      self.send(setter_name, false)
    else
      self.send(setter_name, true)
    end
    
  end
  
end
