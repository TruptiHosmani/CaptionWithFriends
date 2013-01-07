module SessionsHelper
  def sign_in(user)
    logger.debug "sign_in called"
    logger.debug user
    cookies.permanent[:remember_token] = user.remember_token
    current_user= user
  end

  def signed_in?
    logger.debug "signed_in? called"
    if (@current_user.nil?)
      logger.debug "current user is Nil"
    end


    !current_user.nil?
  end

  def current_user=(user)
    logger.debug "current_user= called"

    @current_user = user
  end

  def current_user?(user)
    user == current_user
  end

  def current_user
    logger.debug "current_user called"
    @current_user ||= user_from_remember_token

  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_path, notice: "Please sign in."
    end
  end

  def sign_out
    current_user = nil
    cookies.delete(:remember_token)
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end

  def store_location
    session[:return_to] = request.fullpath
  end

  private

  def user_from_remember_token
    remember_token = cookies[:remember_token]
    User.find_by_remember_token(remember_token) unless remember_token.nil?
  end


   def clear_return_to
      session.delete(:return_to)
    end
end
