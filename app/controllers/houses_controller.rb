class HousesController < ApplicationController
  before_action :load_house, only: [:show]

  def new
    @house = House.new
  end

  def show
    @house
  end

  def create
    @house = House.new(house_params)
    if @house.save
      render @house
    else
      render json: {errors: @house.errors}
    end
  end

  private
  def house_params
    params.require(:house).permit("name,address,city,type,guest_count,bedroom_count,
                  bed_count,bathroom_count,introduce,map_url,checkin_from,checkout_to,active,owner_id")
  end

  def load_house
    @house = House.find(params[:id])
  end

end
