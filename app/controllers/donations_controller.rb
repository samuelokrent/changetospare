require "active_merchant/billing/rails"
class DonationsController < ApplicationController
  def new
    @donation = Donation.new
  end

  def create
    @donation = Donation.new(donation_params)
    @card = Card.new(card_params)
    @card.expiration_year = "20#{@card.expiration_year}" if @card.expiration_year.length == 2

    all_valid = @donation.valid? && @card.valid?

    if all_valid
      @card.save
      @donation.card = @card
      @donation.save
      if @donation.charge
        render 'receipt'
      else
        flash.now[:error] = "Payment Failed"
        render 'new'
      end
    else
      render 'new'
    end
  end

  def receipt
    @donation = Donation.find(params[:id])
  end

  def donation_params
    params.require(:donation).permit(:amount, :charity_id)
  end

  def card_params
    params.require(:card).permit(:number, :expiration_month, :expiration_year, :name, :verification_code)
  end
end
