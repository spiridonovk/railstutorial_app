module SessionsHelper

  # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
     @current_user ||= User.find_by(id: session[:user_id])
  end
   # Запоминает пользователя в постоянную сессию.
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  #Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

   # Returns the current logged-in user (if any).
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
   # Logs out the current user.
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
  # Забывает постоянную сессии.
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Осуществляет выход текущего пользователя.
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
end

