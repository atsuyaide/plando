class TasksController < ApplicationController
  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'タスクを投稿しました。'
      if @task.team_id.nil?
        redirect_to tasks_user_path(current_user.id)
      else
        redirect_to tasks_team_path(@task.team_id)
      end
    else
      flash[:danger] = 'タスクの投稿に失敗しました。'
      if @task.team_id.nil?
        redirect_to tasks_user_path(current_user.id)
      else
        redirect_to tasks_team_path(@task.team_id)
      end
    end
  end
  
  def edit
  end

  def update
  end

  def delete
  end
  
  private

  def task_params
    params.require(:task).permit(:title, :content, :status, :deadline, :team_id)
  end
end
