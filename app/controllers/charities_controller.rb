class CharitiesController < ApplicationController
  def show
    @charity = Charity.find(params[:id])
  end

  def index
    @charities = Charity.all
  end
end
