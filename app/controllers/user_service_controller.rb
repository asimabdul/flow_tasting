class UserServiceController < ApplicationController
  
  skip_before_filter :verify_authenticity_token

  def create
    user = User.new(create_user_params)
    user.save(validate: false)
    if user.persisted?
      render json: {message: "User -- #{user.email} created", error: nil}, status: :created
    else
      render json: {message: nil, error: "User could not be created. Please check your inputs."}, status: :bad_request
    end
  rescue ActiveRecord::RecordNotUnique
    render json: {message: nil, error: "User -- #{user.email} already exists"}, status: :bad_request
  end

  private
  def create_user_params
    params[:user].permit(:first_name, :last_name, :email)
  end
end