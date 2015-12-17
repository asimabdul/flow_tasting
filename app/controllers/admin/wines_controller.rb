module Admin
  class WinesController < ApplicationController

    before_filter :authenticate_user!
    before_filter :check_admin_status

    def index
      @wines = Wine.all
    end

    def new
      @wine = Wine.new
    end

    def create
      Wine.create(wine_params)
      redirect_to admin_wines_url
    end

    def edit
      @wine = Wine.find(params[:id])
    end

    def update
      @wine = Wine.find(params[:id])
      @wine.update_attributes(wine_params)
      redirect_to admin_wines_url
    end

    def destroy
      @wine = Wine.find(params[:id])
      @wine.destroy
      redirect_to admin_wines_url
    end

    private
    def wine_params
      params[:wine].permit(:name, :region, :wine_type, :description, :fun_facts, :price, :producer, :vintage)
    end
  end
end
