class AuthenticationsController < ApplicationController

  # POST /authentications
  # POST /authentications.json
  def create
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'],omniauth['uid'])

    ### User had already been authenticated
    if authentication
      authentication.user.twitter_detail.update(TwitterDetail.omniauth_attributes(omniauth))
      flash[:notice] = "Sign in Successful"
      login(authentication.user)
      redirect_to :new_scan

    ### User needed authenticating but was signed in
    elsif current_user
      current_user.authentications.create!(provider: omniauth['provider'],uid: omniauth['uid'])
      user.twitter_detail.update(TwitterDetail.omniauth_attributes(omniauth))
      flash[:notice] = "Sign in Successful"
      redirect_to :new_scan

    ### User needed authenticating and wasn't signed in yet
    else
      user = User.new(User.omniauth_attributes(omniauth))
      user.authentications.build(provider: omniauth['provider'],uid: omniauth['uid'])
      user.twitter_detail = TwitterDetail.new(TwitterDetail.omniauth_attributes(omniauth))
      if user.save
        flash[:notice] = "Sign up Successful"
        login(user)
        redirect_to :new_scan
      else
        flash[:alert] = "Sign up Unsuccessful. Please try again."
        redirect_to :log_in
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_authentication
    @authentication = Authentication.find(params[:id])
  end
end
