module Api
  class TasksController < ApplicationController
    before_action :admin_user?, only: [:create, :assign_task]

    def create
      if admin_user?
        @task = Task.new(tasks_params)
        @task.created_by = @user
        @task.save!

        render :json => @task.attributes, status: :created
      else
        render :json => { errors: "no access" }, status: :unauthorized
      end
    end

    def assign
      if admin_user?
        @task = Task.find(params[:id])
        member_user = User.find(assign_task_params[:user_id])
        if member_user.member?
          @task_assignment = member_user.task_assignments.create(task: @task, assigned_by: @user)
          render :json => @task.attributes, status: :ok
        else
          render :json => { errors: "can not assign task to non-member" }, status: :unprocessable_entity
        end
      else
        render :json => { errors: "no access" }, status: :unauthorized
      end
    end

    def complete
      if member_user?
        @task = Task.find(params[:id])
        @task_assignment = @user.task_assignments.find_by(task_id: @task.id)
        @task_assignment.completed = true
        @task_assignment.save!
        render :json => @task.attributes, status: :ok
      else
        render :json => { errors: "no access" }, status: :unauthorized
      end
    end

    private

    def tasks_params
      params.require(:task).permit(:title, :description)
    end

    def assign_task_params
      params.require(:task).permit(:user_id)
    end

    def authenticate_user
      @user = authenticate_and_get_user(request.headers["Authorization"])
    end
    def admin_user?
      authenticate_user
      @user.admin?
    end

    def member_user?
      authenticate_user
      @user.member?
    end
  end
end
