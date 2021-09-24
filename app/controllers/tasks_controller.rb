class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :editable_user?
  
  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'タスクを投稿しました。'
    else
      flash[:danger] = 'タスクの投稿に失敗しました。'
    end
    
    if @task.team_id.nil?
      redirect_to tasks_user_path(current_user.id)
    else
      redirect_to tasks_team_path(@task.team_id)
    end
  end
  
  def show
    @task = Task.find(params[:id])
    if @task.team_id.nil?
     redirect_to tasks_user_path(current_user.id)
    else
     redirect_to tasks_team_path(@task.team_id)
    end
  end
  
  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])

    if @task.update(task_params)
      flash[:success] = 'Taskは正常に更新されました'
      if @task.team_id.nil?
       redirect_to tasks_user_path(current_user.id)
      else
       redirect_to tasks_team_path(@task.team_id)
      end
    else
      flash.now[:danger] = 'Taskは更新されませんでした'
      render :edit
    end
  end

  def delete
  end
  
  private

  def task_params
    params.require(:task).permit(:title, :content, :status, :deadline, :team_id)
  end
  
  def editable_user?
    @task = Task.find(params[:id])
    unless @task.user_id == current_user.id or current_user.teams.ids.include?(@task.team_id)
      flash[:danger] = 'アクセス権限がありません。'
      redirect_to root_url
    end
  end
end
