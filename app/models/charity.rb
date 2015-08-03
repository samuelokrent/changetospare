class Charity < ActiveRecord::Base
  has_many :donations

  def total_donations
    sum = 0.0
    self.donations.processed.each do |d|
      sum += d.amount
    end
    sum
  end
end
