module HelpersInModel
  def helpers
    ActionController::Base.helpers
  end
end

ActiveRecord::Base.send :include, HelpersInModel
ActiveRecord::Base.send :include, ActionController::UrlWriter
