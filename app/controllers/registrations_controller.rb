class RegistrationsController < ApplicationController
  def create
    user = User.new(
      email: params['user']['email'],
      password: params['user']['password'],
      password_confirmation: params['user']['password_confirmation']
    )

    user.save!
    session[:user_id] = user.id
    render json: {
      status: 'created',
      user: user
    }
  rescue ActiveRecord::RecordInvalid
    render json: {
      status: 'unprocessable_entity'
    }
  end
end
