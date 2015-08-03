class Card < ActiveRecord::Base
  has_many :donations

  validates :number, presence: true
  validates :expiration_month, presence: true
  validates :expiration_year, presence: true
  validates :verification_code, presence: true
  validates :name, presence: true

  validate :check_valid

  def check_valid
    valid = self.is_valid?
    errors.add(:base, "The provided credit card information is invalid") unless valid
    valid
  end

  def is_valid?
    ActiveMerchant::Billing::CreditCard.new(
        number: number,
        verification_value: verification_code,
        month: expiration_month.to_i,
        year: expiration_year.to_i,
        first_name: first_name,
        last_name: last_name
    ).valid?
  end

  def stripe_source
    source = {
        :object => "card",
        :number => number,
        :exp_month => expiration_month.to_i,
        :exp_year => expiration_year.to_i,
        :cvc => verification_code,
        :name => name
    }
    source
  end

  def first_name
    name.split(" ").first unless name.blank?
  end

  def last_name
    names = name.split(" ")
    names.last unless names.length < 2
  end

  def last_four_digits
    number[-4..-1] unless number.blank?
  end
end
