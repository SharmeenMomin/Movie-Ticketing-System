class Admin::SessionsController < Devise::SessionsController
  layout "admin"

  def after_sign_in_path_for(resource)
    admin_dashboard_path  # Redirect admin to dashboard
  end

  def after_sign_out_path_for(resource_or_scope)
    new_admin_session_path # Redirect to admin login after logout
  end
end
