class SessionsController < ApplicationController

  # GET /users/new
  def new
    
  end

  # DELETE /users/1
  def destroy
    logout
    redirect_to root_path
  end

end
