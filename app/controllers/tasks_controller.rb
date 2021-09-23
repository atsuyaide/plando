class TasksController < ApplicationController
  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'タスクを投稿しました。'
      redirect_to request.referer
    else
      flash.now[:danger] = 'タスクの投稿に失敗しました。'
      render request.referer
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
    params.require(:task).permit(:title, :content, :status, :deadline)
  end
end
