class Donation < ActiveRecord::Base
  belongs_to :charity
  belongs_to :card
  validates :amount, presence: true, numericality: { greater_than: 0.50 }

  scope :processed, -> {
    where(status_cd: 'processed')
  }

  def set_status(success)
    self.status_cd = success ? "processed" : "failed"
    self.save
  end

  def self.stripe_api_key
    if Rails.env.production?
      "sk_live_PleWBoeAauuJYiVrCAbIRlkG"
    else
      "sk_test_aJFE3hqr4rF0XjYEafFDbSsM"
    end
  end

  def charge
    Stripe.api_key = Donation.stripe_api_key

    response = Stripe::Charge.create(
        :amount => self.amount_in_cents,
        :currency => "usd",
        :source => self.card.stripe_source
    )
    begin
      response = Stripe::Charge.create(
          :amount => self.amount_in_cents,
          :currency => "usd",
          :source => self.card.stripe_source
      )
    rescue Stripe::CardError => e
      puts "Card Error"
      self.status_cd = "failed"
      self.errors.add(:payment, e.json_body[:error][:message])
      response = nil
    rescue => e
      puts "Exception in charge_donation: #{e.message}"
      self.status_cd = "failed"
      self.errors.add(:payment, "Payment Failed")
      response = nil
    else
      puts "Processed"
      self.status_cd = "processed"
    end
    self.save(validate: false)
    return response
  end

  def amount_in_cents
    (amount.to_f * 100).to_i
  end

  def display_amount
    amt_str = amount.to_s.split(".")
    if amt_str.length == 2 && amt_str[1].length == 1
      amt_str[1] += "0"
    end
    amt_str.join(".")
  end

  def self.display_amount(amt)
    amt_str = amt.to_s.split(".")
    if amt_str.length == 2 && amt_str[1].length == 1
      amt_str[1] += "0"
    end
    amt_str.join(".")
  end
end
