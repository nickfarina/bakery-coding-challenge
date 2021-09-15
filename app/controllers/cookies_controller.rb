class CookiesController < ApplicationController
  before_action :authenticate_user!

  def new
    @oven = current_user.ovens.find_by!(id: params[:oven_id])
    if @oven.cookies.any?
      redirect_to @oven, alert: 'Something is already in the oven!'
    else
      @cookie = Cookie.new(storage: @oven)
    end
  end

  # TODO:
  def create
    @oven = current_user.ovens.find_by!(id: params[:oven_id]) # TODO: should params be accessed directly here?

    batch_size = params[:batch_size]
    batch_size.to_i.times do
      Cookie.create!(cookie_params.merge({ storage: @oven })) # TODO: i think this can reduced to a single sql call
    end

    redirect_to oven_path(@oven)
  end

  private

  def cookie_params
    params.permit(:fillings)
  end
end
