class UsersController < ApplicationController

  # GET /users/new
  def new
    @user = User.new
  end

  def create
    @user = User.new(email: user_params[:email])
    if @user.save
      session[:user_id] = @user.id
      redirect_to '/auth/twitter'
    else
      redirect_to({action: 'new'}, alert: "Your email could not be processed. Please try again.")
    end

  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:email)
  end
end
