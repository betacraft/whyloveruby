class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def twitter
    logger.info request.env["omniauth.auth"].inspect
    logger.info "*"*100
    # You need to implement the method below in your model
    @user = User.find_for_twitter_oauth(request.env["omniauth.auth"])
    
    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Twitter"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.twitter_data"] = request.env["omniauth.auth"]
      flash[:error] = "Error signing in !!"
      redirect_to root_path
    end
  end
    
end
