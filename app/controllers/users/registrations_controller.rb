module Users
  class RegistrationsController < Devise::RegistrationsController
     http_basic_authenticate_with name: "app_admin", password: "asdfgh123", only: :new
  end
end