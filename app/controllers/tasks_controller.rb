class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy,:show]

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to @task
    else
      @tasks = current_user.tasks.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'toppages/index'
    end
  end
  def show 
    
  end
  
  def edit
    @task = Task.find(params[:id])
  end
  
  def index
   @tasks = Task.all.page(params[:page])
  end

  def destroy
    @task.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end
  
  def update
    @task = current_user.tasks.find(params[:id])
    # binding.pry
    
    if @task.update(task_params)
      flash[:success] = 'メッセージ は正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'メッセージ は更新されませんでした'
      render :edit
    end
  end


  private

  
  def task_params
    params.require(:task).permit(:content,:status)
  end  
     
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
end