class ApplicationController < ActionController::Base
  include Pundit::Authorization
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    boxes_path
  end

  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end
end
