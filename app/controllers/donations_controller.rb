class DonationsController < ApplicationController
  def new
    @donation = Donation.new
  end

  def create

  end

  def receipt
    @donation = Donation.find(params[:id])
  end
end
