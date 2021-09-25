class ApplicationController < ActionController::Base
  include Pagy::Backend
  include SessionsHelper
  
  private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def editable_user?
    @task = Task.find(params[:id])
    unless @task.user_id == current_user.id or current_user.allteams.ids.include?(@task.team_id)
      flash[:danger] = 'アクセス権限がありません。'
      redirect_to root_url
    end
  end
end
