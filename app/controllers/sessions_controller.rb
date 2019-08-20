class SessionsController < ApplicationController
  skip_before_action :require_login
  def new
  end

  def create
    user = User.find_by(name: session_params[:name])

    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to tasks_path
    else
      render :new
    end

  end

  def destroy
    reset_session
    redirect_to tasks_path
  end

  private

  def session_params
    params.require(:session).permit(:name, :password)
  end

end
