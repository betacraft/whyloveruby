class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def twitter
    # You need to implement the method below in your model

    @user = User.find_for_twitter_oauth(request.env["omniauth.auth"])
    
    if @user.persisted?
      flash[:notice] = t("flash.successful_sign_in")
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.twitter_data"] = request.env["omniauth.auth"]
      flash[:error] = t('flash.error_signing_in')
      redirect_to root_path
    end
  end

  def github
    @user = User.find_for_github_oauth(request.env["omniauth.auth"])
    if @user.persisted?
      flash[:notice] = t("flash.successful_sign_in_github")
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.github_data"] = request.env["omniauth.auth"]
      flash[:error] = t('flash.error_signing_in')
      redirect_to root_path
    end
  end
end