class UserServiceController < ApplicationController
  
  skip_before_filter :verify_authenticity_token

  def create
    UserCreateWorker.perform_async(create_user_params)
    render success: 200, nothing: true
  end

  private
  def create_user_params
    params.permit(customer: [:email, :first_name], line_items: [:name])
  end
end