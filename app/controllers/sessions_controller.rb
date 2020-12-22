class SessionsController < ApplicationController
  before_action :set_current_user, only: %i[logged_in]

  def create
    @user = User
      .find_by(email: params['user']['email'])
      .try(:authenticate, params['user']['password'])

    if @user
      session[:user_id] = @user.id
      render json: {
        status: :created,
        logged_in: true,
        user: @user,
        session: session
      }
    else
      render json: {
        status: 401,
        logged_in: false,
        user: nil
      }
    end
  end

  def logged_in
    render json: {
      logged_in: 'logged_in',
      session: session
    }
  end

  def logout
    reset_session
    render json: {
      status: 200,
      logged_out: true
    }
  end

  private

  def set_current_user; end
end
