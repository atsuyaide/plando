class UserTeamsController < ApplicationController
  def create
    name = params[:user_team][:name]
    user = User.find_by(name: name)
    team = Team.find(params[:team_id])
    unless user.nil?
      if team.member?(user)
        flash[:success] = user.name + 'は既にチームメンバーです。' 
      else
        team.add_member(user)
        flash[:success] = user.name + 'を追加しました。'
      end
    else
      flash[:danger] = name + 'は存在しないユーザーです。'
    end
      
    redirect_to team
  end

  def destroy
    user = User.find_by(name: params[:name])
    team = Teams.find(params[:id])
    if team.member?(user)
      team.remove_member(user)
      lash[:danger] = user.name + 'を削除しました。'
    else
      flash[:success] = user.name + 'はチームメンバーではありません。' 
    end
    redirect_to team
  end
end
