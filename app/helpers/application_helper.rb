module ApplicationHelper
  include Pagy::Frontend
  
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !!current_user
  end
  
  def active_page?(path)
    if request.path == path
      return 'active'
    else
      return ''
    end
  end
end
