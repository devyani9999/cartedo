module Api
  class UsersController < ApplicationController
    include TokenGenerator

    def create
      @user = User.new(sanitize_user_params)
      @user.password = sanitize_user_params[:password]
      if @user.save!
        token = TokenGenerator.generate_token(@user.attributes)
        @user.update_attribute('token', token)
        render :json => @user.attributes.except(:password_digest), status: :created
      else
        render :json => { errors: "Information incorrect" }, status: :unprocessable_entity
      end
    end

    def login
      @user = User.find_by_email(login_params[:email])
      if @user.password == login_params[:password]
        render :json => @user.token, status: :ok
      else
        render :json => { errors: "Incorrect credentials" }, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.require(:user).permit(:name, :email, :password, :role)
    end

    def sanitize_user_params
      user_params[:role] = User.roles[user_params[:role]]
    end

    def login_params
      params.require(:user).permit(:email, :password)
    end
  end

end