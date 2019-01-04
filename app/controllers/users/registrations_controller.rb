# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]
  before_action :authenticate_user!

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    super
  end

  # PUT /resource
  def update
    super
    # if user.id == current_user.id
    @user = User.find(current_user.id)
    # @user.genre = params[:user][:genre]
    # @user.area = params[:user][:area]
    # @user.profile = params[:user][:profile]
    # @user.gender = params[:user][:gender]
    # @user.waiting = params[:user][:waiting]
    # @user.part = params[:user][:part]
    
    if params[:user][:icon]
      @user.icon = "#{@user.id}.jpg"
      image = params[:user][:icon]
      File.binwrite("public/user_icon/#{@user.icon}", image.read)
      @user.save
    end
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_type])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:attribute, :name, :banmas_id, :profile, :genre, :email, :password, :icon, :area, :gender, :waiting, :part, {images: []}])
  end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
 
    def after_sign_up_path_for(resource)
       edit_user_registration_path
    end
  
    def after_inactive_sign_up_path_for(resource)
      edit_user_registration_path
    end
   
    def after_update_path_for(resource)
      user_path(resource)
    end
  
end
