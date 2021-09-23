class UserTeamsController < ApplicationController
  def create
    name = params[:user_team][:name]
    user = User.find_by(name: name)
    team = Team.find(params[:team_id])
    
    if name == ''
      flash[:danger] = "ユーザー名を入力してください。"
    elsif user.nil?
      flash[:danger] = name + 'は存在しないユーザーです。'
    elsif team.member?(user)
      flash[:danger] = user.name + 'は既にチームメンバーです。' 
    else
      team.add_member(user)
      flash[:success] = user.name + 'を追加しました。'
    end
      
    redirect_to team
  end

  def destroy
    user = User.find(params[:user_id])
    team = Team.find(params[:team_id])
    if team.member?(user)
      team.remove_member(user)
      flash[:danger] = user.name + 'を削除しました。'
    else
      flash[:success] = user.name + 'はチームメンバーではありません。' 
    end
    redirect_to team
  end
end
