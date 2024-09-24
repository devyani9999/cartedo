module Api
  class TaskAssignmentsController < ApplicationController
    before_action :authenticate_user, only: [:index]

    def index
      render :json => @user.task_assignments, status: :ok
    end

    def authenticate_user
      @user = authenticate_and_get_user(request.headers["Authorization"])
    end
  end
end
