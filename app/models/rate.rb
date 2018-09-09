class Rate < ApplicationRecord
  def self.find_by_period(period)
    period_size = period.length
    query = none
    query = where(rate_period: Date.parse(period[0])..Date.parse(period[1])) if period_size == 2
    query = where(rate_period: Date.parse(period[0])) if period_size == 1
    query
  end
end
