class UserCreateWorker
  include Sidekiq::Worker

  def perform(params)
    return if params.empty?
    user = process_user(params["customer"])
    packages = params["line_items"]
    #customer could have bought multiple packages. create events for each
    packages.each do |package_data|
      tasting_package = TastingPackage.find_by_name(package_data["name"])
      ApplicationMailer.make_event_notification(TastingPackage.last, user).deliver_later if tasting_package
    end
  end

  private
  def process_user(params)
    user = User.find_or_initialize_by(email: params["email"])
    if user.new_record?
      user.first_name = params["first_name"]
      user.last_name = params["last_name"]
      user.save(validate: false)
    end 
    user
  end

end