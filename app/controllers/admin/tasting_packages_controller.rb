module Admin
  class TastingPackagesController < ApplicationController
    
    before_filter :authenticate_user!
    before_filter :check_admin_status

    def index
      @packages = TastingPackage.includes(:wines)
    end

    def new
      @package = TastingPackage.new
    end

    def create
      if params[:wine_selection].present?
        @package = TastingPackage.create(tasting_package_params)
        @package.add_wines(params[:wine_selection])
      else
        flash[:error] = "Tasting packages cannot be created without a wine list."
      end
      redirect_to admin_tasting_packages_url
    end

    def show
      @package = TastingPackage.find(params[:id])
      @wine_list = WinePackage.wine_list(@package.id)
    rescue
      flash[:error] = "The package could not be found"
      redirect_to admin_tasting_packages_url
    end

    def edit
      @package = TastingPackage.includes(:wines).where(id: params[:id]).first
      raise ActiveRecord::RecordNotFound if @package.nil?
      @wine_list = WinePackage.wine_list(@package.id)
    rescue
      flash[:error] = "The package could not be found"
      redirect_to admin_tasting_packages_url
    end

    def update
      if params[:wine_selection].present?
        @package = TastingPackage.find(params[:id])
        @package.update_attributes(tasting_package_params)
        @package.add_wines(params[:wine_selection])
      else
        flash[:error] = "Tasting packages cannot be updated without a wine list."
      end
      redirect_to admin_tasting_packages_url
    end

    def destroy
      @package = TastingPackage.find(params[:id])
      @package.destroy
    rescue
      flash[:error] = "The package could not be found"
      redirect_to admin_tasting_packages_url
    end

    private
    def tasting_package_params
      params[:tasting_package].permit(:name, :price)
    end

  end
end