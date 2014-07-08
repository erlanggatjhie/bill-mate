class Tenant < ActiveRecord::Base
  belongs_to :accomodation
  has_secure_password

  validates :first_name, presence: true, length: { maximum: 15 }
  validates :last_name, presence: true, length: { maximum: 15 }
  validates :email_address, format: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/, uniqueness: true
  validates :password, length: { minimum: 8 }

  def self.authenticate(email_address, password)
    Tenant.find_by(email_address: email_address).try(:authenticate, password)
  end
end