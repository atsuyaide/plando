class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  
  def index
    @pagy, @users = pagy(User.order(id: :desc), items: 10)
  end

  def show
    unless current_user.id.to_s == params[:id]
      flash[:danger] = '他ユーザーのページにはアクセスできません。'
      redirect_to user_path(current_user.id)
    end
    redirect_to about_user_path(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def about
    @user = User.find(params[:id])
    @pagy, @teams = pagy(@user.teams, items: 10)
  end
  
  def tasks 
    @user = User.find(params[:id])
    @pagy, @tasks = pagy(@user.tasks, items: 10)
  end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
