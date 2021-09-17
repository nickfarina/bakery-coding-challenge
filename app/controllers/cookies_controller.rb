class CookiesController < ApplicationController
  before_action :authenticate_user!

  def new
    if oven.cookies.any?
      redirect_to oven, alert: 'Something is already in the oven!'
    else
      @cookie = Cookie.new(storage: oven)
    end
  end

  def create
    cookies = batch_size.times.map do
      Cookie.create!(cookie_create_params)
    end

    CookCookiesJob.perform_later(cookies)

    redirect_to oven_path(oven)
  end

  private

  def oven
    @oven ||= current_user.ovens.find_by!(id: params[:oven_id])
  end

  def batch_size
    params[:batch_size].to_i
  end

  def cookie_create_params
    cookie_params.merge({ storage: oven })
  end

  def cookie_params
    params.permit(:fillings)
  end
end
