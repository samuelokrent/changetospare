class Donation < ActiveRecord::Base
  belongs_to :charity
  belongs_to :card
end
