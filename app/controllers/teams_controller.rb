class TeamsController < ApplicationController
  before_action :require_user_logged_in

  def index
    @pagy_1, @teams = pagy(Team.order(id: :desc), items: 10)
  end
  
  def show
    @team = Team.find(params[:id])
    @pagy_1, @users = pagy(@team.members, items: 10)
    @pagy_2, @tasks = pagy(@team.tasks, items: 10)
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
  
  private

  def team_params
    params.require(:team).permit(:name, :description)
  end
end
