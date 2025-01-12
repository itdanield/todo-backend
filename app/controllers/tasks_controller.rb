class TasksController < ApplicationController
    def index
      render json: Task.all
    end
  
    def create
      task = Task.new(task_params)
      if task.save
        render json: task, status: :created
      else
        render json: task.errors, status: :unprocessable_entity
      end
    end
  
    def update
      task = Task.find(params[:id])
      if task.update(task_params)
        render json: task
      else
        render json: task.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      task = Task.find(params[:id])
      task.destroy
      head :no_content
    end
  
    private
  
    def task_params
      params.require(:task).permit(:text, :completed)
    end
  end
  