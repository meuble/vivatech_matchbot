class Api::V1::DataController < ApplicationController
  def create
    permitted_params = data_params
    @datum = Datum.new(permitted_params)
    if @datum.save
      render json: @datum.as_json(data_controlled_json_attributes), status: :created
    else
      render json: {errors: @datum.errors}, status: :bad_request
    end
  end

private
  def data_params
    params.permit(:skin_type, :prefered_color, :prefered_scent, :prefered_brand, :age_group)
  end

  def data_controlled_json_attributes
    { 
      only: [:id, :skin_type, :prefered_color, :prefered_scent, :prefered_brand, :age_group]
    }
  end
  
end
