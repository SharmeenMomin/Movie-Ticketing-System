class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  # before_action :authenticate_user!
  # before_action :correct_user, only: %i[show edit update destroy]

  def show
    unless current_user == @user
      redirect_to home_index_path , notice: 'You are not permitted to view this page'
    end
  end

  def tickets
      @user = User.find(params[:id])
      if current_user.id != @user.id && current_user.username != 'Admin'
        flash[:alert] = "Access denied!"
        redirect_to home_index_path, notice: 'Access denied!'
      else
        @tickets = @user.tickets.includes(:show) # Fetch tickets with show details
     end
  end
  
  def new
    @user = User.new
  end

  def edit
    if current_user != @user && current_user.username != 'Admin'
      flash[:alert] = "Access denied!"
      redirect_to home_index_path, notice: 'Access denied!'
    end
  end

  def create
    @user = User.new(user_params)

    # if user is signing up, create new session and auto-login and redirect to user home page
    # else if admin is creating new user, continue with the admin session, redirect to admin dashboard
    if current_user&.username != "Admin"
      if @user.save
        session[:user_id] = @user.id
        redirect_to home_index_path, notice: "Account created successfully!"
      else
        flash[:alert] = @user.errors.full_messages.join(", ")
        render :new
      end
    else
      if @user.save
        redirect_to admin_dashboard_path, notice: "User created successfully!"
      else
        flash[:alert] = @user.errors.full_messages.join(", ")
        render :new
      end
    end

    # respond_to do |format|
    #   if @user.save
    #     format.html { redirect_to @user, notice: "User was successfully created." }
    #     format.json { render :show, status: :created, location: @user }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @user.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  def update
    if @user.update(user_params)
      if current_user.username == "Admin"
        redirect_to admin_dashboard_path, notice: "User profile was successfully updated."
      else
        redirect_to @user, notice: "Profile was successfully updated."
      end
    else
      render :edit
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy!
    if current_user.username == "Admin"
      redirect_to admin_dashboard_path , status: :see_other, notice: "User was successfully destroyed."
    else
      redirect_to home_index_path , status: :see_other, notice: "User was successfully destroyed."
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
    redirect_to root_path, alert: "User not found" unless @user
  end

  def correct_user
    redirect_to root_path, alert: "Access denied!" unless @user == current_user
  end

  def user_params
    params.require(:user).permit(
      :name, :email, :phone_number, :address, :username, :password, :password_confirmation, :credit_card)
  end
end
