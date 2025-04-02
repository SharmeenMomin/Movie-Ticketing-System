class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    Rails.logger.debug "User found: #{user.inspect}" # Debugging user
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id  # Store user ID in session
      if user.email == "admin@example.com"  # Check if the user is an admin
        redirect_to admin_dashboard_path, notice: 'Logged in successfully as Admin!'  # Redirect to the admin dashboard
      else
        redirect_to home_index_path, notice: 'Logged in successfully!'
      end
    else
      flash.now[:alert] = 'Invalid email or password'
      Rails.logger.debug "Login failed: Invalid email or password"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil  # Clear session on logout
    redirect_to root_path, notice: 'Logged out successfully!'
  end
end
