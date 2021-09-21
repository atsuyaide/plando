class TeamsController < ApplicationController
  before_action :require_user_logged_in

  def index
    @pagy, @teams = pagy(Team.order(id: :desc), items: 10)
  end
  
  def show
    @team = Team.find(params[:id])
    @pagy, @users = pagy(@team.members, items: 10)
  end

  def create
    @team = current_user.teams.build(team_params)
    if @team.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      @pagy, @teams = pagy(current_user.teams.order(id: :desc))
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'toppages/index'
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
    params.require(:team).permit(:content)
  end
end
