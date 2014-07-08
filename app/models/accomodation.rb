class Accomodation < ActiveRecord::Base
  has_many :tenants

  validates :address_line, presence: true
  validates :city, presence: true
  validates :postcode, format: /[0-9][0-9][0-9][0-9]/
  validates :state, inclusion: { in: %w(NSW ACT VIC QLD SA WA TAS NT) }
end
