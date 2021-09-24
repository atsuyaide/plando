class TeamsController < ApplicationController
  before_action :require_user_logged_in

  def index
    @pagy, @teams = pagy(Team.order(id: :desc), items: 10)
  end
  
  def show
    redirect_to about_team_path
  end
  
  def new
    @team = Team.new
  end

  def create
    @team = current_user.teams.build(team_params)
    if @team.save
      flash[:success] = 'チームを作成しました。'
      @team.add_member(current_user)
      redirect_to @team
    else
      flash.now[:danger] = 'チームの作成に失敗しました。'
      render :new
    end
  end

  def destroy
    team = Team.find(params[:id])
    team.destroy
    flash[:success] = 'チームを削除しました。'
    redirect_to teams_path
  end
  
  def about
    @team = Team.find(params[:id])
    @pagy, @users = pagy(@team.members, items: 10)
  end
  
  def tasks
    @team = Team.find(params[:id])
    @pagy, @tasks = pagy(@team.tasks, items: 10)
  end
  
  private

  def team_params
    params.require(:team).permit(:name, :description)
  end
end
